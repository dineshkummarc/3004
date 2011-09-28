/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * controller.java
 *
 * Created on Sep 26, 2011, 10:06:03 PM
 */
package webapps;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import javax.swing.DefaultListModel;
/**
 *
 * @author Darren
 */
public class controller extends javax.swing.JApplet {
    private String path = "file:/c:/applet/";
    private int userID;
    
    private String getJson(String jspURL) {
	try {
	// Send data
	URL url = new URL(jspURL);
;
	URLConnection conn = url.openConnection();
	// Get the response
	BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	String line;
	String result = "";
	while ((line = rd.readLine()) != null) {
	    result = result + line;
	}
	rd.close();
	return result;
	} catch (Exception e) {
	    System.err.println(e.getMessage());
	    System.err.println(jspURL);
	    return "";
	}
    }
    
    private void getUserID() {
	String json = getJson(path + "getuserid.jsp");
	userID = Integer.parseInt(json);
    }
    
    private void getQuestions(int pollID) {
	//String json = getJson(path + "getquestions.jsp?pollid=" + pollID);
	String json = getJson(path + "getquestions.jsp"); //Testing
	Gson gson = new Gson();
	Questions questions = gson.fromJson(json, Questions.class);   
	((DefaultListModel)questionList.getModel()).clear();
	for (pollPairing p : questions.getQuestions()) {
	    ((DefaultListModel)questionList.getModel()).addElement(p);
	}
    }
    
    private void getQuestion(int questID) {
	//String json = getJson(path + "getquestion.jsp?questionid=" + questID);
	String json = getJson(path + "getquestion.jsp"); //Testing
	Gson gson = new Gson();
	Question question = gson.fromJson(json, Question.class);
	//Set 
	//lblQuestion
	//lblAnswer1
	//lblAnswer2
	//lblAnswer3
	//lblAnswer4
	//lblAnswer5
	//lblAnswer6
	//lblAnswer7
	//lblAnswer8
	//lblAnswer9
	//lblAnswer0
	//enable both jlists
	//Enabled start question
	//Disable stop question
	//Disable next question
    }
    
    private void startQuestion(int questID) {
	String json = getJson(path + "startquestion.jsp?questionid=" + questID);
	//Disable start question
	//Enable stop question
	//Enable next question
	//Disable both jlists
	//Disable channel textbox
	//Disable channel button
    }
    
    private void stopQuestion(int questID) {
	String json = getJson(path + "stopquestion.jsp?questionid=" + questID);
	//enable start question
	//disable stop question
	//disable next question
	//enable both jlists
	//enable channel textbox
	//enable channel button
    }
    
    private void nextQuestion(int questID) {
	String json = getJson(path + "nextquestion.jsp?questionid=" + questID);
	Gson gson = new Gson();
	Question question = gson.fromJson(json, Question.class);
	//Set 
	//lblQuestion
	//lblAnswer1
	//lblAnswer2
	//lblAnswer3
	//lblAnswer4
	//lblAnswer5
	//lblAnswer6
	//lblAnswer7
	//lblAnswer8
	//lblAnswer9
	//lblAnswer0
	//enable start question
	//disable stop question
	//disable next question
	//enable both jlists
	//enable channel textbox
	//enable channel button
    }
    
    private void sendResponse(int questID, int clickerID, String response) {
	String json = getJson(path + "clickeranswer.jsp?questionid=" + questID + "&clickerID=" + clickerID + "&response=" + response);	
    }
    
