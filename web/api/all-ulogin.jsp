<%-- 
    Document   : login
    Created on : 13/08/2011, 4:14:01 PM
    Author     : Aidan Rowe
--%>

<jsp:useBean id="db" scope="session" class="db.database" /> 


<%
    String username = request.getParameter( "username" );
    String password = request.getParameter( "password" );
    
    int value = db.loginAll(username, password);
    
    if ( username == null || password == null ) {
        out.print("{ \"error\": \"Incorrect username or password.\"}");
    } else {
        if (value == 0) {
            out.print("{ \"error\": \"Incorrect username or password.\"}");
            
        } else if (value == -1)  {
	    out.print("{ \"error\": \"Account has expired.\"}");
	} else {
            out.print("{ \"status\": \"OK\", \"username\":\"" + request.getParameter( "username" ) +"\", \"role\": " + value + ", \"userID\": " + db.getUserID() + "}");
        }
    }
%>