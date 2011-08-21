/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.*;
import java.util.ArrayList;
import database.*;
/**
 *
 * @author s4217258
 */
public class listPolls {
    Connection conn;
    private ArrayList<Integer> temp_qIDs;
    private ArrayList<Integer> temp_aIDs;
    
    public listPolls(){}
    
    
    /*public ArrayList<String> list(int pollid){
        conn=null;
        try {
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Questions q LEFT OUTER JOIN QuestionWidgets w ON q.questID = w.questID "
                    + "LEFT OUTER JOIN Comparitives c ON c.questID = q.questID "
                    + "LEFT OUTER JOIN Answers a ON a.questID = q.questID "
                    + "LEFT OUTER JOIN Rankings r ON r.answerID = a.answerID WHERE q.pollID =?");
            statement.setInt(1,pollid);
            ResultSet resultSet = statement.executeQuery();
            ArrayList<String> temp_result= new ArrayList<String>();
            while(resultSet.next()){
                temp_result.add();
            
            
            
            
            
            
            }
            return temp_result;
        } catch(SQLException ex){
            System.out.println(ex.toString());
            return null;
        }
    
    }*/
    public ArrayList<Integer> getQIDs(){
        if(this.temp_qIDs != null){
            return this.temp_qIDs;
        }
        else{
        return null;
        }
    
    }
    
    public ArrayList<Integer> getAIDs(){
        if(this.temp_aIDs != null){
            return this.temp_aIDs;
        }
        else{
        return null;
        }
    
    }
    
    private ResultSet runQuery(String query) {
        try {
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println("polls.runQuery(): " + e.toString());
            return null;
        }
    }
    
     public ArrayList<String> getQuestions(int id) {
        try {
            if (id == -1) {
                return null;
            }
            ArrayList<String> returnQuestions = new ArrayList<String>();
            temp_qIDs = new ArrayList<Integer>();
            getOracleConnection();
            String query= "SELECT * FROM Questions q LEFT OUTER JOIN Comparitives c ON c.questID = q.questID WHERE pollID=" 
                    + id + " ORDER BY q.question";  
            ResultSet resultSet = runQuery(query);
          
            while (resultSet.next()) {
                System.out.println("calling rs.next()");
             //   returnQuestions.add(Integer.toString(resultSet.getInt("questID")));
                int temp_qid = resultSet.getInt("questID");
             
                temp_qIDs.add(temp_qid);
		returnQuestions.add("{\"id\": " + temp_qid + ","+
			"\"demographic\": \"" + resultSet.getString("demographic") + "\","+
			"\"responseType\": \"" + resultSet.getString("responseType") + "\","+
			"\"text\": \"" + resultSet.getString("question")  + "\","+
			"\"created\": \"" + resultSet.getTimestamp("created")  + "\","+
			"\"font\": \"" + resultSet.getString("font")  + "\","+
			"\"indicator\": \"" + resultSet.getString("correctIndicator")  + "\","+
			"\"chart\": \"" + resultSet.getInt("chartType")  + "\","+
			"\"image\": \"" + resultSet.getString("images") + "\","+
			"\"creator\": " + resultSet.getInt("creator") + ","+
                        "\"compareTo\": \"" + resultSet.getString("compareTo") + "\","+
			"\"responses\": [");
                        System.out.print("question printed: "+resultSet.getInt("questID")+"<br/>");
            }
            resultSet.close();
            
            return returnQuestions;
        } catch (SQLException e) {
            System.out.println("getQuestions(): " + e.toString());
            return null;
        }
    }
     
    
    public ArrayList<String> getAnswers(int qid) {
        try {
            if (qid == -1) {
                return null;
            }
            ArrayList<String> returnAnswers = new ArrayList<String>();
            temp_aIDs = new ArrayList<Integer>();
            getOracleConnection();
            String query= "SELECT * FROM Answers a LEFT OUTER JOIN Rankings r ON r.answerID = a.answerID  WHERE questID=" + qid + " ORDER BY a.answer";
            ResultSet resultSet = runQuery(query);
            
            while (resultSet.next()) {
                //System.out.println("calling rs.next() in getAnswers()");
                int temp_aid = resultSet.getInt("answerID");
                temp_aIDs.add(temp_aid);
                
                returnAnswers.add("{\"id\": "+temp_aid +
                        ",\"keypad\": \"" +resultSet.getString("keypad")+ "\""
                        + ",\"text\": \"" + resultSet.getString("answer")+ "\""
                                + ",\"questionID\": " +resultSet.getInt("questID")
                                + ",\"weight\": " + resultSet.getString("weight")
                                + ",\"correct\": \"" +resultSet.getString("correct") + "\"}");
                System.out.print("answer printed: "+resultSet.getInt("answerID")+"<br/>");
            }
            resultSet.close();
            return returnAnswers;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    public void closeOracleConnection() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    
    public void getOracleConnection() {
        if(conn == null) {
            try {
                /* Load the Oracle JDBC Driver and register it. */
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                /* Open a new connection */
                conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "CSSE3004GF", "pass123");
            }
            catch(SQLException e) {
                System.out.println("Error opening db connection: " + e.toString());
            }
        }
    }
    
}
