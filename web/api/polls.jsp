<%-- 
    Document   : poll
    Created on : 2011/5/25, ?? 09:44:09
    Author     : Hsu
--%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="database.*"%>
<%@page import = "java.text.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.Vector;"%>

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
    if(action == null && action.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "action = null");
         out.println("}");
		 run = false;
    }
    if(Pollid == null && action.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "Pollid = null");
         out.println("}");
		 run = false;
    }
	if(run){
		int id = Integer.parseInt(Pollid);
		polls.setPollID(id);
		if(action.equals("grab")){
			Vector<questions> results = polls.getQuestions();
				if(results != null){
					out.println("[");
					for(int i=0; i<results.size();i++) {
						Comparitives.setQuestID(results.get(i).getQuestID());
						Comparitives.getComparitive();
                                                /* check  this one*/
						Vector<answers> results_Answer = Questions.getAnswers();
						
						out.println("{");
						out.println("\"id\": " + results.get(i).getQuestID() + ",");
						out.println("\"compareTo\": \"" + Comparitives.getCompareTo() + "\",");
						out.println("\"demographic\": \"" + results.get(i).getDemographic() + "\",");
						out.println("\"responseType\": \"" + results.get(i).getResponseType() + "\",");
						out.println("\"text\": \"" + results.get(i).getQuestionText()  + "\",");
						out.println("\"created\": \"" + results.get(i).getCreated()  + "\",");
						out.println("\"font\": \"" + results.get(i).getFont()  + "\",");
						out.println("\"indicator\": \"" + results.get(i).getCorrectIndicator()  + "\",");
						out.println("\"chart\": \"" + results.get(i).getChartType()  + "\",");
						out.println("\"image\": \"" + results.get(i).getImages() + "\",");
						out.println("\"creator\": " + results.get(i).getCreator() + ",");
						out.println("\"responses\": [");
                                                /* below needs to be modified*/
						if(results_Answer != null){
							for (int j=0; j<results_Answer.size(); j++) {
								Rankings.setAnswerID(results_Answer.get(i).getAnswerID());
								Rankings.getRanking();
								out.println("\"id\": " + results_Answer.get(i).getAnswerID() + ",");
								out.println("\"keypad\": \"" + results_Answer.get(i).getKeypad() + "\",");
								out.println("\"text\": \"" + results_Answer.get(i).getAnswer() + "\",");
								out.println("\"questionID\": " + results_Answer.get(i).getQuestID() + ",");
								out.println("\"correct\": \"" + results_Answer.get(i).getCorrect()  + "\",");
								out.println("\"weight\": " + Rankings.getWeight());
								if((j+1) != results_Answer.size()){
                                                                    out.println(",");
								}
							}
                                                        
						}
						else{
							out.println("\"No Answers\"");
						}
						out.println("]");
						out.println("}");
						if((i+1) != results.size()){
                                                    out.println(",");
							
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