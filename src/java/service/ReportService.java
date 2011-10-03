/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import com.lowagie.text.DocumentException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.ArrayList;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.html.simpleparser.HTMLWorker;
import com.lowagie.text.html.simpleparser.StyleSheet;
import com.lowagie.text.pdf.PdfWriter;
import java.io.File;
import java.math.BigDecimal;

/**
 *
 * @author user
 */
public class ReportService {
    private Connection conn;
    private ArrayList<Integer> pollIDs;
    private ArrayList<Integer> questIDs;
    private String type;
    private String graph_type;
    private BigDecimal pollID;
    private BigDecimal qid;
    private String value;
    private BigDecimal userName = new BigDecimal(-1);
    private String comparison;
    private ArrayList<String> location;
    private String reportDes = "webapps/Andy/reports/";
    private static final String sqlLocation[] = {"country","state","city","suburb","street", "unit"};



    public ReportService(String type){
        this.type = type;
    }
    //all
    public ReportService(BigDecimal pollID, String type, String gtype){
        this.type = type;
        this.pollID = pollID;
        this.graph_type = gtype;
    }
    //for demo and non demo.
    public ReportService(BigDecimal pollID, String type, String gtype, BigDecimal qid,
            String value){
        this.type = type;
        this.pollID = pollID;
        this.qid = qid;
        this.value = value;
        this.graph_type = gtype;
    }
    //for location 
    public ReportService(BigDecimal pollID, String type, String gtype, 
            String comparison, ArrayList<String> location){
        this.type = type;
        this.pollID = pollID;
        this.comparison = comparison; //certain or anything else
        this.graph_type = gtype;
        this.location = location;
    }
    //individual
    public ReportService(BigDecimal pollID, String type, String gtype, BigDecimal userName){
        this.type = type;
        this.pollID = pollID;
        this.userName = userName;
        this.graph_type = gtype;
    }
   
