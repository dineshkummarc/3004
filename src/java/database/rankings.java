/*
 * Handles all queries relating to the 'rankings' table
 */
package database;

import java.sql.*;
/**
 *
 * @author Darren
 */
public class rankings {
    Connection conn;
    private int answerID;
    private int weight;

    public rankings(int answerID, int weight) {
        this.answerID = answerID;
        this.weight = weight;
    }

    public rankings() {
        this(-1, -1);
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
            if(conn == null) {
                getOracleConnection();
            }
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println("answers.runQuery(): " + e.toString());
            return null;
        }
    }
    
    /**
     * Closes any open Oracle connection.
     */
    private void closeOracleConnection() {
        try {
            conn.close();
            conn = null;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    
    /**
     * Attempts to add this ranking to the database. 
     * Database will not be checked for success.
     * Will not update existing ranking.
     * 
     * Pre-condition: The answerID must be set to an existing answerID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid ranking properties.
     *          -2   for undefined error.
     */
    public int addRanking() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } else if (getWeight() == -1) {
                return -1;
            }
            
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO"
                    + " Rankings(answerID, weight) VALUES (?, ?)");
            statement.setInt(1, getAnswerID());
            statement.setInt(2, getWeight());
            statement.executeUpdate();
            statement.close();
            /*String query= "INSERT INTO Rankings(answerID, weight) VALUES (" 
                    + getAnswerID() + ", " + getWeight() + ")";  
            runQuery(query);*/

            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to edit this ranking in the database. 
     * Database will not be checked for success.
     * Will not add a new ranking.
     * 
     * Pre-condition: The answerID must be set to existing answerID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid ranking properties.
     *          -2   for undefined error.
     */
    public int editRanking() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } else if (getWeight() == -1) {
                return -1;
            }
            
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("UPDATE Rankings SET weight=?"
                    + " WHERE answerID=?");
            statement.setInt(1, getWeight());
            statement.setInt(2, getAnswerID());
            statement.executeUpdate();
            statement.close();
            
            /*
            String query = "UPDATE Rankings SET weight=" + getWeight()
                            + " WHERE answerID=" + getAnswerID();
            runQuery(query);*/
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this ranking from the database. 
     * Database will not be checked for success.
     * 
     * Pre-condition: The answerID must be set to an existing answerID
     * 
     * @return  0    for attempt made
     *          -1   for unset ID.
     *          -2   for undefined error.
     */
    public int deleteRanking() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } 
            getOracleConnection();
            String query = "DELETE FROM Rankings WHERE answerID=" 
                    + getAnswerID();
            runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to find ranking by answerID. 
     * Updates properties of this instance of rankings to result found.
     * 
     * Pre-condition: The answerID must be set to an existing answerID
     * 
     * @return  0    for attempt made
     *          -1   for unset or invalid answerID.
     *          -2   for undefined error.
     */
    public int getRanking() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            }
      
            String query= "SELECT * FROM Rankings WHERE answerID=" 
                    + getAnswerID();
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setAnswerID(resultSet.getInt("answerID"));
                setWeight(resultSet.getInt("weight"));
                closeOracleConnection();
                return 0;
            }
            closeOracleConnection();
            return -1;
        } catch (Exception e) {
            System.out.println("getRanking() exception: " + e.toString());
            return -2;
        }
    }

    /**
     * @param answerID the answerID to set
     */
    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    /**
     * @return the answerID
     */
    public int getAnswerID() {
        return this.answerID;
    }

    /**
     * @return the weight
     */
    public int getWeight() {
        return this.weight;
    }

    /**
     * @param weight the weight to set
     */
    public void setWeight(int weight) {
        this.weight = weight;
    }
}