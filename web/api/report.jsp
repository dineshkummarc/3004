<%@page import="service.ReportService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>

<%
    String type = request.getParameter("type");
    
    String Status="";
    //Report
    if(type.equals("system")){
        
        Status = new ReportService(type).generateReport();
        //while(Status==""){
          //  out.println("exporting.");
        //}
        response.sendRedirect("/Andy/reports/System Utilisation.pdf");
    }
    
    else if(type.equals("session")){
         Status = new ReportService(type).generateReport();
         //while(Status==""){
          //  out.println("exporting.");
         //}
         response.sendRedirect("/Andy/reports/Session History Report.pdf");
       }
    
    else if(type.equals("individual")){
            
        String userID = request.getParameter("user");
        int user = Integer.parseInt(userID);
        if(user==-1){
            out.println("[{\"error\": "+ "\"Please Select a user name.\"}]");  
        }
        else{
        int pollID = Integer.parseInt(request.getParameter("pollID"));

        Status = new ReportService(new BigDecimal(pollID), 
                "individual", "Bar", new BigDecimal(user)).generateReport();
        response.sendRedirect("/Andy/reports/Statistical Report.pdf");
        //out.println("individual");
        }

    }
    
    else if(type.equals("location")){
        String gtype = "Bar";
        String comparison = "Y";
        ArrayList<String> al = new ArrayList<String>();
        int pollID = Integer.parseInt(request.getParameter("pollID"));
        String country = request.getParameter("country");
        if(!country.equals("-1")){
            al.add(country);
        }
        String state = request.getParameter("state");
        if(!state.equals("-1")){
            al.add(state);
        }
        String city = request.getParameter("city");
        if(!city.equals("-1")){
            al.add(city);
        }
        String suburb = request.getParameter("suburb");
        if(!suburb.equals("-1")){
            al.add(suburb);
        }
        String street = request.getParameter("street");
        if(!street.equals("-1")){
            al.add(street);
        }             
        String c = request.getParameter("comparison");
        if(c.equals("F")){
            comparison = "N";
            gtype = request.getParameter("graph");
        }
        Status = new ReportService(new BigDecimal(pollID), 
                "location", gtype, comparison, al).generateReport();
        response.sendRedirect("/Andy/reports/Statistical Report.pdf");
        
            
    }
    
    else if (type.equals("statistical")){
        String graph = request.getParameter("graph");        
        String demoID = request.getParameter("demoID");
        String demo_value = request.getParameter("demoValue");
        int pollID = Integer.parseInt(request.getParameter("pollID"));
        
        // no demo, all result
        if(demoID.equals("-1")){
            Status = new ReportService(new BigDecimal(pollID), "statistical_all", graph).generateReport();
            response.sendRedirect("/Andy/reports/Statistical Report.pdf");
        }
        
        //demo
        if(Integer.parseInt(demoID)>-1){
            int demo = Integer.parseInt(demoID);
            //with value 
            if(!demo_value.equals("-1")){
                Status = new ReportService(new BigDecimal(pollID), type, graph,
                        new BigDecimal(demo), demo_value).generateReport();
                response.sendRedirect("/Andy/reports/Statistical Report.pdf");
            }
            //without value
            else{
               
                Status = new ReportService(new BigDecimal(pollID), "statistical_demo", graph,
                       new BigDecimal(demo), "").generateReport();      
                response.sendRedirect("/Andy/reports/Statistical Report.pdf");       
            }
        }
        
        //while(Status==""){
          //  out.println("exporting.");
        //}
      
    }
    
%>
