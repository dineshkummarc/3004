<%-- 
    Document   : listpolls-json
    Created on : 13/08/2011, 10:19:03 AM
    Author     : Aidan Rowe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="db.*"%>
<jsp:useBean id="db" scope="session" class="db.database" /> 
<%@ page import = "java.util.ArrayList" %>

<%
String pollID = request.getParameter( "poll" );

if (pollID.equals("") || pollID == null ) {
    out.print("{ \"error\": \"Invalid PollID.\"}");
} else {

    if (db.getLoggedIn() == 1) {

        String userID = Integer.toString(db.getUserID());
        
        //Check to see if user is actually assigned to that poll
        
        String checkIn[] = new String[2];
        checkIn[0] = userID;
        checkIn[1] = pollID;
        
        String checkTyp[] = new String[2];
        checkTyp[0] = "int";
        checkTyp[1] = "int";
        
        String checkCN[] = new String[1];
        checkCN[0] = "userID";
        String checkCT[] = new String[1];
        checkCT[0] = "int";
        
        ArrayList<String[]> assigned = new ArrayList<String[]>();
        //Change it so it only selects questions which have not been answered yet
        assigned = db.doPreparedQuery("SELECT userID FROM assigned WHERE userID = ? AND pollID = ?", checkIn, checkTyp, checkCN, checkCT);
        
        if (assigned.size() != 0) {
        

            String inputs[];
            inputs = new String[2];
            inputs[0] = pollID;
            inputs[1] = userID;

            String types[];
            types = new String[2];
            types[0] = "int";
            types[1] = "int";
            
            String inputsA[];
            inputsA = new String[1];
            

            String typesA[];
            typesA = new String[1];
            typesA[0] = "int";

            String columnNames[];
            columnNames = new String[9];
            columnNames[0] = "questID";
            columnNames[1] = "responseType";
            columnNames[2] = "question";
            columnNames[3] = "font";
            columnNames[4] = "correctIndicator";
            columnNames[5] = "images";
            columnNames[6] = "fontColor";
            columnNames[7] = "fontSize";
            columnNames[8] = "chartType";

            String columnTypes[];
            columnTypes = new String[9];
            columnTypes[0] = "int";
            columnTypes[1] = "string";
            columnTypes[2] = "string";
            columnTypes[3] = "string";
            columnTypes[4] = "string";
            columnTypes[5] = "string";
            columnTypes[6] = "string";
            columnTypes[7] = "string";
            columnTypes[8] = "string";


            String columnNamesQ[];
            columnNamesQ = new String[3];
            columnNamesQ[0] = "answerID";
            columnNamesQ[1] = "answer";
            columnNamesQ[2] = "correct";

            String columnTypesQ[];
            columnTypesQ = new String[3];
            columnTypesQ[0] = "int";
            columnTypesQ[1] = "string";
            columnTypesQ[2] = "string";
            
            
            String inputsW[];
            inputsW = new String[1];
            

            String typesW[];
            typesW = new String[1];
            typesW[0] = "int";
            
            String columnNamesW[];
            columnNamesW = new String[2];
            columnNamesW[0] = "widgetName";
            columnNamesW[1] = "widgetDescription";

            String columnTypesW[];
            columnTypesW = new String[2];
            columnTypesW[0] = "string";
            columnTypesW[1] = "string";
            
            ArrayList<String[]> questions = new ArrayList<String[]>();
            //Change it so it only selects questions which have not been answered yet
            questions = db.doPreparedQuery("SELECT * FROM Questions WHERE pollID = ? AND questID NOT IN (SELECT questID FROM Responses WHERE userID = ?)", inputs, types, columnNames, columnTypes);
            //questions = db.doPreparedQuery("SELECT * FROM Questions WHERE pollID = ?", inputs, types, columnNames, columnTypes);

            ArrayList<String[]> answers = new ArrayList<String[]>();
            ArrayList<String[]> widgets = new ArrayList<String[]>();

            out.print("{ \"questions\": [");

            for ( int i = 0; i  < questions.size(); i++) {
                out.print("{");
                out.print("\"id\": " + questions.get(i)[0] + ", ");
                out.print("\"type\": \"" + questions.get(i)[1] + "\", ");
                out.print("\"question\": \"" + questions.get(i)[2] + "\", ");
                out.print("\"font\": \"" + questions.get(i)[3] + "\", ");
                out.print("\"correctIndicator\": \"" + questions.get(i)[4] + "\", ");
                out.print("\"images\": \"" + questions.get(i)[5] + "\",");
                out.print("\"fontColor\": \"" + questions.get(i)[6] + "\", ");
                out.print("\"fontSize\": \"" + questions.get(i)[7] + "\", ");
                out.print("\"chartType\": \"" + questions.get(i)[8] + "\", ");

                inputsA[0] = questions.get(i)[0];
                answers = db.doPreparedQuery("SELECT * FROM Answers WHERE questID = ?", inputsA, typesA, columnNamesQ, columnTypesQ);

                if (answers.size() > 0) {
                    out.print("\"answers\": [");
                    for (int j = 0; j < answers.size(); j++) {
                        out.print("{ \"id\":" + answers.get(j)[0] + ",");
                        
                        out.print("\"answer\": \"" + answers.get(j)[1] + "\",");
                        
                        out.print("\"correct\": \"" + answers.get(j)[2] + "\" }");
                        
                        
                        
                        //out.print("\"" + answers.get(j)[0] +"\": \"" + answers.get(j)[1] + "\" ");
                        //out.print("<h1> I IS " + i + " SIZE IS " + answers.size() + " </h1>");

                        if (j == (answers.size() -1)) {
                            out.print("]");
                        } else {
                            out.print(",");
                        }
                    }
               }
                
                if (i == (questions.size() -1)) {
                    out.print("}");
                } else {
                    out.print("},");
                }
            }


            out.print("] }");
       } else {
            out.print("{ \"error\": \"You are not assigned to this poll.\", \"redirect\": \"PollIndex\"}");
       }
    } else {
        out.print("{ \"error\": \"User not logged in.\", \"redirect\":\"Login\"}");
    }
}
%>