    private Connection getOracleConnection() {

        conn=null;
        try {
            /* Load the Oracle JDBC Driver and register it. */
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            /* Open a new connection */
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "19880117");
        } catch(Exception ex){
            System.out.println(ex.toString());
        }
        return conn;
    }

    private void closeOracleConnection() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    
     // for Location Report
    private String statementGenerator(){
        
        String statement = "";
        if(this.comparison.equals("N")){ // for no comparison
            statement = "SELECT COUNT(r.userID), a.answer AS subcategory";
            statement += " FROM MultiResponses r, Answers a, pollLocation p where" +
                                " r.questID=$P{questID} AND r.answerID=a.answerID AND p.plID=r.plID";
            for(int i=0; i<location.size();i++){
                String temp = " AND ";
                temp += "p." + sqlLocation[i] + "='" + location.get(i) + "'";
                statement += temp;
            }
            statement += " GROUP BY a.answer";
        }
        else{ // for comparison
            if(location.size()<sqlLocation.length){
                String category = sqlLocation[location.size()];
                statement = "SELECT COUNT(r.userID), a.answer AS subcategory, ";
                statement += "p." + category; //put in the category to divide. eg.country, city and suburb.
                statement += " AS category FROM MultiResponses r, Answers a, pollLocation p where" +
                                " r.questID=$P{questID} AND r.answerID=a.answerID AND p.plID=r.plID";
                for(int i=0; i<location.size();i++){
                    String temp = " AND ";
                    temp += "p." + sqlLocation[i] + "='" + location.get(i) + "'";
                    statement += temp;
                }
                statement += " GROUP BY a.answer, ";
                statement += "p." + category;
            }
        }
        
        return statement;
    }
    
    public String generateReport() throws JRException{

        
                
       
        File file = new File("");
        String absolutePath = file.getAbsolutePath();
        absolutePath = absolutePath.substring(0, absolutePath.length()-3); //tomcat folder
        String filePath = "webapps/Andy/templates/";
        JasperReport jasperReport;
        JasperPrint jasperPrint = null;
        Connection connection = getOracleConnection();
        HashMap jasperParameter = new HashMap();
        jasperParameter.put("tomcatPath",absolutePath+filePath);
        if(this.type.equals("system")){
            
            filePath += "System Utilisation.jrxml";
            this.reportDes += "System Utilisation.pdf";
        }
        else if(type.equals("session")){
          
            filePath += "Session History Report.jrxml";
            this.reportDes += "Session History Report.pdf";
        }
        else if(type.equals("individual")){
          
            filePath += "Statistical Report.jrxml";
            jasperParameter.put("gtype",this.graph_type);
            jasperParameter.put("pollID",this.pollID);
            jasperParameter.put("user",this.userName);
            this.reportDes += "Statistical Report.pdf";
        }
        else if(type.equals("statistical_all")){
           
            filePath += "Statistical Report_all.jrxml";
            jasperParameter.put("gtype",this.graph_type);
            jasperParameter.put("pollID",this.pollID);
            this.reportDes += "Statistical Report.pdf";
        }
        else if(type.equals("statistical_demo")){
            filePath += "Statistical Report_demo.jrxml";
            jasperParameter.put("gtype",this.graph_type);
            jasperParameter.put("pollID",this.pollID);
            jasperParameter.put("demographic",this.qid);
            this.reportDes += "Statistical Report.pdf"; 
        }
        else if(type.equals("location")){
            String sql = statementGenerator();
            if(this.comparison.equals("Y")){
                filePath += "Statistical Report_location_Y.jrxml";
            }
            else{
                filePath += "Statistical Report_location_N.jrxml";
                jasperParameter.put("gtype",this.graph_type);
            }
            jasperParameter.put("sql", sql);
            jasperParameter.put("pollID",this.pollID);
            this.reportDes += "Statistical Report.pdf"; 
        }
        else{
            this.reportDes += "Statistical Report.pdf";
            jasperParameter.put("gtype",this.graph_type);
            jasperParameter.put("pollID",this.pollID);
            jasperParameter.put("demographic",this.qid);            
            jasperParameter.put("demo_value",this.value);
            filePath += "Statistical Report.jrxml";
        }
        
        jasperReport = JasperCompileManager.compileReport(absolutePath+filePath);
        jasperPrint = JasperFillManager.fillReport(jasperReport,jasperParameter, connection);
        // 1- export to PDF
        JasperExportManager.exportReportToPdfFile(jasperPrint,absolutePath + this.reportDes);
        
         // 2- export to HTML
        // JasperExportManager.exportReportToHtmlFile(jasperPrint, 
           // "C://Users/user/Documents/NetBeansProjects/WebApplication3/web/System Utilisation.html" );
        // 3- export to Excel sheet

        //JRXlsExporter exporter = new JRXlsExporter();
        //exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
        //exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, 
           // "C://Users/user/Documents/NetBeansProjects/WebApplication3/src/java/templates/System Utilisation.jrxml" );
        //exporter.exportReport();
      /*  Document document = new Document();
        StyleSheet st = new StyleSheet();
        st.loadTagStyle("body", "leading", "16,0");
        PdfWriter.getInstance(document, new FileOutputStream(reportDes));
        document.open();
        ArrayList p = HTMLWorker.parseToList(new FileReader("C://Users/user/Documents/NetBeansProjects/WebApplication3/web/System Utilisation.html"), st);
        for (int k = 0; k < p.size(); ++k)
        document.add((Element) p.get(k));
        document.close();
       * 
       */
        // open it up!!
        closeOracleConnection();
        /*try{
            Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler " +
                    this.projectPath +this.reportDes);

        }catch (Exception e){
            System.out.println("Error" + e );  //print the error
        }
        */
        return "Report has been successfully generated.";
    }
    
   public static void main(String[] args)throws JRException{
   
        /*ArrayList<String> ttemp = new ReportService("session").getPollIDs(2);
        System.out.print(ttemp);
        System.out.print("\n");
        ArrayList<String> temp = new ReportService("session").getDemographicQuestions(10);
        System.out.print(temp);
        System.out.print("\n");
        ArrayList<String> temp1 = new ReportService("session").getDemographicAnswers(18);
        System.out.print(temp1); // gender question.
        System.out.print("\n");
        //ArrayList<String> temp2 = new ReportService("session").getDemographicAnswers(19);
       // System.out.print(temp2); // occupation one.
        //System.out.print("\n");
        ArrayList<String> temp3 = new ReportService("session").getLocations(1);
        System.out.print(temp3); // occupation one.
        System.out.print("\n");
        ArrayList<String> temp4 = new ReportService("session").getUsers(1);
        System.out.print(temp4); // occupation one.
        System.out.print("\n");
     */
       
       //new ReportService(new BigDecimal(10), "statistical", "Bar", new BigDecimal(37), "s").generateReport();
       ArrayList<String> input = new ArrayList<String>();
       input.add("Australia");
       input.add("QLD");
       input.add("Sydney");
       input.add("Sherrwood");
       System.out.print(new ReportService(new BigDecimal(10), "statistical_location", "b", "Y", input).statementGenerator());
       //new ReportService("system").generateReport();
   
   
   
   }
    
}
