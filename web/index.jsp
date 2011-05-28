<%@page import="java.sql.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import = "java.text.*"%>
<%@page import="java.io.*"%>
<%@page import="database.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Vector;"%>
<html>
<head>
<script src="assets/jquery.js"></script>
<script src="assets/scripts.js"></script>
<link href="assets/style.css" type="text/css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Maven+Pro' rel='stylesheet' type='text/css'>
<title>dbPOLL - Prototype</title>
</head>
<body>
<div id="container">
<div id="header">
<img src="assets/images/logo.png" />
</div>

<h1>Polls</h1>

<%
polls Polls = new polls(); 
Vector<polls> results = new Vector<polls>();
results = Polls.getAllPollIDs();
if(results != null){
    for(int i=0;i<results.size();i++){
        out.println("<a href=edit.html#"+results.get(i).getPollID() + ">" + results.get(i).getPollName()+"</a><br/>");
    }
}
else{
    out.print("<p>1231232132131321321</p>");
}   
%>
</div>

<div id="footer"> 
&copy; 2010. dbPOLL Turning Point.
</div>
</body>
</html>