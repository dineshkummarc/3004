/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.ResultSet;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;

/**
 *
 * @author s4203658
 */
public class pollsTest {
    Connection conn;
    
    public pollsTest() {
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
     * Test of getQuestions method, of class polls.
     */
    @Test
    public void testGetQuestions() {
        System.out.println("getQuestions");
        reset();
        
        polls instance = new polls(2, "FruitVeg", "Brisbane", "Fruits and vegetables");
        instance.addPoll();
        java.util.Date date = new java.util.Date();
        
        questions q1 = new questions(2, "d", "s", "What is your favourite kind of carrot?", new Timestamp(date.getTime()), 
            "Arial", "image", 1, "img", 2);
        q1.addQuestion();
        /*questions q2 = new questions(2, "d", "s", "What is your favourite kind of lemon", new Timestamp(date.getTime()), 
            "Arial", "image", 1, "img", 2);
        q2.addQuestion();/*
        questions q3 = new questions(300, 6, "d", "s", "What is your favourite kind of mango", new Timestamp(date.getTime()), 
            "Arial", "image", 1, "img", 2);
        q3.addQuestion();*/
        
        Vector<questions> q = instance.getQuestions();
        ArrayList<String> actual = new ArrayList<String>();
        ArrayList<String> good = new ArrayList<String>();
        
        
        
        good.add("What is your favourite kind of carrot?");
        //good.add("What is your favourite kind of lemon?");
       // good.add("What is your favourite kind of mango?");
        
        /*try {
            while(questions.next()) {
                actual.add(questions.getNString("question"));
            }
        }
        catch(SQLException e) {
            System.out.println("SQL error in testGetQuestions() instance.getQuestion(): " + e.toString());
        }*/

        assertEquals(good.get(0), q.get(0).getQuestionText());

    }

    /**
     * Test of addPoll method, of class polls.
     */
    @Test
    public void testAddPoll() {
        System.out.println("addPoll");
        polls instance = new polls(1, "FruitVeg", "1", "Fruits and vegetables");
        instance.addPoll();

        try {
            reset();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Polls WHERE pollID='1'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertTrue(rset.getNString("description").matches("FruitVeg"));
            }
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("ERROR OCCURRED IN testAddPoll(): " + e.toString());
        }
    }
    
    @Test
    public void testGetAllPollsByUser() {
        reset();
        System.out.println("testGetAllPollsByUser()");
        polls instance = new polls(1, "FruitVeg", "1", "Fruits and vegetables");
        instance.addPoll();
        polls instance1 = new polls(2, "Icecream", "1", "Favourite icecream flavour");
        instance1.addPoll();
        try {
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO ASSIGNED(userID, pollID, role) VALUES" +
                "(?, ?, ?)");
            statement.setInt(1, 1);
            statement.setInt(2, 1);
            statement.setString(3, "Web User");
            statement.executeUpdate();

            
            statement.setInt(1, 1);
            statement.setInt(2, 2);
            statement.setString(3, "Web User");
            statement.executeUpdate();
            statement.close();
            
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error in testGetAllPollsByUser(): " + e.toString());
        }
        
