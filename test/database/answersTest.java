/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import java.sql.*;
import static org.junit.Assert.*;

/**
 *
 * @author David
 */
public class answersTest {
    Connection conn;
    
    public answersTest() {

    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {

        
    }

    /**
     * Test of addAnswer method, of class answers.
     */
    @Test
    public void testAddAnswer() {
        System.out.println("addAnswer");
        
        answers instance = new answers(10, 5, "4", "answertext", "N");
        instance.addAnswer();
                
        try {
            reset();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Answers WHERE answerID='10'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertTrue(rset.getNString("answer").matches("answertext"));
            }
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("ERROR OCCURRED IN TEST: " + e.toString());
        }
    }

    /**
     * Test of editAnswer method, of class answers.
     */
    @Test
    public void testEditAnswer() {
        System.out.println("editAnswer");
        getOracleConnection();
        
        try {
            try {
                PreparedStatement statement = conn.prepareStatement("DELETE FROM Answers");
                statement.execute();
                statement.close();
                conn.close();
            }
            catch(SQLException e) {
                System.out.println("Error in tearDown() SQL: " + e.toString());
            }
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO Answers(answerID, keypad, answer, "
                        + "questID, correct) VALUES (?, ?, ?, ?, ?)");
            statement.setInt(1, 11);
            statement.setString(2, "2");
            statement.setString(3, "answer");
            statement.setInt(4, 4);
            statement.setString(5, "N");
            statement.executeUpdate();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error occurs in test edit answer: " + e.toString());
        }
        
        answers instance = new answers(11, 4, "2", "answer1", "Y");
        instance.editAnswer();
        
        
        getOracleConnection();
        try {
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Answers WHERE answerID='11'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertTrue(rset.getNString("answer").matches("answer1"));
            }
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error occurs in test edit answer 2: " + e.toString());
        }
    }

    /**
     * Test of deleteAnswer method, of class answers.
     */
    @Test
    public void testDeleteAnswer() {
        System.out.println("deleteAnswer");
        getOracleConnection();
        
        try {
            PreparedStatement statement = conn.prepareStatement("INSERT INTO Answers(answerID, keypad, answer, "
                        + "questID, correct) VALUES (?, ?, ?, ?, ?)");
            statement.setInt(1, 12);
            statement.setString(2, "2");
            statement.setString(3, "answer");
            statement.setInt(4, 4);
            statement.setString(5, "N");
            statement.execute();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error occurs in testDeleteAnswer(): " + e.toString());
        }
        
        answers instance = new answers(12, 4, "2", "answer1", "Y");
        instance.deleteAnswer();
        
        getOracleConnection();
        
        try {
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Answers WHERE answerID='12'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertTrue(false);
            }
            assertTrue(true);
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error occurs in testDeleteAnswer() 2: " + e.toString());
        }
    }

    /**
     * Test of getAnswer method, of class answers.
     */
    @Test
    public void testGetAnswer() {
        System.out.println("getAnswer");
        answers instance = new answers(12, 4, "2", "answer1", "N");
        getOracleConnection();
        
        try {
            PreparedStatement statement = conn.prepareStatement("INSERT INTO Answers(answerID, keypad, answer, "
                        + "questID, correct) VALUES (?, ?, ?, ?, ?)");
            statement.setInt(1, 12);
            statement.setString(2, "2");
            statement.setString(3, "answer");
            statement.setInt(4, 4);
            statement.setString(5, "N");
            statement.execute();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error occurs in testGetAnswer(): " + e.toString());
        }
        instance.getAnswer();
        assertEquals(4, instance.getQuestID());

    }

    /**
     * Test of setAnswerID method, of class answers.
     */
    @Test
    public void testSetAnswerID() {
        System.out.println("setAnswerID");
        answers instance = new answers(10, -1, "", "", "N");
        instance.setAnswerID(11);
        assertEquals(11, instance.getAnswerID());
    }

    /**
     * Test of getAnswerID method, of class answers.
     */
    @Test
    public void testGetAnswerID() {
        System.out.println("getAnswerID");
        answers instance = new answers(10, -1, "", "", "N");
        assertEquals(10, instance.getAnswerID());
    }

    /**
     * Test of getQuestID method, of class answers.
     */
    @Test
    public void testGetQuestID() {
        System.out.println("getQuestID");
        answers instance = new answers(10, 5, "", "", "N");
        assertEquals(5, instance.getQuestID());
    }

    /**
     * Test of setQuestID method, of class answers.
     */
    @Test
    public void testSetQuestID() {
        System.out.println("setQuestID");
        answers instance = new answers(10, 5, "", "", "N");
        instance.setQuestID(6);
        assertEquals(6, instance.getQuestID());
    }

    /**
     * Test of getKeypad method, of class answers.
     */
    @Test
    public void testGetKeypad() {
        System.out.println("getKeypad()");
        answers instance = new answers(10, 5, "test", "", "N");
        assertTrue(instance.getKeypad().matches("test"));
    }

    /**
     * Test of setKeypad method, of class answers.
     */
    @Test
    public void testSetKeypad() {
        System.out.println("setKeypad");
        answers instance = new answers(10, 5, "test", "", "N");
        instance.setKeypad("test1");
        assertTrue(instance.getKeypad().matches("test1"));
    }

    /**
     * Test of getAnswerText method, of class answers.
     */
    @Test
    public void testGetAnswerText() {
        System.out.println("getAnswerText");
        answers instance = new answers(10, 5, "test", "answertext", "N");
        assertTrue(instance.getAnswerText().matches("answertext"));
    }

    /**
     * Test of setAnswerText method, of class answers.
     */
    @Test
    public void testSetAnswerText() {
        System.out.println("setAnswerText");
        answers instance = new answers(10, 5, "test", "answertext", "N");
        instance.setAnswerText("answertext1");
        assertTrue(instance.getAnswerText().matches("answertext1"));
    }

    /**
     * Test of getCorrect method, of class answers.
     */
    @Test
    public void testGetCorrect() {
        System.out.println("getCorrect");
        answers instance = new answers(10, 5, "test", "answertext", "N");
        assertTrue(instance.getCorrect().matches("N"));
    }

    /**
     * Test of setCorrect method, of class answers.
     */
    @Test
    public void testSetCorrect() {
        
        System.out.println("setCorrect");
        answers instance = new answers(10, 5, "test", "answertext", "N");
        instance.setCorrect("Y");
        assertTrue(instance.getCorrect().matches("Y"));
        
    }
    
    @Test
    public void reset() {
        getOracleConnection();
        try {
            PreparedStatement statement = conn.prepareStatement("DELETE FROM Answers");
            statement.execute();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error in tearDown() SQL: " + e.toString());
        }
        assertTrue(true);
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
    
}
