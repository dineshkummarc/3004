<%-- 
    Document   : poll
    Created on : 2011/5/25, ?? 09:44:09
    Author     : Hsu
--%>
<%@page import="java.util.ArrayList"%>
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
    listPolls listpolls = new listPolls();
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
		if(action.equals("grab")){
			ArrayList<String> results = listpolls.getQuestions(id);
                        ArrayList<Integer> results_qid = listpolls.getQIDs();
				if(results != null){
					out.println("[");
                                        int size_Q = results.size(); 
					for(int i=0; i<size_Q;i++) {
						//Comparitives.setQuestID(results.get(i).getQuestID());
						//Comparitives.getComparitive();
                                                /* check  this one*/
						String temp_Question = results.get(i);
                                                out.println(temp_Question);
                                                /* below needs to be modified*/
                                                
                                                ArrayList<String> results_Answer = listpolls.getAnswers(results_qid.get(i));
                                                //ArrayList<Integer> results_AnswerID = Questions.getAnswerID(Questions.getQuestID());
						if(results_Answer != null){
                                                
                                                        int size_A = results_Answer.size();
							for (int j=0; j<size_A; j++) {
                                                                 
								//Rankings.setAnswerID(results_AnswerID.get(j));
								//Rankings.getRanking();
								out.println(results_Answer.get(j));
								//out.println(",\"weight\": " + Rankings.getWeight() + "}");
								if((j+1) != results_Answer.size()){
                                                                    out.println(",");
								}
							}
                                                        
						}
						out.println("]");
						out.println("}");
						if((i+1) != results.size()){
                                                    out.println(",");
							
						}
					}
					out.println("]");
                                        listpolls.closeOracleConnection();
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