/* INDIVIDUAL DARREN
 * Handles all queries relating to the 'questions' table
 */
package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;
/**
 *
 * @author Darren
 */
public class questions {
    Connection conn;
    private int pollID;
    private int questID;
    private String demographic;
    private String responseType;
    private String questionText;
    private Timestamp created;
    private String font;
    private String correctIndicator;
    private int chartType;
    private String images;
    private int creator;
    private String location;

    public questions(int questID, int pollID, String demographic, 
            String responseType, String questionText, Timestamp created, 
            String font, String correctIndicator, int chartType, String images, 
            int creator, String location) {
        this.questID = questID;
        this.pollID= pollID;
        this.demographic = demographic;
        this.responseType = responseType;
        this.questionText = questionText;
        this.created = created;
        this.font = font;
        this.correctIndicator = correctIndicator;
        this.chartType = chartType;
        this.images = images;
        this.creator = creator;
        this.location = location;
    }

    public questions(int questID) {
        this(questID, -1, "N", "N", "", new Timestamp(0), "", "", -1, "", -1, "");
    }

    public questions(int pollID, String demographic, String responseType, 
            String questionText, Timestamp created, String font, 
            String correctIndicator, int chartType, String images, 
            int creator, String location) {
        this(-1, pollID, demographic, responseType, questionText, created, font, 
                correctIndicator, chartType, images, creator, location);
    }

