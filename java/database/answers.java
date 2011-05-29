/*
 * Handles all queries relating to the 'answers' table
 */
package database;

import java.sql.*;
/**
 *
 * @author Darren
 */
public class answers {
    Connection conn;
    private int answerID;
    private int questID;
    private String keypad;
    private String answerText;
    private String correct;

    public answers(int answerID, int questID, String keypad, String answerText, String correct) {
        this.answerID = answerID;
        this.questID = questID;
        this.keypad = keypad;
        this.answerText = answerText;
        this.correct = correct;
    }

    public answers(int answerID) {
        this(answerID, -1, "", "", "N");
    }

    public answers(int questID, String keypad, String answerText, String correct) {
        this(-1, questID, keypad, answerText, correct);
    }

    public answers() {
        this(-1, -1, "", "", "N");
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
            conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "s4203658", "tiara9");
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
     * Attempts to add this answer to the database.
     * Database will not be checked for success.
     * Will not update existing answer.
     * 
     * Pre-condition: The answerID must be set to a non-existing answerID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid answer properties.
     *          -2   for undefined error.
     */
    public int addAnswer() {
        try {
            getOracleConnection();
            if (getAnswerID() == -1) {
                String query = "SELECT aseq.nextval FROM dual";
                ResultSet resultSet = runQuery(query);
                setAnswerID(resultSet.getInt(1));
            } else if (getQuestID() == -1) {
                return -1;
            } else if (getAnswerText().equals("")) {
                return -1;
            } else if (getKeypad().equals("")) {
                return -1;
            } else if (getCorrect().equals("")) {
                return -1;
            }
            
            String query = "INSERT INTO Answers(answerID, keypad, answer, "
                    + "questID, correct) VALUES (" + getAnswerID() + ", '"
                    + getKeypad() + "', '" + getAnswer() + "', "
                    + getQuestID() + ", '" + getCorrect() + "')";
            runQuery(query);
            
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to edit this answer in the database.
     * Database will not be checked for success.
     * Will not add a new answer.
     * 
     * Pre-condition: The answerID must be set to an existing answer
     * 
     * @return  0    for attempt made.
     *          -1   for invalid answer properties.
     *          -2   for undefined error.
     */
    public int editAnswer() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } else if (getQuestID() == -1) {
                return -1;
            } else if (getAnswerText().equals("")) {
                return -1;
            } else if (getKeypad().equals("")) {
                return -1;
            } else if (getCorrect().equals("")) {
                return -1;
            }
            
            getOracleConnection();
            String query= "UPDATE Answers SET questID=" + getQuestID()
                    + ", answer='" + getAnswerText()
                    + "', keypad='" + getKeypad() + "', correct='"
                    + getCorrect() + "' WHERE answerID=" + getAnswerID();
            runQuery(query);


            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this answer from the database.
     * Database will not be checked for success.
     * 
     * Pre-condition: The answerID must be set to an existing answer
     * 
     * @return  0    for attempt made
     *          -1   for unset answer ID.
     *          -2   for undefined error.
     */
    public int deleteAnswer() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } 
            getOracleConnection();
            String query= "DELETE FROM Answers WHERE answerID="
                    + getAnswerID();
            runQuery(query);
            query = "DELETE FROM Rankings WHERE answerID=" + getAnswerID();
            runQuery(query);
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to find answer by answerID.
     * Updates properties of this instance of answers to result found.
     * 
     * Pre-condition: The answerID must be set to an existing answer
     * 
     * @return  0    for attempt made
     *          -1   for unset or invalid answer ID.
     *          -2   for undefined error.
     */
    public int getAnswer() {
        try {
            if (getAnswerID() == -1) {
                return -1;
            } 
            getOracleConnection();
            String query= "SELECT * FROM Answers WHERE answerID=" + getAnswerID();
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setAnswerID(resultSet.getInt("answerID"));
                setQuestID(resultSet.getInt("questID"));
                setKeypad(resultSet.getString("keypad"));
                setAnswerText(resultSet.getString("answer"));
                setCorrect(resultSet.getString("correct"));

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
     * @param answerID the answerID to set
     */
    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    /**
     * @return the answerID
     */
    public int getAnswerID() {
        return answerID;
    }

    /**
     * @return the questID
     */
    public int getQuestID() {
        return questID;
    }

    /**
     * @param questID the questID to set
     */
    public void setQuestID(int questID) {
        this.questID = questID;
    }

    /**
     * @return the keypad
     */
    public String getKeypad() {
        return keypad;
    }

    /**
     * @param keypad the keypad to set
     */
    public void setKeypad(String keypad) {
        this.keypad = keypad;
    }

    /**
     * @return the answer
     */
    public String getAnswerText() {
        return answerText;
    }

    /**
     * @param answer the answer to set
     */
    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    /**
     * @return the correct
     */
    public String getCorrect() {
        return correct;
    }

    /**
     * @param correct the correct to set
     */
    public void setCorrect(String correct) {
        this.correct = correct;
    }
}