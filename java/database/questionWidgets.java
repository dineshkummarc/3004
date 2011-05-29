/*
 * Handles all queries relating to the 'questionWidgets' table
 */
package database;

import java.sql.*;
import oracle.jdbc.pool.OracleDataSource;
/**
 *
 * @author Darren
 */
public class questionWidgets {
    Connection conn;
    private int questID;
    private int widgetID;

    public questionWidgets(int questID, int widgetID) {
        this.questID = questID;
        this.widgetID = widgetID;
    }

    public questionWidgets() {
        this(-1, -1);
    }
    
    /**
     * Establishes a Oracle connection.
     */
    private Connection getOracleConnection() {
        conn=null;
        try {
            OracleDataSource ods = new OracleDataSource();
            ods.setUser("CSSE3004GF");
            ods.setPassword("pass123");
            ods.setURL("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo");
            ods.setConnectionCachingEnabled(true);
            conn = ods.getConnection();
        } catch(Exception ex){
            System.out.println(ex.toString());
        }
        return conn;
    }
    
    /**
     * Runs the specified query.
     * 
     * @param query The query string to run.
     * @return ResultSet returned from running query.
     */
    private ResultSet runQuery(String query) {
        try {
            while (conn.isClosed()) {
                getOracleConnection();
            }
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    /**
     * Closes any open Oracle connection.
     */
    private void closeOracleConnection() {
        try {
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    
    /**
     * Attempts to add this questionWidget to the database. 
     * Database will not be checked for success.
     * Will not update existing questionWidget.
     * 
     * Pre-condition: The questID must be set to an existing questID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid questionWidget properties.
     *          -2   for undefined error.
     */
    public int addQuestionWidget() {
        try {
            if (getQuestID() == -1) {
                return -1;
            } else if (getWidgetID() == -1) {
                return -1;
            }
            
            getOracleConnection();
            String query= "INSERT INTO QuestionWidgets(questID, widgetID) VALUES (" 
                    + getQuestID() + ", " + getWidgetID() + ")";  
            runQuery(query);

            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this questionWidget from the database. 
     * Database will not be checked for success.
     * 
     * Pre-condition: The questID must be set to an existing questID
     * 
     * @return  0    for attempt made
     *          -1   for unset ID.
     *          -2   for undefined error.
     */
    public int deleteQuestionWidget() {
        try {
            if (getQuestID() == -1) {
                return -1;
            } else if (getWidgetID() == -1) {
                return -1;
            }
            getOracleConnection();
            String query = "DELETE FROM QuestionWidgets WHERE questID=" 
                    + getQuestID() + " AND widgetID=" + getWidgetID();
            runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * @param questID the questID to set
     */
    public void setQuestID(int questID) {
        this.questID = questID;
    }

    /**
     * @return the questID
     */
    public int getQuestID() {
        return questID;
    }

    /**
     * @return the widgetID
     */
    public int getWidgetID() {
        return widgetID;
    }

    /**
     * @param widgetID the widgetID to set
     */
    public void setWidgetID(int widgetID) {
        this.widgetID = widgetID;
    }
}