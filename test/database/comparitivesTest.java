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
import static org.junit.Assert.*;

/**
 *
 * @author Darren
 */
public class comparitivesTest {
    
    public comparitivesTest() {
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
     * Test of addComparitive method, of class comparitives.
     */
    @Test
    public void testAddComparitive() {
        System.out.println("addComparitive");
        /* Finds it again */
        comparitives instance = new comparitives(1, 2);
        int expResult = 0;
        instance.addComparitive();
        comparitives test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(2);
        int result = test.getComparitive();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(3);
        expResult = -1;
        result = test.getComparitive();
        assertEquals(expResult, result);
    }

    /**
     * Test of editComparitive method, of class comparitives.
     */
    @Test
    public void testEditComparitive() {
        System.out.println("editComparitive");
        /* Finds it again */
        comparitives instance = new comparitives(1, 4);
        int expResult = 0;
        instance.editComparitive();
        comparitives test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(4);
        int result = test.getComparitive();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(5);
        expResult = -1;
        result = test.getComparitive();
        assertEquals(expResult, result);
    }

    /**
     * Test of deleteComparitive method, of class comparitives.
     */
    @Test
    public void testDeleteComparitive() {
        System.out.println("deleteComparitive");
        /* Finds it again */
        comparitives instance = new comparitives(1, 4);
        int expResult = 0;
        comparitives test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(4);
        int result = test.getComparitive();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        instance.deleteComparitive();
        test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(4);
        expResult = -1;
        result = test.getComparitive();
        assertEquals(expResult, result);
    }

    /**
     * Test of getComparitive method, of class comparitives.
     */
    @Test
    public void testGetComparitive() {
        System.out.println("getComparitive");
        /* Finds it again */
        comparitives instance = new comparitives(1, 4);
        int expResult = 0;
        instance.addComparitive();
        comparitives test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(4);
        int result = test.getComparitive();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        test = new comparitives();
        test.setQuestID(1);
        test.setCompareTo(5);
        expResult = -1;
        result = test.getComparitive();
        assertEquals(expResult, result);
    }

    /**
     * Test of setQuestID method, of class comparitives.
     */
    @Test
    public void testSetAndGetQuestID() {
        System.out.println("setQuestID");
        int questID = 0;
        int expResult = 0;
        comparitives instance = new comparitives();
        instance.setQuestID(questID);
        int result = instance.getQuestID();
        assertEquals(expResult, result);
    }
    
    /**
     * Test of setCompareTo method, of class comparitives.
     */
    @Test
    public void testSetAndGetCompareTo() {
        System.out.println("setCompareTo");
        int compareTo = 0;
        int expResult = 0;
        comparitives instance = new comparitives();
        instance.setCompareTo(compareTo);
        int result = instance.getCompareTo();
        assertEquals(expResult, result);
    }
}
