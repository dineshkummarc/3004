<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="service.ReportService"%>
<%
    String type = request.getParameter("type");
    String userID = request.getParameter("userID");
    if(type.equals("pdata")){
        if(userID!=null){
            ReportService rs = new ReportService("");
            ArrayList<String> result = rs.getPollIDs(Integer.parseInt(userID));
            out.println("[");
            for(int i=0; i< result.size();i++){
                out.println(result.get(i));
            }
            out.println("]");
        }
    }
    //Questions
    if(type.equals("qdata")){
        String pollID = request.getParameter("pollID");
        if(pollID!=null || !pollID.equals("")){
            
            ReportService rs = new ReportService("");
            ArrayList<String> result = rs.getDemographicQuestions(Integer.parseInt(pollID));
            out.println("[");
            for(int i=0; i< result.size();i++){
                out.println(result.get(i).toString());
            }
            out.println("]");
        }
    }
    
    //Answers
    if(type.equals("adata")){
        String questID = request.getParameter("questID");
        if(questID!=null || !questID.equals("")){

            ReportService rs = new ReportService("");
            ArrayList<String> result = rs.getDemographicAnswers(Integer.parseInt(questID));
            out.println("[");
            for(int i=0; i< result.size();i++){
                out.println(result.get(i).toString());
            }
            out.println("]");
        }
    }
    //Individual
    if(type.equals("idata")){
        String demotype = request.getParameter("demotype");
        if(demotype=="individual"){
            String pollID = request.getParameter("pollID");
            ReportService rs = new ReportService("");
            ArrayList<String> result = rs.getUsers(Integer.parseInt(pollID));
            out.println("[");
            for(int i=0; i< result.size();i++){
                out.println(result.get(i).toString());
            }
            out.println("]");
        }
    }
    String Status="";
    //Report
    if(type.equals("system")){
        
        Status = new ReportService(type).generateReport();
        while(Status==""){
            out.println("exporting.");
        }
        response.sendRedirect("/indiv/reports/System Utilisation.pdf");
    }
    
    else if(type.equals("session")){
         Status = new ReportService(type).generateReport();
         while(Status==""){
            out.println("exporting.");
         }
         response.sendRedirect("/indiv/reports/Session History Report.pdf");
       }
    else if (type.equals("statistical")){
        String graph = request.getParameter("graph");
        String location = request.getParameter("location");
        if(location != null || !location.equals("")){
            
            ReportService rs = new ReportService("");
            
            response.sendRedirect(""); //send to google
        
        }
        int demoID = Integer.parseInt(request.getParameter("demoID"));
        int pollID = Integer.parseInt(request.getParameter("pollID"));
        String demo_value = request.getParameter("demoValue");
        if(demoID!=-1){
            Status = new ReportService(new BigDecimal(pollID), type, graph, new BigDecimal(demoID), demo_value).generateReport();
        }
        else{
        


        }
        while(Status==""){
            out.println("exporting.");
        }
        response.sendRedirect("/indiv/reports/Statistical Report.pdf");
    }
    
%>
