<%-- 
    Document   : login
    Created on : 30/07/2011, 4:24:17 PM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Test Page</title>
    </head>
    <body>
        <h1>Login Test</h1>
        <form action="dologin.jsp">
            Username: <input type="text" name="username" id="username" size="30"></input> <br />
            Password: <input type="text" name="password" id="password" size="30"></input> <br />
            <input type="submit"></input>
        </form>
    </body>
</html>
