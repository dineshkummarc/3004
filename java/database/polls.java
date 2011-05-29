/*
 * Handles all queries relating to the 'polls' table
 */
package database;

import java.sql.*;
import java.util.Vector;
/**
 *
 * @author Darren
 */
public class polls {
    Connection conn;
    private int pollID;
    private String pollName;
    private String location;
    private String description;

    public polls(int pollID, String pollName, String location, String description) {
        this.pollID = pollID;
        this.pollName = pollName;
        this.location = location;
        this.description = description;
    }

    public polls(int pollID) {
        this(pollID, "", "", "");
    }

    public polls(String pollName, String location, String description) {
        this(-1, pollName, location, description);
    }

    public polls() {
        this(-1, "", "", "");
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
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println("polls.runQuery(): " + e.toString());
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
     * Attempts to locate all questIDs for questions this poll in the database. 
     * Will not check for success.
     * 
     * Pre-condition: The pollID must be set to an existing poll
     * 
     * @return  Vector<questions>   for attempt made.
     *          null                for error.
     */
    public Vector<questions> getQuestions() {
        try {
            if (getPollID() == -1) {
                return null;
            }
            Vector<questions> returnQuestions = new Vector<questions>();

            getOracleConnection();
            String query= "SELECT * FROM Questions WHERE pollID=" 
                    + getPollID();  
            ResultSet resultSet = runQuery(query);
            
            while (resultSet.next()) {
                System.out.println("calling rs.next()");

                returnQuestions.add(new questions(resultSet.getInt("questID"), resultSet.getInt("pollID"), 
                        resultSet.getString("demographic"), resultSet.getString("responseType"),
                        resultSet.getString("question"), resultSet.getTimestamp("created"),
                        resultSet.getString("font"), resultSet.getString("correctIndicator"),
                        resultSet.getInt("chartType"), resultSet.getString("images"), 
                        resultSet.getInt("creator")));
                        
            }
            closeOracleConnection();
            return returnQuestions;
        } catch (SQLException e) {
            System.out.println("getQuestions(): " + e.toString());
            return null;
        }
    }

    /**
     * Attempts to locate all pollIDs for the polls in the database.
     * Will not check for success.
     *
     * @return  Vector<polls>   for attempt made.
     *          null            for error.
     */
    public Vector<polls> getAllPollIDs() {
        try {
            Vector<polls> returnPolls = new Vector();

            getOracleConnection();
            String query= "SELECT pollID FROM Polls";
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                this.setPollID(resultSet.getInt("pollID"));
                this.getPoll();
                returnPolls.add(new polls(this.getPollID(), this.getPollName(), this.getLocation(), this.getDescription()));
            }
            closeOracleConnection();
            return returnPolls;
        } catch (Exception e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    /**
     * Attempts to add this poll to the database. 
     * Database will not be checked for success.
     * Will not update existing poll.
     * 
     * Pre-condition: The pollID must be set to a non-existing pollID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid poll properties.
     *          -2   for undefined error.
     */
    public int addPoll() {
        try {
            if (getPollID() == -1) {
                String query = "SELECT pseq.nextval FROM dual";
                ResultSet resultSet = runQuery(query);
                while(resultSet.next()) {
                    setPollID(resultSet.getInt(1));
                }
                
            } else if (getPollName().equals("")) {
                return -1;
            } else if (getLocation().equals("")) {
                return -1;
            }
            
            getOracleConnection();
            /*String query= "INSERT INTO Polls(pollID, pollName, location, description) VALUES"
                    + "(" + getPollID() + ", '" + getPollName() + "', '" 
                    + getLocation() + "', '" + getDescription() + "')";  */
            PreparedStatement statement = conn.prepareStatement("INSERT INTO POLLS(pollID, pollName, location, description) VALUES" +
                    "(?, ?, ?, ?)");
            statement.setInt(1, getPollID());
            statement.setString(2, getPollName());
            statement.setString(3, getLocation());
            statement.setString(4, getDescription());
            statement.executeUpdate();
            //runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to edit this poll in the database. 
     * Database will not be checked for success.
     * Will not add a new poll.
     * 
     * Pre-condition: The pollID must be set to an existing poll
     * 
     * @return  0    for attempt made.
     *          -1   for invalid poll properties.
     *          -2   for undefined error.
     */
    public int editPoll() {
        try {
            if (getPollID() == -1) {
                return -1;
            } else if (getPollName().equals("")) {
                return -1;
            } else if (getLocation().equals("")) {
                return -1;
            }
            
            getOracleConnection();
            String query= "UPDATE Polls SET pollName='" + getPollName() 
                    + "', location='" + getLocation() + "', description='" 
                    + getDescription() + "' WHERE pollID=" + getPollID();  
            runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println("EditPoll() " + e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this poll from the database. 
     * Database will not be checked for success.
     * 
     * Pre-condition: The pollID must be set to an existing poll
     * 
     * @return  0    for attempt made
     *          -1   for unset poll ID.
     *          -2   for undefined error.
     */
    public int deletePoll() {
        try {
            if (getPollID() == -1) {
                return -1;
            } 
            getOracleConnection();
            
            /* Delete questions under poll */
            String query= "SELECT questID FROM Questions WHERE pollID=" + getPollID();
            ResultSet resultSet = runQuery(query);
            
            /* Calls each question to delete itself and its children */
            while (resultSet.next()) {
                questions temp = new questions();
                temp.setQuestID(resultSet.getInt("questID"));
                temp.deleteQuestion();
            }
            
            /* Delete poll */
            query= "DELETE FROM Polls WHERE pollID=" + getPollID();
            runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to find poll by pollID. 
     * Updates properties of this instance of polls to result found.
     * 
     * Pre-condition: The pollID must be set to an existing poll
     * 
     * @return  0    for attempt made
     *          -1   for unset or invalid poll ID.
     *          -2   for undefined error.
     */
    public int getPoll() {
        try {
            if (getPollID() == -1) {
                return -1;
            } 
            getOracleConnection();
            String query= "SELECT * FROM Polls WHERE pollID=" + getPollID();
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setPollID(resultSet.getInt("pollID"));
                setPollName(resultSet.getString("pollName"));
                setLocation(resultSet.getString("location"));
                setDescription(resultSet.getString("description"));
                closeOracleConnection();
                return 0;
            }
            closeOracleConnection();
            return -1;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * @param pollID the pollID to set
     */
    public void setPollID(int pollID) {
        this.pollID = pollID;
    }

    /**
     * @return the pollID
     */
    public int getPollID() {
        return this.pollID;
    }

    /**
     * @return the pollName
     */
    public String getPollName() {
        return pollName;
    }

    /**
     * @param pollName the pollName to set
     */
    public void setPollName(String pollName) {
        this.pollName = pollName;
    }

    /**
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

}