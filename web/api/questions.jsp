<%-- 
    Document   : questions
    Created on : 2011/5/25, ?? 09:44:38
    Author     : Hsu
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import = "java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="database.*"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.Vector;"%>
<%
try{

    String action = request.getParameter("action");
    String compareTo = request.getParameter("compareTo"); 
    String pollID = request.getParameter("pollID");
    String responseType = request.getParameter("qformat");
    String questID = request.getParameter("id");
    String demographic = request.getParameter("demographic");
    String images = request.getParameter("image");
    /* String created = request.getParameter("created"); */
	String question = request.getParameter("text");
	/* for demo only*/
    int creator = 1;
    String font = request.getParameter("font");
    String chartType = request.getParameter("chart");
    String correctIndicator = request.getParameter("indicator");
    questions Questions = new questions();
    rankings Rankings = new rankings();
    answers Answers = new answers();
    comparitives Comparitives = new comparitives();
	Boolean run = true;
	
    /*if(questID == null && questID.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "Qid = null");
         out.println("}");
		 run = false;
    }
    if(action == null && action.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "action = null");
         out.println("}");
		 run = false;
    }
    if(pollID == null && pollID.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "pollID = null");
         out.println("}");
		 run = false;
    }
	 if(compareTo == null && compareTo.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "compareTo = null");
         out.println("}");
		 run = false;
    }
	 if(responseType == null && responseType.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "responseType = null");
         out.println("}");
		 run = false;
    }
	 if(demographic == null && demographic.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "demographic = null");
         out.println("}");
		 run = false;
    }
	if(images == null && images.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "images = null");
         out.println("}");
		 run = false;
    }
	if(correctIndicator == null && correctIndicator.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "correctIndicator = null");
         out.println("}");
		 run = false;
    }
	if(font == null && font.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "font = null");
         out.println("}");
		 run = false;
    }
	if(question == null && question.equals("")){
         out.println("Status: " + "error" + ",");
         out.println("Error: " + "question = null");
         out.println("}");
		 run = false;
    /*}*/
	if(run){
    if(Integer.parseInt(questID) == -1){
         
            /* print message for debug 0: gd, -2 : bad */
        
        Questions.setQuestID(10);/* set a new id for the Q*/
        Questions.setDemographic(demographic);
        Questions.setResponseType(responseType);
        Questions.setQuestionText(question);
        Questions.setPollID(Integer.parseInt(pollID));
        /* convert string to timestamp*/
        /*try{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Date temp_date  = sdf.parse(created);
        Timestamp temp_timestamp = new Timestamp(temp_date.getTime());
        Questions.setCreated(temp_timestamp);
        }
        catch (ParseException e){
            out.println(e.getMessage());

        }
 * */
        Questions.setFont(font);
        Questions.setCorrectIndicator(correctIndicator);
        Questions.setChartType(Integer.parseInt(chartType));
        Questions.setImages(images);
        Questions.setCreator(1);
        int check = Questions.addQuestion();
        if(check == -2){
            out.println("{");
                out.println("\"status\": " + "\"error\"" + ",");
                out.println("\"error\": " + "\"Qid wrong or sth wrong in the question.java file\"");
                out.println("}");
        }
        if(compareTo != null && compareTo == "comparitive"){
            Comparitives.setCompareTo(Integer.parseInt(compareTo));
            Comparitives.setQuestID(Questions.getQuestID());
            int check1 = Comparitives.addComparitive();
            if(check1 == -2){
                out.println("{");
                out.println("\"status\": " + "\"error\"" + ",");
                out.println("\"error\": " + "\"Qid wrong or sth wrong in the comparitives.java file\"");
                out.println("}");
            }
        } 
        out.println("{");
        out.println("\"status\": " + "\"ok\"" + ",");
        out.println("\"newid\": " + check);
        out.println("}");
         /* print message for debug 0: gd, -2 : bad */
    }
    if(Integer.parseInt(questID) != -1 && action.equals("delete")){
                
            //Comparitives.setQuestID(Integer.parseInt(questID));
            /*Comparitives.deleteComparitive();
            int check1 = Comparitives.deleteComparitive();
            if(check1 == -2){
                out.println("{");
                out.println("Status: " + "error" + ",");
                out.println("Error: " + "Qid wrong or sth wrong in the comparitives.java file");
                out.println("}");
            }*/
            Questions.setQuestID(Integer.parseInt(questID));
            int check = Questions.deleteQuestion();
            if(check == -2){
                out.println("{");
                out.println("\"status\": " + "\"error\"" + ",");
                out.println("\"error\": " + "\"Qid wrong or sth wrong in the question.java file\"");
                out.println("}");
            }
            /*print message for debug 0: gd, -2 : bad */
        
    }
    else if(Integer.parseInt(questID) != -1 && action.equals("update")){
        Questions.setQuestID(Integer.parseInt(questID));
        Questions.getQuestion();
        Questions.setDemographic(demographic);
        Questions.setImages(images);
        Questions.setFont(font);
        if(pollID != null){
            Questions.setPollID(Integer.parseInt(pollID));
        }
        Questions.setQuestionText(question);
        Questions.setResponseType(responseType);
        Questions.setChartType(Integer.parseInt(chartType));
        Questions.setCorrectIndicator(correctIndicator);
        int check = Questions.editQuestion();
            if(check == -2){
                out.println("{");
                out.println("\"status\": " + "\"error\"" + ",");
                out.println("\"error\": " + "\"Qid wrong or sth wrong in the question.java file\"");
                out.println("}");
            }
         /*print message for debug 0: gd, -2 : bad */
		}
	}
}

catch(Exception e){
    out.write(e.toString());
}

%>
