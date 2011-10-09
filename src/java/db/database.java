/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package db;
import java.sql.*;
import java.util.ArrayList;
/**
 *
 * @author David
 */
public class database {
    private Connection conn=null;
    private int loggedIn = 0;
    public String username = new String();
    public String password = new String();
    public int userID = 0;
    
    public String creatorUsername = new String();
    public String creatorPassword = new String();
    private int creatorLoggedIn = 0;
    public int level = 0;
    public ArrayList<String> pages = new ArrayList<String>();
     /**
     * Establishes an Oracle connection.
     */
    private Connection getOracleConnection() {
        if(conn == null) {
            try {
                /* Load the Oracle JDBC Driver and register it. */
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                /* Open a new connection */
                conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "csse3004gf", "pass123");
               // conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "S4217258", "password");
            } catch(Exception ex){
                System.out.println(ex.toString());
            }
        }
        return conn;
    }
    
    /**
     * A function that allows PreparedStatements to be used for communication 
     * between the API and the Oracle back-end. It manually matches each 
     * parameter given to its parameter type, both of which have to be given by 
     * the caller.
     * @param query A PreparedStatement query string (?'s as param placeholders)
     * @param input An array of parameter variables
     * @param types An array of types for the parameters
     * @return "Success!" on query success, or "Failed!" on query failure
     */
    public String doPreparedExecute(String query, String[] input, String[] types) {
        getOracleConnection();
        try { 
            PreparedStatement statement = conn.prepareStatement(query);
            for(int i=0; i < input.length; i++) {
                System.out.println("i is: " + i);
                /** Expects a String. Need to pass in another array to this 
                 * function which tells me what type the parameter is, so I can 
                 * do chained if-else conditionals and give it the proper X in
                 * PreparedStatement.setX
                 */
                if(types[i].matches("int")) {
                    System.out.println("Setting parameter of type: int");
                    statement.setInt(i+1, Integer.parseInt(input[i]));
                }
                else if(types[i].matches("string")) {
                    System.out.println("Setting parameter of type: string");
                    statement.setString(i+1, input[i]);
                }
                
            }
            statement.execute();
            statement.close();
            return "Success!";
        }
        catch(SQLException e) {
            System.out.println(e.toString());
            return "Failed!";
        }
    }
    
        /**
     * A function that allows PreparedStatements to be used for queries 
     * between the API and the Oracle back-end. It manually matches each 
     * input parameter given to its parameter type, both of which have to be given 
     * by the caller. It also manually matches each output column returned by the query
     * to its given type, both of which have to be given by the caller.
     * @param query A PreparedStatement query string (?'s as param placeholders)
     * @param input An array of parameter variables
     * @param types An array of types for the parameters
     * @param columnNames An array of column names expected to be returned by the query
     * @param columnTypes An array of types for the columns expected to be returned by the query
     * @return The result of the query as an ArrayList of String[]; each 
     *          ArrayList record represents a new row, and each String[] record
     *          represents a column of that row. E.g. ArrayList.get(0)[0] would
     *          get the first column of the first row retrieved by the query.
     *          ArrayList.get(1)[3] would get the third column from the first row.
     */
    public ArrayList<String[]> doPreparedQuery(String query, String[] input, String[] types, String[] columnNames, String[] columnTypes) {
        getOracleConnection();
        try { 
            PreparedStatement statement = conn.prepareStatement(query);
            for(int i=0; i < input.length; i++) {
                System.out.println("i is: " + i);
                /** Expects a String. Need to pass in another array to this 
                 * function which tells me what type the parameter is, so I can 
                 * do chained if-else conditionals and give it the proper X in
                 * PreparedStatement.setX
                 */
                if(types[i].matches("int")) {
                    System.out.println("Setting parameter of type: int");
                    statement.setInt(i+1, Integer.parseInt(input[i]));
                }
                else if(types[i].matches("string")) {
                    System.out.println("Setting parameter of type: string");
                    statement.setString(i+1, input[i]);
                }
                
            }
            ResultSet rset = statement.executeQuery();
            ArrayList<String[]> data = new ArrayList<String[]>();
            while(rset.next()) {
                System.out.println("Getting next result row");
                String[] dataRow = new String[columnNames.length];
                for(int i=0; i < columnNames.length; i++) {
                    if(columnTypes[i].matches("int")) {
                        //System.err.println("ColType set as: int");
                        dataRow[i] = Integer.toString(rset.getInt(columnNames[i]));
                    }
                    else if(columnTypes[i].matches("string")) {
                        //System.err.println("ColType set as: string");
                        dataRow[i] = rset.getString(columnNames[i]);
                    }
                    else {
                        dataRow[i] = "Error occurred retrieving column " + i + " from row " + rset.getRow() + ". Check the types you passed in (must be either string or int).";
                    }
                }
                data.add(dataRow);
            }
            rset.close();
            statement.close();
            return data;
        }
        catch(SQLException e) {
            System.out.println(e.toString());
            ArrayList<String[]> error = new ArrayList<String[]>();
            String[] errorRow = {"SQL error occurred. Check debug for more info."};
            error.add(errorRow);
            return error;
        }
    }
    
    /*
     * Login function which groups all credential and access-level checks
     * into one. Returns a userlevel based on the user's highest available 
     * access.
     * 
     * Possible return values (value:meaning):
     * 0: Not logged in
     * 1: Web User
     * 2: Key User
     * 3: Poll Master
     * 4: Poll Creator
     * 5: Poll Admin
     * 6: System Admin
     */
    public int loginAll(String username, String password) {
        int userLevel = 0;
        userLevel = baseLogin(username, password);
        if(creatorLogin(username, password) == 1) {
            if(userLevel < 4) {
                userLevel = 4;
            }
        }
	int admin = adminLogin(username, password);
        if(admin == 1) {
            if(userLevel < 5) {
                userLevel = 5;
            }
        } else if (admin == -1) {
	    return -1;
	}
        this.username = username;
        this.password = password;
        this.loggedIn = 1;
        this.level = userLevel;
        this.pages = listPages();
        System.err.println("loginAll: Final userlevel: " + userLevel);
        return userLevel;
    }
    
    /*
     * Returns an ArrayList containing all pages that currently logged in user
     * should be able to see in the navbar. 
     * 
     * Intended to be used for the navigation bar (so available pages are displayed,
     * while unavailable pages are hidden), but can also be used to check if a 
     * user should be on a page at all.
     */
    public ArrayList<String> listPages() {
        pages = new ArrayList<String>();
        if(this.level == 1) {
            pages.add("web");
        } else if(this.level == 2) {
            pages.add("key");
        } else if(this.level == 3) {
            pages.add("master");
            pages.add("key");
            pages.add("web");
        } else if(this.level == 4) {
            pages.add("creator");
            pages.add("master");
            pages.add("key");
            pages.add("web");
        } else if(this.level == 5) {
            pages.add("polladmin");
            pages.add("creator");
            pages.add("master");
            pages.add("key");
            pages.add("web");
        } else if(this.level == 6) {
            pages.add("sysadmin");
        } else {
            pages.add("none");
        }
        return pages;
    }
    
    public ArrayList<String> getPages() {
        return this.pages;
    }
    
    /*
     * Checks to see whether the currently logged in user should be able to 
     * access the specified page.
     * Returns 0 for no access, 1 for access allowed.
     */
    public int accessCheck(String page) {
        if(!getPages().contains(page)) {
            return 0;
        } else {
            return 1;
        }
    }
    
    /*
     * Does a basic user access level check on a user via the USERS table.
     * Can retrieve System Admin, Key User and Web User access levels.
     * Should only ever be called by loginAll.
     * 
     * Returns the appropriate user level (6 for SysAdmin, 2 for KeyUser, 1 for
     * Web User).
     */
    private int baseLogin(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"userLevel", "userID"};
        String[] outputTypes = {"string", "int"};
        ArrayList<String[]> rankChecker = doPreparedQuery("SELECT userLevel, userID FROM Users WHERE lower(Username) = lower(?) AND Password = ?", input, inputTypes, output, outputTypes);
        if(rankChecker.isEmpty()) {
            System.err.println("baseLogin: username doesn't exist");
            return 0; // username does not exist
        } else {
            this.userID = Integer.parseInt(rankChecker.get(0)[1]);
            
            if(rankChecker.get(0)[0].equals("System Admin")) {
                return 6;
            } else if(rankChecker.get(0)[0].equals("Key User")) {
                return 2;
            } else if(rankChecker.get(0)[0].equals("Web User")) {
                return 1;
            } else if(rankChecker.get(0)[0].equals("Poll Master")) {
                return 3;
            }
        }
        System.err.println("baseLogin: No sysadmin/web user/key user access found. Looking for poll admin/creator access...");
        return 0; // no sysadmin/web user/key user access applies to this user
       
    }
    
    private int adminLogin(String username, String password) {
        String[] input = {username, password, username};
        String[] inputTypes = {"string", "string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> isAdmin = doPreparedQuery("SELECT UserID FROM Users WHERE lower(Username) = lower(?) AND Password = ? AND UserID IN (SELECT UserID FROM PollAdmins WHERE lower(Username) = lower(?))", input, inputTypes, output, outputTypes);
        String[] validTypes = {"string", "string"};
        String[] validInput = {username, password};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM Users WHERE lower(Username) = lower(?) AND Password = ?", validInput, validTypes, output, outputTypes);
        String[] dateTypes = {"string", "string"};
        String[] dateInput = {username, password};
        ArrayList<String[]> dateCheck = doPreparedQuery("SELECT UserID FROM Users WHERE lower(Username) = lower(?) AND Password = ? AND expired > SYSDATE", validInput, validTypes, output, outputTypes);
        
	if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else if(isAdmin.isEmpty()) {
            // user has no admin access
            return 3;
        } else if (dateCheck.isEmpty()) {
	    // user has expired
	    return -1;
	} else {
            // valid credentials supplied
            return 1;
        }
    }
    
    public int loginUser(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM Users WHERE lower(Username) = lower(?) AND Password = ?", input, inputTypes, output, outputTypes);
        if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else {
            // valid credentials supplied
            this.userID = Integer.parseInt(valid.get(0)[0]);
            return 1;
        }
    }
  
    public int getLoggedIn() {
        return this.loggedIn;
    }
    
    /*
     * Returns the currently logged in user's access level.
     * 0: Not logged in
     * 1: Web User
     * 2: Key User
     * 3: Poll Master
     * 4: Poll Creator
     * 5: Poll Admin
     * 6: System Admin
     */
    public int getUserLevel() {
        return this.level;
    }
    
    public int getUserID() {
        return this.userID;
    }
 
    public String getUsername() {
        return this.username;
    }
    
    public void logout() {
        this.username = new String();
        this.password = new String();
        this.level = 0;
        this.loggedIn = 0;
    }
       
    private int creatorLogin(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM Users WHERE lower(Username) = lower(?) AND Password = ? ", input, inputTypes, output, outputTypes);
        String[] isCreatorInput = {username};
        String[] isCreatorInputTypes = {"string"};
        String[] isCreatorOutput = {"UserID"};
        String[] isCreatorOutputTypes = {"int"};
        ArrayList<String[]> isCreator = doPreparedQuery("SELECT UserID FROM PollCreatorLink WHERE UserID = (SELECT UserID FROM Users WHERE lower(Username) = lower(?))", isCreatorInput, isCreatorInputTypes, isCreatorOutput, isCreatorOutputTypes);
        if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else if(isCreator.isEmpty()) {
            // user isn't a creator on any polls
            return 3;
        } else {
            // valid credentials supplied
            return 1;
        }
    }
    

    
    public int getCreatorLoggedIn() {
        return this.creatorLoggedIn;
    }
    
    
    public void creatorLogout() {
        this.creatorUsername = new String();
        this.creatorPassword = new String();
        this.creatorLoggedIn = 0;
    }


    public String doPreparedQueryAndy(String query, String[] input, String[] types, String[] columnNames, String[] columnTypes, String[] jsonNames) {
        getOracleConnection();
        try { 
            PreparedStatement statement = conn.prepareStatement(query);
            for(int i=0; i < input.length; i++) {
                System.out.println("i is: " + i);
                /** Expects a String. Need to pass in another array to this 
                 * function which tells me what type the parameter is, so I can 
                 * do chained if-else conditionals and give it the proper X in
                 * PreparedStatement.setX
                 */
                if(types[i].matches("int")) {
                    System.out.println("Setting parameter of type: int");
                    statement.setInt(i+1, Integer.parseInt(input[i]));
                }
                else if(types[i].matches("string")) {
                    System.out.println("Setting parameter of type: string");
                    statement.setString(i+1, input[i]);
                }
                
            }
            ResultSet rset = statement.executeQuery();
            String data = "[";
            while(rset.next()) {
                System.out.println("Getting next result row");
                if(data.length()>2) data += ", ";
                data += "{";
                for(int i=0; i < columnNames.length; i++) {
                    if(columnTypes[i].matches("int")) {
                        data += "\"" + jsonNames[i] + "\": " + rset.getInt(columnNames[i]);
                    }
                    else if(columnTypes[i].matches("string")) {
                        data += "\"" + jsonNames[i] + "\": " + 
                                "\"" + rset.getString(columnNames[i]) + "\"";
                    }
                    else if(columnTypes[i].matches("timestamp")) {
                        Timestamp ts = rset.getTimestamp(columnNames[i]);
                        data += "\"" + jsonNames[i] + "\": " + 
                                "\"" + ts.toString() + "\"";
                    }
                    else {
                        data = "Error occurred retrieving column " + i + " from row " + rset.getRow() + ". Check the types you passed in (must be either string or int).";
                    }   
                    if(i<columnNames.length-1)
                        data += ", ";
                }
                
                data += "}";
            }
            data += "]";
            rset.close();
            statement.close();
            return data;
        }
        catch(SQLException e) {
            System.out.println(e.toString());
            String error = "SQL error occurred. Check debug for more info.";
            return error;
        }
    }
}