    private void getPolls() {
	//String json = getJson(path + "getpolls.jsp?userid=" + userID);
	String json = getJson(path + "getpolls.jsp"); //Testing
	Gson gson = new Gson();
	Polls polls = gson.fromJson(json, Polls.class);   
	((DefaultListModel)pollList.getModel()).clear();
	for (pollPairing p : polls.getPolls()) {
	    ((DefaultListModel)pollList.getModel()).addElement(p);
	}
    }
    /** Initializes the applet controller */
    @Override
    public void init() {
	/* Set the Nimbus look and feel */
	//<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
	 * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
	 */
	try {
	    for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
		if ("Nimbus".equals(info.getName())) {
		    javax.swing.UIManager.setLookAndFeel(info.getClassName());
		    break;
		}
	    }
	} catch (ClassNotFoundException ex) {
	    java.util.logging.Logger.getLogger(controller.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
	} catch (InstantiationException ex) {
	    java.util.logging.Logger.getLogger(controller.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
	} catch (IllegalAccessException ex) {
	    java.util.logging.Logger.getLogger(controller.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
	} catch (javax.swing.UnsupportedLookAndFeelException ex) {
	    java.util.logging.Logger.getLogger(controller.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
	}
	//</editor-fold>

	/* Create and display the applet */
	try {
	    java.awt.EventQueue.invokeAndWait(new Runnable() {

		public void run() {
		    initComponents();
		}
	    });
	} catch (Exception ex) {
	    ex.printStackTrace();
	}
	pollList.setModel(new DefaultListModel());
	getUserID();
	getPolls();
    }

    /** This method is called from within the init() method to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        pollList = new javax.swing.JList();
        jScrollPane2 = new javax.swing.JScrollPane();
        questionList = new javax.swing.JList();
        jLabel1 = new javax.swing.JLabel();
        txtChannel = new javax.swing.JTextField();
        cmdSet = new javax.swing.JButton();
        lblQuestion = new javax.swing.JLabel();
        lblAnswer1 = new javax.swing.JLabel();
        cmdStart = new javax.swing.JButton();
        cmdStop = new javax.swing.JButton();
        cmdNext = new javax.swing.JButton();
        lblAnswer2 = new javax.swing.JLabel();
        lblAnswer3 = new javax.swing.JLabel();
        lblAnswer4 = new javax.swing.JLabel();
        lblAnswer5 = new javax.swing.JLabel();
        lblAnswer6 = new javax.swing.JLabel();
        lblAnswer7 = new javax.swing.JLabel();
        lblAnswer8 = new javax.swing.JLabel();
        lblAnswer9 = new javax.swing.JLabel();
        lblAnswer0 = new javax.swing.JLabel();

        pollList.setModel(new javax.swing.AbstractListModel() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public Object getElementAt(int i) { return strings[i]; }
        });
        pollList.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
        pollList.setSelectedIndex(0);
        jScrollPane1.setViewportView(pollList);

        questionList.setModel(new javax.swing.AbstractListModel() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public Object getElementAt(int i) { return strings[i]; }
        });
        questionList.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);
        questionList.setEnabled(false);
        jScrollPane2.setViewportView(questionList);

        jLabel1.setText("Receiver Channel:");

        txtChannel.setText("42");
        txtChannel.setName(""); // NOI18N
        txtChannel.setPreferredSize(new java.awt.Dimension(27, 20));

        cmdSet.setText("Set");

        lblQuestion.setText("Question goes here!");

        lblAnswer1.setText("jLabel2");

        cmdStart.setText("Start question");

        cmdStop.setText("Stop question");

        cmdNext.setText("Next question");

        lblAnswer2.setText("jLabel3");

        lblAnswer3.setText("jLabel4");

        lblAnswer4.setText("jLabel5");

        lblAnswer5.setText("jLabel6");

        lblAnswer6.setText("jLabel7");

        lblAnswer7.setText("jLabel8");

        lblAnswer8.setText("jLabel9");

        lblAnswer9.setText("jLabel10");

        lblAnswer0.setText("jLabel2");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 90, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(txtChannel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addComponent(lblQuestion, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 387, Short.MAX_VALUE)
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                .addComponent(cmdStart)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 10, Short.MAX_VALUE)
                                .addComponent(cmdStop, javax.swing.GroupLayout.DEFAULT_SIZE, 127, Short.MAX_VALUE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addComponent(cmdNext, javax.swing.GroupLayout.DEFAULT_SIZE, 129, Short.MAX_VALUE)
                                .addGap(14, 14, 14)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(cmdSet))
                    .addComponent(lblAnswer3, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer4, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer5, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer6, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer7, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer8, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer9, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer2, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer1, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE)
                    .addComponent(lblAnswer0, javax.swing.GroupLayout.DEFAULT_SIZE, 442, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(txtChannel, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(cmdSet)
                            .addComponent(jLabel1))
                        .addGap(21, 21, 21)
                        .addComponent(lblQuestion)
                        .addGap(44, 44, 44)
                        .addComponent(lblAnswer1)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer2)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer3)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer4)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer5)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer6)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer7)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer8)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer9)
                        .addGap(18, 18, 18)
                        .addComponent(lblAnswer0)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 14, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(cmdStart)
                            .addComponent(cmdStop)
                            .addComponent(cmdNext)))
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 441, Short.MAX_VALUE)
                    .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 441, Short.MAX_VALUE))
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton cmdNext;
    private javax.swing.JButton cmdSet;
    private javax.swing.JButton cmdStart;
    private javax.swing.JButton cmdStop;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JLabel lblAnswer0;
    private javax.swing.JLabel lblAnswer1;
    private javax.swing.JLabel lblAnswer2;
    private javax.swing.JLabel lblAnswer3;
    private javax.swing.JLabel lblAnswer4;
    private javax.swing.JLabel lblAnswer5;
    private javax.swing.JLabel lblAnswer6;
    private javax.swing.JLabel lblAnswer7;
    private javax.swing.JLabel lblAnswer8;
    private javax.swing.JLabel lblAnswer9;
    private javax.swing.JLabel lblQuestion;
    private javax.swing.JList pollList;
    private javax.swing.JList questionList;
    private javax.swing.JTextField txtChannel;
    // End of variables declaration//GEN-END:variables
}




class Answer {
    private int answerID;
    private char keypad;
    private String answer;
    private char correct;

    /**
     * @return the answerID
     */
    public int getAnswerID() {
	return answerID;
    }

    /**
     * @param answerID the answerID to set
     */
    public void setAnswerID(int answerID) {
	this.answerID = answerID;
    }

    /**
     * @return the keypad
     */
    public char getKeypad() {
	return keypad;
    }

    /**
     * @param keypad the keypad to set
     */
    public void setKeypad(char keypad) {
	this.keypad = keypad;
    }

    /**
     * @return the answer
     */
    public String getAnswer() {
	return answer;
    }

    /**
     * @param answer the answer to set
     */
    public void setAnswer(String answer) {
	this.answer = answer;
    }

    /**
     * @return the correct
     */
    public char getCorrect() {
	return correct;
    }

    /**
     * @param correct the correct to set
     */
    public void setCorrect(char correct) {
	this.correct = correct;
    }

}



class Question {
    private int questID;
    private char demographic;
    private String responseType;
    private String question;
    private String title;
    private int pollID;
    private Date created;
    private String font;
    private String fontColor;
    private String correctIndicator;
    private String images;
    private int creator;
    private String location;
    private List<Answer> answers;

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
     * @return the demographic
     */
    public char getDemographic() {
	return demographic;
    }

    /**
     * @param demographic the demographic to set
     */
    public void setDemographic(char demographic) {
	this.demographic = demographic;
    }

    /**
     * @return the responseType
     */
    public String getResponseType() {
	return responseType;
    }

    /**
     * @param responseType the responseType to set
     */
    public void setResponseType(String responseType) {
	this.responseType = responseType;
    }

    /**
     * @return the question
     */
    public String getQuestion() {
	return question;
    }

    /**
     * @param question the question to set
     */
    public void setQuestion(String question) {
	this.question = question;
    }

    /**
     * @return the title
     */
    public String getTitle() {
	return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title) {
	this.title = title;
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
     * @return the created
     */
    public Date getCreated() {
	return created;
    }

    /**
     * @param created the created to set
     */
    public void setCreated(Date created) {
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
     * @return the fontColor
     */
    public String getFontColor() {
	return fontColor;
    }

    /**
     * @param fontColor the fontColor to set
     */
    public void setFontColor(String fontColor) {
	this.fontColor = fontColor;
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

    /**
     * @return the answers
     */
    public List<Answer> getAnswers() {
	return answers;
    }

    /**
     * @param answers the answers to set
     */
    public void setAnswers(List<Answer> answers) {
	this.answers = answers;
    }
    
}


class Polls {
    private List<pollPairing> polls;

    /**
     * @return the polls
     */
    public List<pollPairing> getPolls() {
	return polls;
    }

    /**
     * @param polls the polls to set
     */
    public void setPolls(List<pollPairing> polls) {
	this.polls = polls;
    }
}

class Questions {
    private List<pollPairing> questions;

    /**
     * @return the polls
     */
    public List<pollPairing> getQuestions() {
	return questions;
    }

    /**
     * @param polls the polls to set
     */
    public void setQuestions(List<pollPairing> questions) {
	this.questions = questions;
    }
}

class pollPairing {
    private int ID;
    private String Name;
    // +getters.

    /**
     * @return the ID
     */
    public int getID() {
	return ID;
    }

    /**
     * @param ID the ID to set
     */
    public void setID(int ID) {
	this.ID = ID;
    }

    /**
     * @return the Name
     */
    public String getName() {
	return Name;
    }

    /**
     * @param Name the Name to set
     */
    public void setName(String Name) {
	this.Name = Name;
    }
    
    public String toString() {
	return Name;
    }
}
