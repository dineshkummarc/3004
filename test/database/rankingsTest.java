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
public class rankingsTest {
    
    public rankingsTest() {
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
     * Test of addRanking method, of class rankings.
     */
    @Test
    public void testAddRanking() {
        System.out.println("addRanking");
        /* Finds it again */
        rankings instance = new rankings(1, 2);
        int expResult = 0;
        instance.addRanking();
        rankings test = new rankings();
        test.setAnswerID(1);
        int result = test.getRanking();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        test = new rankings();
        test.setAnswerID(2);
        expResult = -1;
        result = test.getRanking();
        assertEquals(expResult, result);
        
        instance.deleteRanking();
    }

    /**
     * Test of editRanking method, of class rankings.
     */
    @Test
    public void testEditRanking() {
        System.out.println("editRanking");
        /* Finds it again */
        rankings instance = new rankings(1, 2);
        instance.addRanking();
        
        int expResult = 2;
        int result = instance.getWeight();
        assertEquals(expResult, result);
        
        instance.setWeight(4);
        instance.editRanking();
        rankings test = new rankings();
        test.setAnswerID(1);
        
        expResult = 0;
        result = test.getRanking();
        assertEquals(expResult, result);
        
        expResult = 4;
        result = test.getWeight();
        assertEquals(expResult, result);
    }

    /**
     * Test of deleteRanking method, of class rankings.
     */
    @Test
    public void testDeleteRanking() {
        System.out.println("deleteRanking");
        /* Finds it again */
        rankings instance = new rankings(1, 4);
        int expResult = 0;
        rankings test = new rankings();
        test.setAnswerID(1);
        int result = test.getRanking();
        assertEquals(expResult, result);
        
        /* Doesn't exist */
        instance.deleteRanking();
        test = new rankings();
        test.setAnswerID(1);
        expResult = -1;
        result = test.getRanking();
        assertEquals(expResult, result);
    }

    /**
     * Test of getRanking method, of class rankings.
     */
    @Test
    public void testGetRanking() {
        System.out.println("getRanking");
        /* Finds it again */
        rankings instance = new rankings(1, 4);
        int expResult = 0;
        instance.addRanking();
        rankings test = new rankings();
        test.setAnswerID(1);
        int result = test.getRanking();
        assertEquals(expResult, result);
        
        instance.deleteRanking();
        
        /* Doesn't exist */
        test = new rankings();
        test.setAnswerID(1);
        expResult = -1;
        result = test.getRanking();
        assertEquals(expResult, result);
    }
}