        assertEquals(1, instance.getAllPollsByUser(1).get(0).getPollID());
        assertEquals(2, instance.getAllPollsByUser(1).get(1).getPollID());
        
    }
            

    /**
     * Test of editPoll method, of class polls.
     */
    @Test
    public void testEditPoll() {
        System.out.println("editPoll");
        reset();
        polls instance = new polls(1, "FruitVeg", "1", "Fruits and vegetables");
        instance.addPoll();
        instance = new polls(1, "Banana", "1", "Fruit");
        instance.editPoll();

        try {
            reset();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Polls WHERE pollID='1'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertTrue(rset.getNString("description").matches("Banana"));
                assertTrue(rset.getNString("pollName").matches("Fruits and vegetables"));
            }
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("ERROR OCCURRED IN testEditPoll(): " + e.toString());
        }
    }

    /**
     * Test of deletePoll method, of class polls.
     */
    @Test
    public void testDeletePoll() {
        System.out.println("deletePoll");
        reset();
        polls instance = new polls(1, "FruitVeg", "1", "Fruits and vegetables");
        instance.addPoll();
        instance.deletePoll();

        try {
            reset();
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM Polls WHERE pollID='1'");
            ResultSet rset = statement.executeQuery();
            while(rset.next()) {
                assertEquals("Hasn't been deleted", "Fail: Hasn't been deleted");
            }
            rset.close();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("ERROR OCCURRED IN testDeletePoll(): " + e.toString());
        }
    }

    /**
     * Test of getPoll method, of class polls.
     */
    @Test
    public void testGetPoll() {
        System.out.println("getPoll");
        
        try {
            getOracleConnection();
            PreparedStatement statement = conn.prepareStatement("INSERT INTO POLLS(pollID, pollName, location, description) VALUES" +
                "(?, ?, ?, ?)");
            statement.setInt(1, 1);
            statement.setString(2, "Banana");
            statement.setString(3, "1");
            statement.setString(4, "Bananas");
            statement.executeUpdate();
            statement.close();
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error in testGetPoll(): " + e.toString());
        }
        polls instance = new polls(1);
        instance.getPoll();
        assertEquals(instance.getPollName(), "Banana");
        assertEquals(instance.getDescription(), "Bananas");
    }

    /**
     * Test of setPollID method, of class polls.
     */
    @Test
    public void testSetPollID() {
        polls instance = new polls();
        instance.setPollID(1);
        assertEquals(1, instance.getPollID());
    }

    /**
     * Test of getPollID method, of class polls.
     */
    @Test
    public void testGetPollID() {
        System.out.println("getPollID");
        polls instance = new polls(1, "", "", "");     
        assertEquals(1, instance.getPollID());
    }

    /**
     * Test of getPollName method, of class polls.
     */
    @Test
    public void testGetPollName() {
        System.out.println("getPollName");
        polls instance = new polls(1, "test", "", "");     
        assertTrue(instance.getPollName().matches("test"));
    }

    /**
     * Test of setPollName method, of class polls.
     */
    @Test
    public void testSetPollName() {
        System.out.println("setPollName");
        polls instance = new polls(1, "test", "", "");
        instance.setPollName("test1");
        assertTrue(instance.getPollName().matches("test1"));
    }

    /**
     * Test of getLocation method, of class polls.
     */
    @Test
    public void testGetLocation() {
        System.out.println("getLocation");
        polls instance = new polls(1, "test", "loc", "");
        assertTrue(instance.getLocation().matches("loc"));
    }

    /**
     * Test of setLocation method, of class polls.
     */
    @Test
    public void testSetLocation() {
        System.out.println("setLocation");
        polls instance = new polls(1, "test", "loc", "");
        instance.setLocation("loc1");
        assertTrue(instance.getLocation().matches("loc1"));
    }

    /**
     * Test of getDescription method, of class polls.
     */
    @Test
    public void testGetDescription() {
        System.out.println("getDescription");
        polls instance = new polls(1, "test", "loc", "desc");
        assertTrue(instance.getDescription().matches("desc"));
    }

    /**
     * Test of setDescription method, of class polls.
     */
    @Test
    public void testSetDescription() {
        System.out.println("setDescription");
        polls instance = new polls(1, "test", "loc", "desc");
        instance.setDescription("desc1");
        assertTrue(instance.getDescription().matches("desc1"));
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
    
    @Test
    public void reset() {
        getOracleConnection();
        try {
            PreparedStatement statement = conn.prepareStatement("TRUNCATE TABLE Polls");
            statement.execute();
            statement.close();
            PreparedStatement cockstatement = conn.prepareStatement("TRUNCATE TABLE Questions");
            cockstatement.execute();
            cockstatement.close();
            PreparedStatement assignedStatement = conn.prepareStatement("TRUNCATE TABLE Assigned");
            assignedStatement.execute();
            assignedStatement.close();
            
            conn.close();
        }
        catch(SQLException e) {
            System.out.println("Error in reset() SQL: " + e.toString());
        }
        assertTrue(true);
    }
    
}