    public questions() {
        this(-1, -1, "N", "N", "", new Timestamp(0), "", "", -1, "", -1, "");
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
     * Attempts to locate all answerIDs for answers to this question in
     * the database. 
     * Will not check for success.
     * 
     * Pre-condition: The questID must be set to an existing question
     * 
     * @return  ResultSet   for attempt made.
     *          null        for error.
     */
    public ArrayList<String> getAnswers(int qid) {
        try {
            if (qid == -1) {
                return null;
            }
            ArrayList<String> returnAnswers = new ArrayList<String>();
            //getOracleConnection();
            String query= "SELECT * FROM Answers  WHERE questID=" + qid;
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                //System.out.println("calling rs.next() in getAnswers()");
                returnAnswers.add("{\"id\": "+resultSet.getInt("answerID") +
                        ",\"keypad\": \"" +resultSet.getString("keypad")+ "\""
                        + ",\"text\": \"" + resultSet.getString("answer")+ "\""
                                + ",\"questionID\": " +resultSet.getInt("questID")
                                + ",\"correct\": \"" +resultSet.getString("correct") + "\"}");
                System.out.print("answer printed: "+resultSet.getInt("answerID")+"<br/>");
            }
            resultSet.close();
            closeOracleConnection();
            return returnAnswers;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    
    
    public ArrayList<Integer> getAnswerIDs(int qid) {
        try {
            if (qid == -1) {
                return null;
            }
            ArrayList<Integer> returnAnswers = new ArrayList<Integer>();
            //getOracleConnection();
            String query= "SELECT * FROM Answers  WHERE questID=" + qid;
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                //System.out.println("calling rs.next() in getAnswers()");
                returnAnswers.add(resultSet.getInt("answerID"));
            }
            resultSet.close();
            closeOracleConnection();
            return returnAnswers;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }
    
    /**
     * Attempts to add this question to the database. 
     * Database will not be checked for success.
     * Will not update existing question.
     * 
     * Pre-condition: The questID must be set to an non-existing questID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid question properties.
     *          -2   for undefined error.
     */
    public int addQuestion() {
        int pk = -1;
        int test = -1;
        try {
            if (getPollID() != -1) {
                return -1;
            } else if (getQuestionText().equals("")) {
                return -1;
            }
            
            
            if(getDemographic().matches("true")) {
                setDemographic("T");
            } else if(getDemographic().matches("false")) {
                setDemographic("F");
            }
            
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO Questions(questid, demographic, responsetype, question, pollid, created, font, correctindicator, charttype, images, creator, location) VALUES (qseq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            System.out.println("\n addQuestion() got called; demographic: " + getDemographic());

            statement.setString(1, getDemographic());
            statement.setString(2, getResponseType());
            statement.setString(3, getQuestionText());
            statement.setInt(4, getPollID());
            statement.setTimestamp(5, getCreated());
            statement.setString(6, getFont());
            statement.setString(7, getCorrectIndicator());
            statement.setInt(8, getChartType());
            statement.setString(9, getImages());
            statement.setInt(10, getCreator());
            statement.setString(11, getLocation());
            
            statement.executeUpdate();
            
            statement = conn.prepareStatement("SELECT qseq.currval FROM dual");
            ResultSet rset = statement.executeQuery();
            if(rset.next()) {
                pk = rset.getInt(1);
                //rset.getInt("questID");
            }
            System.out.println("pk: " + pk);
            statement.close();
            closeOracleConnection();
            return pk;
        } catch (SQLException e) {
            System.out.println("addQuestion(): " + e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to edit this question in the database. 
     * Database will not be checked for success.
     * Will not add a new question.
     * 
     * Pre-condition: The questID must be set to an existing question
     * 
     * @return  0    for attempt made.
     *          -1   for invalid question properties.
     *          -2   for undefined error.
     */
    public int editQuestion() {
        try {
            if (getPollID() == -1) {
                return -1;
            } else if (getQuestID() == -1) {
                return -1;
            } else if (getQuestionText().equals("")) {
                return -1;
            }
            if(getDemographic().matches("true")) {
                setDemographic("T");
            } else if(getDemographic().matches("false")) {
                setDemographic("F");
            }
            
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("UPDATE Questions SET demographic=?, responseType=?,"
                    + "question=?, pollID=?, font=?, correctIndicator=?, chartType=?, "
                    + "images=?, creator=?, location=? WHERE questID=?");
            statement.setString(1, getDemographic());
            statement.setString(2, getResponseType());
            statement.setString(3, getQuestionText());
            statement.setInt(4, getPollID());
            statement.setString(5, getFont());
            statement.setString(6, getCorrectIndicator());
            statement.setInt(7, getChartType());
            statement.setString(8, getImages());
            statement.setInt(9, getCreator());
            statement.setString(10, getLocation());
            statement.setInt(11, getQuestID());
            
            statement.executeUpdate();
            statement.close();

            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this question from the database. 
     * Database will not be checked for success.
     * 
     * Pre-condition: The questID must be set to an existing question
     * 
     * @return  0    for attempt made
     *          -1   for unset question ID.
     *          -2   for undefined error.
     */
    public int deleteQuestion() {
        try {
            if (getQuestID() == -1) {
                return -1;
            } 
            
            
            /* Delete answers under question */
            String query= "SELECT answerID FROM Answers WHERE questID=" + getQuestID();
            ResultSet resultSet = runQuery(query);
            
            /* Calls each answer to delete itself and its children */
            while (resultSet.next()) {
                answers temp = new answers();
                temp.setAnswerID(resultSet.getInt("answerID"));
                temp.deleteAnswer();
            }
            closeOracleConnection();
            /* Delete comparitives under question */
            query= "SELECT * FROM Comparitives WHERE questID=" + getQuestID() 
                    + " OR compareTo=" + getQuestID();
            resultSet = runQuery(query);
            
            /* Calls each comparitive to delete itself and its children */
            while (resultSet.next()) {
                comparitives temp = new comparitives();
                temp.setQuestID(resultSet.getInt("questID"));
                temp.setCompareTo(resultSet.getInt("compareTo"));
                temp.deleteComparitive();
            }
            closeOracleConnection();
            /* Delete question */
            query= "DELETE FROM Questions WHERE questID=" + getQuestID();
            runQuery(query);
            closeOracleConnection();
            
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to find question by questID. 
     * Updates properties of this instance of questions to result found.
     * 
     * Pre-condition: The questID must be set to an existing question
     * 
     * @return  0    for attempt made
     *          -1   for unset or invalid question ID.
     *          -2   for undefined error.
     */
    public int getQuestion() {
        try {
            if (getQuestID() == -1) {
                return -1;
            } 
            
            String query= "SELECT * FROM Questions WHERE questID=" + getQuestID();
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setPollID(resultSet.getInt("pollID"));
                setQuestID(resultSet.getInt("questID"));
                setDemographic(resultSet.getString("demographic"));
                setResponseType(resultSet.getString("responseType"));
                setQuestionText(resultSet.getString("question"));
                setCreated(resultSet.getTimestamp("created"));
                setFont(resultSet.getString("font"));
                setCorrectIndicator(resultSet.getString("correctIndicator"));
                setChartType(resultSet.getInt("chartType"));
                setImages(resultSet.getString("images"));
                setCreator(resultSet.getInt("creator"));
                setLocation(resultSet.getString("location"));
            }
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to locate all questIDs for questions created between the
     * given dates
     * Will not check for success.
     *
     * @return  ResultSet   for attempt made.
     *          null        for error.
     */
    public ArrayList<String> findQuestions(String startDate, String endDate, String username) {
        try {

            ArrayList<String> returnQuestions = new ArrayList<String>();
            String query = "";
            /* check this if it works */
            
            if(startDate!=null && endDate!=null && username==null){
                query= "SELECT * FROM Questions WHERE created >= TO_DATE('"
                    + startDate + "', 'YYYY-MM-DD HH24:MI:SS') AND created <= TO_DATE('" + endDate + "', 'YYYY-MM-DD HH24:MI:SS')";
                
            }
            else if(startDate!=null && endDate==null && username==null){
                query= "SELECT * FROM Questions WHERE created >= TO_DATE('"
                    + startDate + "', 'YYYY-MM-DD HH24:MI:SS')";
            }
            else if(startDate!=null && endDate==null && username!=null){
                query= "SELECT * FROM Questions q INNER JOIN Users u ON q.creator = u.userID WHERE created >= TO_DATE('"
                    + startDate + "', 'YYYY-MM-DD HH24:MI:SS') AND u.userName ='" + username + "'";
            }
            else if(startDate!=null && endDate!=null && username!=null){
                query= "SELECT * FROM Questions q INNER JOIN Users u ON q.creator = u.userID WHERE created >= TO_DATE('"
                    + startDate + "', 'YYYY-MM-DD HH24:MI:SS') AND created <= TO_DATE('" + endDate + "', 'YYYY-MM-DD HH24:MI:SS') "
                        + "AND u.userName ='" + username + "'";
            }
            else if(username!=null && startDate==null && endDate==null){
                query= "SELECT * FROM Questions q INNER JOIN Users u ON q.creator = u.userID WHERE u.userName ='" + username + "'";
            
            }
            
            if(!query.equals("")){
                ResultSet resultSet = runQuery(query);
            
                while (resultSet.next()) {
                    System.out.println("calling rs.next()");
                    returnQuestions.add(resultSet.getString("question") + "," + resultSet.getInt("pollID"));
                }
                resultSet.close();
                closeOracleConnection();
            }
            return returnQuestions;
        } catch (SQLException e) {
            System.out.println(e.toString());
            return null;
        }
    }


    /**
     * @param pollID the pollID to set
     */
    public void setPollID(int pollID) {
        this.pollID = pollID;
    }

    /**
     * @param questID the questID to set
     */
    public void setQuestID(int questID) {
        this.questID = questID;
    }

    /**
     * @param demographic the demographic to set
     */
    public void setDemographic(String demographic) {
        this.demographic = demographic;
    }

    /**
     * @param responseType the responseType to set
     */
    public void setResponseType(String responseType) {
        this.responseType = responseType;
    }

    /**
     * @param question the question to set
     */
    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    /**
     * @return the pollID
     */
    public int getPollID() {
        return pollID;
    }

    /**
     * @return the questID
     */
    public int getQuestID() {
        return this.questID;
    }

    /**
     * @return the demographic
     */
    public String getDemographic() {
        return demographic;
    }

    /**
     * @return the responseType
     */
    public String getResponseType() {
        return responseType;
    }

    /**
     * @return the question
     */
    public String getQuestionText() {
        return questionText;
    }

    /**
     * @return the created
     */
    public Timestamp getCreated() {
        return created;
    }

    /**
     * @param created the created to set
     */
    public void setCreated(Timestamp created) {
        this.created = created;
    }

    /**
     * @return the font
     */
    public String getFont() {
        return font;
    }

    /**
     * @param font the font to set
     */
    public void setFont(String font) {
        this.font = font;
    }

    /**
     * @return the correctIndicator
     */
    public String getCorrectIndicator() {
        return correctIndicator;
    }

    /**
     * @param correctIndicator the correctIndicator to set
     */
    public void setCorrectIndicator(String correctIndicator) {
        this.correctIndicator = correctIndicator;
    }

    /**
     * @return the chartType
     */
    public int getChartType() {
        return chartType;
    }

    /**
     * @param chartType the chartType to set
     */
    public void setChartType(int chartType) {
        this.chartType = chartType;
    }

    /**
     * @return the images
     */
    public String getImages() {
        return images;
    }

    /**
     * @param images the images to set
     */
    public void setImages(String images) {
        this.images = images;
    }

    /**
     * @return the creator
     */
    public int getCreator() {
        return creator;
    }

    /**
     * @param creator the creator to set
     */
    public void setCreator(int creator) {
        this.creator = creator;
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
}