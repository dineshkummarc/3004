<%-- 
    Document   : poll
    Created on : 2011/5/25, ?? 09:44:09
    Author     : Hsu
--%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="database.*"%>
<%@page import = "java.text.*"%>
<%@ page import="java.io.*"%>

<%
try{
    
    String action = request.getParameter("action");
    String Pollid = request.getParameter("id");
    questions Questions = new questions();
    polls polls = new polls();
    rankings Rankings = new rankings();
    answers Answers = new answers();
    comparitives Comparitives = new comparitives();
	Boolean run = true;
    if(action == null && questID.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "action = null");
         out.println("}");
		 run = false;
    }
    if(Pollid == null && questID.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "Pollid = null");
         out.println("}");
		 run = false;
    }
	if(run){
		int id = Integer.parseInt(Pollid);
		polls.setPollID(id);
		if(action.equals("grab")){
			ResultSet results = polls.getQuestions();
			int size = 0;
				if(results != null){
					results.last();
					size = results.getRow()-1;
					results.beforeFirst();
					out.println("[");
					while (results.next()) {
						Questions.setQuestID(results.getInt(1));
						Questions.getQuestion();
						Comparitives.setQuestID(results.getInt(1));
						Comparitives.getComparitive();
						ResultSet results_Answer = Questions.getAnswers();
						out.println(Questions.getQuestionText());
						out.println("{");
						out.println("Question ID: " + Questions.getQuestID() + ",");
						out.println("Compare To: " + Comparitives.getCompareTo() + ",");
						out.println("Demographic: " + Questions.getDemographic() + ",");
						out.println("Response Type: " + Questions.getResponseType() + ",");
						out.println("Question: " + Questions.getQuestionText()  + ",");
						out.println("Created: " + Questions.getCreated()  + ",");
						out.println("Font: " + Questions.getFont()  + ",");
						out.println("Correct Indicator: " + Questions.getCorrectIndicator()  + ",");
						out.println("ChartType: " + Questions.getChartType()  + ",");
						out.println("Images: " + Questions.getImages() + ",");
						out.println("Creator: " + Questions.getCreator() + ",");
						int size_answer = 0;
						out.println("Answers: [");
						if(results_Answer != null){
							results_Answer.last();
							size_answer = results.getRow()-1;
							results_Answer.beforeFirst();
							while (results_Answer.next()) {
								Answers.setAnswerID(results_Answer.getInt(1));
								Rankings.setAnswerID(results_Answer.getInt(1));
								Answers.getAnswer();
								Rankings.getRanking();
								out.println("Answer ID: " + Answers.getAnswerID() + ",");
								out.println("Keypad: " + Answers.getKeypad() + ",");
								out.println("Answer: " + Answers.getAnswer() + ",");
								out.println("Question ID: " + Answers.getQuestID() + ",");
								out.println("Correct: " + Answers.getCorrect()  + ",");
								out.println("Weight: " + Rankings.getWeight());
								if(size_answer != 0){
									out.println(",");
									size_answer--;
								}
							}
						}
						else{
							out.println("No Answers")
						}
						out.println("]");
						out.println("}");
						if(size != 0){
							out.println(",");
							size--;
						}
					}
					out.println("]");
				}
				else{
					out.println("{");
					out.println("Status: " + "error" + ",");
					out.println("Error: " + "Poll ID does not exist, pick a existing one");
					out.println("}");
                   }
		}
    }
}

catch(Exception e){
    out.write(e.toString());
}
%>