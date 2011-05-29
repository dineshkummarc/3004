<%-- 
    Document   : response
    Created on : 2011/5/25, ?? 09:44:56
    Author     : Hsu
--%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="database.*"%>
<%@page import = "java.text.*"%>
<%@ page import="java.io.*"%>

<%
try{
    String action = request.getParameter("action");
    String questID = request.getParameter("questID");
    String weight = request.getParameter("weight"); 
    String answer = request.getParameter("text");
    String keypad = request.getParameter("keypad");
    String answerID = request.getParameter("id");
    String correct = request.getParameter("correct");
    answers Answers = new answers();
    questions Questions = new questions();
    rankings Rankings = new rankings();
	Boolean run = true;
	if(run){
		if(Integer.parseInt(answerID) == -1){
			
            /*print message for debug 0: gd, -2 : bad */
			if(keypad != null || keypad.equals("")){
				Answers.setKeypad(keypad);
			}
			Answers.setAnswerText(answer);
			Answers.setQuestID(Integer.parseInt(questID));
			Answers.setCorrect(correct);
			int check = Answers.addAnswer();
			if(check == -2){
				out.println("{");
					out.println("\"Status:\" " + "\"error\"" + ",");
					out.println("\"Error:\" " + "\"answerID wrong or sth wrong in the answers.java file\"");
					out.println("}");
			}
			/*print message for debug 0: gd, -2 : bad */
                        Answers.setAnswerID(-1);
			if(weight != null){
				Rankings.setAnswerID(Answers.getAnswerID());
				Rankings.setWeight(Integer.parseInt(weight));
				int check1 = Rankings.addRanking();
				if(check1 == -2){
					out.println("{");
					out.println("\"Status:\" " + "\"error\"" + ",");
					out.println("\"Error:\" " + "\"answerID wrong or sth wrong in the rankings.java file\"");
					out.println("}");
				}
			}
        
		}
		
		if(Integer.parseInt(answerID) != -1 && action.equals("delete")){
                        answers answerShit = new answers(Integer.parseInt(answerID));
			//Answers.setAnswerID(Integer.parseInt(answerID));
			//Rankings.setAnswerID(Answers.getAnswerID());
			/*int check1 = Rankings.deleteRanking();
			if(check1 == -2){
				out.println("{");
				out.println("Status: " + "error" + ",");
				out.println("Error: " + "answerID wrong or sth wrong in the rankings.java file");
				out.println("}");
			}*/
			/*delete all the rankings which have the responseID*/
			//int check = Answers.deleteAnswer();
                        int check = answerShit.deleteAnswer();
			if(check == -2){
				out.println("\"Status:\" " + "\"error\"" + ",");
				out.println("\"Error:\" " + "\"answerID wrong or sth wrong in the answers.java file\"");
				out.println("}");
			}
			/*print message for debug 0: gd, -2 : bad */
		}
		else if(Integer.parseInt(answerID) != -1 && action.equals("update")){
			Answers.setAnswerID(Integer.parseInt(answerID));
			Answers.getAnswer();
			Answers.setKeypad(keypad);
			Answers.setCorrect(correct);
			Answers.setAnswerText(answer);
			/*print message for debug 0: gd, -2 : bad */
			int check = Answers.editAnswer();
			if(check == -2){
				out.println("\"Status:\" " + "\"error\"" + ",");
				out.println("\"Error:\" " + "\"answerID wrong or sth wrong in the answers.java file\"");
				out.println("}");
			}
		}
    }
}

catch(Exception e){
    out.write(e.toString());
}

%>