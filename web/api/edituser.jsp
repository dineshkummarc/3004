<%-- INDIVIDUAL DARREN
    Document   : geolocation
    Created on : 12/08/2011, 7:13:37 PM
    Author     : Darren
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.*"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*"%>

<%
try{
    String action = request.getParameter("action"); //"register" or "edit" or "remove"
    String returnDetails = request.getParameter("returnBoolean"); //"true" or "false"
    if (returnDetails == null) {
        returnDetails = "false";
    }
    if (action == null) {
        action = "";
    }
    if (returnDetails == "false" && action == null) {
        out.println("{");
        out.println("\"error\": " + "\"No params sent\"");
        out.println("}");
    }
    if (action.equals("remove")) {
        String userName = request.getParameter("userName");
        users user = new users();
        user.setUserName(userName);
        user.getUserByUserName();
        int check = user.deleteUser();
        if(check == -2){
            out.println("{");
            out.println("\"error\": " + "\"User ID not found\"");
            out.println("}");
        } else if (returnDetails.equals("false")){
            out.println("{");
            out.println("\"status\": " + "\"OK\"");
            out.println("}");
        }
    } else if (action.equals("edit")) {
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String location = request.getParameter("location");
        String userLevel = request.getParameter("userLevel");
        users user = new users();
        user.setUserName(userName);
        user.getUserByUserName();
        user.setPassword(password);
        user.setEmail(email);
        user.setLocation(location);
        user.setUserLevel(userLevel);
        
        int check = user.editUser();
        if(check == -2 || check == -1){
            out.println("{");
            out.println("\"error\": " + "\"User ID not found\"");
            out.println("}");
        } else if (returnDetails.equals("false")){
            out.println("{");
            out.println("\"status\": " + "\"OK\"");
            out.println("}");
        }
    } else if (action.equals("register")) {
        users user = new users();
        user.setUserID(-1);
        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String location = request.getParameter("location");
        String userLevel = request.getParameter("userLevel");
        user.setUserName(userName);
        user.setPassword(password);
        user.setEmail(email);
        user.setLocation(location);
        user.setUserLevel(userLevel);
        int check = user.addUser();
        if(check == -2 || check == -1){
            out.println("{");
            out.println("\"error\": " + "\"Unknown error occured during creation\"");
            out.println("}");
        } else if (returnDetails.equals("false")){
            out.println("{");
            out.println("\"status\": " + "\"OK\"");
            out.println("}");
        }
    } else if (returnDetails.equals("false")){
        out.println("{");
        out.println("\"error\": " + "\"Undefined type\"");
        out.println("}");
    }
    
    if (returnDetails.equals("true")) {
        String userName = request.getParameter("userName");
        users user = new users();
        user.setUserName(userName);
        user.getUserByUserName();
        out.println("{");
        out.println("\"userID\": \"" + user.getUserID() + "\",");
        out.println("\"userName\": \"" + user.getUserName() + "\",");
        out.println("\"email\": \"" + user.getEmail() + "\",");
        out.println("\"location\": \"" + user.getLocation() + "\",");
        out.println("\"userLevel\": \"" + user.getUserLevel() + "\"");
        out.println("}");
    }
} catch(Exception e){
    out.write(e.toString());
}

%>