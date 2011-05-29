/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.Date;
import java.util.Vector;
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
public class questionsTest {
    
    public questionsTest() {
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
     * Test of getAnswers method, of class questions.
     */
    @Test
    public void testGetAnswers() {
        System.out.println("getAnswers");
        questions instance = new questions(1);
        instance.setPollID(1);
        instance.setQuestionText("test");
        instance.addQuestion();
        
        answers instance2 = new answers(10, 1, "4", "answertext", "N");
        instance2.addAnswer();
        
        int expResult = 10;
        int result = instance.getAnswers().get(0).getAnswerID();
        assertEquals(expResult, result);
        
        expResult = 1;
        result = instance.getAnswers().size(); 
        assertEquals(expResult, result);
        
        instance2.deleteAnswer();
        expResult = 0;
        result = instance.getAnswers().size(); 
        assertEquals(expResult, result);
        
        instance.deleteQuestion();
    }

    /**
     * Test of addQuestion method, of class questions.
     */
    @Test
    public void testAddQuestion() {
        System.out.println("addQuestion");
        questions instance = new questions(1);
        instance.setPollID(1);
        instance.setQuestionText("test");
        instance.addQuestion();
        
        questions instance2 = new questions(1);
        instance2.getQuestion();
        
        String expResult = "test";
        String result = instance2.getQuestionText();
        assertEquals(expResult, result);
        
        instance.deleteQuestion();
    }

    /**
     * Test of editQuestion method, of class questions.
     */
    @Test
    public void testEditQuestion() {
        System.out.println("editQuestion");
        questions instance = new questions(1);
        instance.setPollID(1);
        instance.setQuestionText("test");
        instance.addQuestion();
        
        String expResult = "test";
        String result = instance.getQuestionText();
        assertEquals(expResult, result);
        
        instance.setQuestionText("Different");
        instance.editQuestion();
        
        questions instance2 = new questions(1);
        instance2.getQuestion();
        
        expResult = "Different";
        result = instance2.getQuestionText();
        assertEquals(expResult, result);
        
        instance.deleteQuestion();
    }

    /**
     * Test of deleteQuestion method, of class questions.
     */
    @Test
    public void testDeleteQuestion() {
        System.out.println("deleteQuestion");
        questions instance = new questions(1);
        instance.setPollID(1);
        instance.setQuestionText("test");
        instance.addQuestion();
        
        questions instance2 = new questions(1);
        instance2.getQuestion();
        
        String expResult = "test";
        String result = instance2.getQuestionText();
        assertEquals(expResult, result);
        
        instance.deleteQuestion();
        
        int result2 = instance2.getQuestion();
        int expResult2 = -1;
        assertEquals(expResult2, result2);
    }

    /**
     * Test of findQuestions method, of class questions.
     */
    @Test
    public void testFindQuestions() {
        System.out.println("findQuestions");
        questions instance = new questions(1);
        instance.setPollID(1);
        instance.setQuestionText("test");
        instance.setCreated(new Date(111,5,27));
        instance.addQuestion();
        
        questions instance2 = new questions(2);
        instance2.setPollID(2);
        instance2.setQuestionText("test2");
        instance2.setCreated(new Date(111,5,25));
        instance2.addQuestion();
        
        questions instance3 = new questions(3);
        instance3.setPollID(3);
        instance3.setQuestionText("test3");
        instance3.setCreated(new Date(111,5,29));
        instance3.addQuestion();
        
        questions finder = new questions();
        Vector<questions> result = new Vector();
        result = finder.findQuestions(new Date(111,5,26), new Date(111,5,28));
        
        int expSize = 1;
        int resultSize = result.size();
        
        String expQuestionText = "test";
        String resultText = result.get(0).getQuestionText();
        
        assertEquals(expSize, resultSize);
        assertEquals(expQuestionText, resultText);
        
        instance.deleteQuestion();
        instance2.deleteQuestion();
        instance3.deleteQuestion();
    }
}
