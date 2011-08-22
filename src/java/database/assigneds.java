/*
 * Handles all queries relating to the 'assigneds' table
 */
package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;
/**
 *
 * @author Darren
 */
public class assigneds {
    Connection conn;
    private int userID;
    private int pollID;
    private String role;
    private String status;

    public assigneds(int userID, int pollID, String role, String status) {
        this.userID = userID;
        this.pollID = pollID;
        this.role = role;
        this.status = status;
    }

    public assigneds(int userID) {
        this(userID, -1, "", "false");
    }

    public assigneds() {
        this(-1, -1, "", "false");
    }
    
    /**
     * Establishes a Oracle connection.
     */
    private Connection getOracleConnection() {
        conn=null;
        try {
            /* Load the Oracle JDBC Driver and register it. */
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            /* Open a new connection */
            conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "CSSE3004GF", "pass123");
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "S4203040", "318491");
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
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println("assigneds.runQuery(): " + e.toString());
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
     * Attempts to locate all users for the pollID in the database. 
     * Will not check for success.
     * 
     * Pre-condition: The pollID must be set to an existing pollID
     * 
     * @return  ArrayList<users>   for attempt made.
     *          null                for error.
     */
    public ArrayList<users> getUsers() {
        try {
            if (getPollID() == -1) {
                return null;
            }
            ArrayList<users> returnUsers = new ArrayList<users>();

            getOracleConnection();
            String query= "SELECT userID FROM Assigned WHERE pollID=" 
                    + getPollID();  
            ResultSet resultSet = runQuery(query);
            
            while (resultSet.next()) {
                users temporaryUser = new users();
                temporaryUser.setUserID(resultSet.getInt("userID"));
                temporaryUser.getUser();
                returnUsers.add(temporaryUser);
                System.out.println("calling rs.next()");
            }
            resultSet.close();
            closeOracleConnection();
            return returnUsers;
        } catch (SQLException e) {
            System.out.println("getUsers(): " + e.toString());
            return null;
        }
    }
    
    /**
     * Attempts to locate all polls for the userID in the database. 
     * Will not check for success.
     * 
     * Pre-condition: The userID must be set to an existing userID
     * 
     * @return  ArrayList<polls>   for attempt made.
     *          null                for error.
     */
    public ArrayList<polls> getPolls() {
        try {
            if (getUserID() == -1) {
                return null;
            }
            ArrayList<polls> returnPolls = new ArrayList<polls>();

            getOracleConnection();
            String query= "SELECT * FROM polls WHERE polls.pollID IN (SELECT pollID FROM assigned WHERE userID = " + getUserID() + ")";
            ResultSet resultSet = runQuery(query);
            
            while (resultSet.next()) {
                polls temporaryPoll = new polls();
                temporaryPoll.setPollID(resultSet.getInt("pollID"));
                temporaryPoll.setPollName(resultSet.getString("pollName"));
                returnPolls.add(temporaryPoll);
                System.out.println("calling rs.next()");
            }
            resultSet.close();
            closeOracleConnection();
            return returnPolls;
        } catch (SQLException e) {
            System.out.println("getPolls(): " + e.toString());
            return null;
        }
    }

    /**
     * @return the userID
     */
    public int getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     * @return the pollID
     */
    public int getPollID() {
        return pollID;
    }

    /**
     * @param pollID the pollID to set
     */
    public void setPollID(int pollID) {
        this.pollID = pollID;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @param role the role to set
     */
    public void setRole(String role) {
        this.role = role;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
}