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
    private String userName = "";
    
    private static final String projectPath = "C://Documents and Settings" +
            "/s4217258/My Documents/Dropbox/uni/csse3004/private/Indiv/indiv/";
    private String reportPath = "src/java/templates/";
    private String reportDes = "web/reports/";



    public ReportService(String type){
        this.type = type;
    }
    //for demo and non demo.
    public ReportService(BigDecimal pollID, String type, String gtype, BigDecimal qid, String value){
        this.type = type;
        this.pollID = pollID;
        this.qid = qid;
        this.value = value;
        this.graph_type = gtype;
    }
    //individual
    public ReportService(BigDecimal pollID, String type, String gtype, String userName){
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
            conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "s4217258", "password");
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
    
    public boolean IsInBound(Point p){
        Point[] bound = getBound();
        if ( bound[0].lat<p.lat && p.lat<bound[1].lat &&
            bound[0].lng<p.lng && p.lng<bound[1].lng){

            return true;
        }
        return false;
    }

    public Point[] getBound(){

        Point[] bound = new Point[2];
        //bound[0] = sw
        //bound[1] = ne

        return bound;

    }


    public String getUserIDsByLocation(){

        try {
            int size = 0;
            String returnResults = "";
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT u.location"
                    + ", u.userID FROM Users u, Attendance a"
                    + " WHERE a.pollID=? AND u.userID=a.userID");
        statement.setInt(1, this.pollID.intValue());
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
                String temp_location = resultSet.getString("location");
                String[] temp_lat_lng = temp_location.split(",");
                Point point = new Point(Double.parseDouble(temp_lat_lng[0]),
                        Double.parseDouble(temp_lat_lng[1]));
                if(IsInBound(point)){
                    int temp_userIDs = resultSet.getInt("userID");
                    if(size==0){
                        returnResults += "'"+temp_userIDs+"'";
                        size++;
                    }
                    else{
                        returnResults += ",'"+temp_userIDs+"'";

                    }
                }
            }
            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getUserIDsByLocation(): " + e.toString());
            return null;
        }







    }




    
    public String generateReport() throws JRException{

        
                
        
        
        JasperReport jasperReport;
        JasperPrint jasperPrint = null;
        Connection connection = getOracleConnection();
        HashMap jasperParameter = new HashMap();
        if(this.type.equals("system")){
            this.reportPath += "System Utilisation.jrxml";
            this.reportDes += "System Utilisation.pdf";
        }
        else if(type.equals("session")){
            this.reportPath += "Session History Report.jrxml";
            this.reportDes += "Session History Report.pdf";
        }
        else{
            this.reportPath += "Statistical Report.jrxml";
            this.reportDes += "Statistical Report.pdf";
            jasperParameter.put("gtype",this.graph_type);
            jasperParameter.put("pollID",this.pollID);
            jasperParameter.put("demographic",this.qid);
            jasperParameter.put("demo_value",this.value);
            if(!this.userName.equals("")){
                jasperParameter.put("user",this.userName);
            }

        }
        
        jasperReport = JasperCompileManager.compileReport(this.projectPath+this.reportPath);
        jasperPrint = JasperFillManager.fillReport(jasperReport,jasperParameter, connection);
        // 1- export to PDF
        JasperExportManager.exportReportToPdfFile(jasperPrint, this.projectPath+this.reportDes);
        
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

    public ArrayList<String> getPollIDs(int userID){
         try {
           ArrayList<String> returnResults = new ArrayList<String>();
           getOracleConnection();
           PreparedStatement statement = conn.prepareStatement("SELECT p.pollID, p.pollName FROM"
                   + " Assigned a, Polls p WHERE a.userID=? AND a.role='Poll Master' AND p.pollID=a.pollID");
            statement.setInt(1,userID);// userID
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                System.out.println("1");
             //   returnQuestions.add(Integer.toString(resultSet.getInt("questID")));
                int temp_pid = resultSet.getInt("pollID");
                String temp_pname = resultSet.getString("pollName");
		returnResults.add("{\"pollID\": "+ temp_pid + ","+
			" \"PollName\": \"" + temp_pname + "\"}");
            }
            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getPollIDs(): " + e.toString());
            return null;
        }
    }

    public ArrayList<String> getDemographicQuestions(int pollID){
        try {
            ArrayList<String> returnResults = new ArrayList<String>();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT questID,"
                    + " question FROM Questions "
                    + "WHERE pollID=?  AND demographic='T'");
        statement.setInt(1, pollID);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
                int temp_qid = resultSet.getInt("questID");
                String temp_qname = resultSet.getString("question");
		returnResults.add("{\"questID\": "+ temp_qid + ","+
			" \"Question\": \"" + temp_qname + "\"}");
            }


            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getDemographicQuestions(): " + e.toString());
            return null;
        }
    }

    public ArrayList<String> getDemographicAnswers(int questID){
        try {
            ArrayList<String> returnResults = new ArrayList<String>();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT answerID,"
                    + " answer FROM Answers "
                    + "WHERE questID=?");
        statement.setInt(1, questID);
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
                int temp_answerid = resultSet.getInt("answerID");
                String temp_answer = resultSet.getString("answer");
		returnResults.add("{\"id\": "+ temp_answerid + ","+
			" \"Answer\": \""+ temp_answer + "\"}");
            }
            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getDemographicAnswers(): " + e.toString());
            return null;
        }
    }

    public ArrayList<String> getLocations(int pollID){
        try {
            ArrayList<String> returnResults = new ArrayList<String>();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT u.location"
                    + " FROM Users u, Attendance a"
                    + " WHERE a.pollID=? AND u.userID=a.userID" +
                    " GROUP BY u.location");
        statement.setInt(1, pollID);// pollID
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
                String temp_locatin = resultSet.getString("location");
		returnResults.add("{\"Location\": \""+ temp_locatin + "\"}");
            }
            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getLocations(): " + e.toString());
            return null;
        }
    }
    public ArrayList<String> getUsers(int pollID){
        try {
            ArrayList<String> returnResults = new ArrayList<String>();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT u.userName"
                    + ", u.userID FROM Users u, Attendance a"
                    + " WHERE a.pollID=? AND u.userID=a.userID");
        statement.setInt(1, pollID);// userID
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
                int temp_userIDs = resultSet.getInt("userID");
                String temp_users = resultSet.getString("userName");
		returnResults.add("{\"id\": "+ temp_userIDs + ","+
			" \"UserName\": \""+ temp_users + "\"}");
            }
            resultSet.close();
            closeOracleConnection();
            return returnResults;
        } catch (SQLException e) {
            System.out.println("getQuestions(): " + e.toString());
            return null;
        }

    }

    private class Point{

        private double lat;
        private double lng;

        public Point(double lat, double lng){
            this.lat = lat;
            this.lng = lng;
        }

    }
    
   public static void main(String[] args)throws JRException{
   
        ArrayList<String> ttemp = new ReportService("session").getPollIDs(2);
        System.out.print(ttemp);
        System.out.print("\n");
        ArrayList<String> temp = new ReportService("session").getDemographicQuestions(1);
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
     
       
       //new ReportService(new BigDecimal(1), "statistical", "Pie", new BigDecimal(19), "").generateReport();
   
       //new ReportService("system").generateReport();
   
   
   
   }
    
}
