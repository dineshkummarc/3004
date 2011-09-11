<%@page import="java.util.ArrayList" %>
<jsp:useBean id="db" scope="session" class="db.database" /> 

<%

    ArrayList<String> authorisedPages = db.getPages();
    out.print("{\"pages\": [");
    for(int i=0; i<authorisedPages.size(); i++) {
        if(i == authorisedPages.size()-1) {
            out.print("\"" + authorisedPages.get(i) + "\"");
        } else {
            out.print("\"" + authorisedPages.get(i) + "\", ");
        }
    }
    out.print("]}");
%>