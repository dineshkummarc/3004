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
     /**
     * Establishes an Oracle connection.
     */
    private Connection getOracleConnection() {
        if(conn == null) {
            try {
                /* Load the Oracle JDBC Driver and register it. */
                DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
                /* Open a new connection */
                conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "s4217258", "password");
                //conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "s4217258", "password");
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
                        dataRow[i] = Integer.toString(rset.getInt(columnNames[i]));
                    }
                    else if(columnTypes[i].matches("string")) {
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
    
    public int login(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM PollAdmins WHERE Username LIKE ? AND Password LIKE ?", input, inputTypes, output, outputTypes);
        if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else {
            // valid credentials supplied
            this.username = username;
            this.password = password;
            this.loggedIn = 1;
            return 1;
        }
    }
    
    public int loginUser(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM Users WHERE Username LIKE ? AND Password LIKE ?", input, inputTypes, output, outputTypes);
        if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else {
            // valid credentials supplied
            this.username = username;
            this.password = password;
            this.loggedIn = 1;
            this.userID = Integer.parseInt(valid.get(0)[0]);
            return 1;
        }
    }
  
    public int getLoggedIn() {
        return this.loggedIn;
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
        this.loggedIn = 0;
    }
       
    public int creatorLogin(String username, String password) {
        String[] input = {username, password};
        String[] inputTypes = {"string", "string"};
        String[] output = {"UserID"};
        String[] outputTypes = {"int"};
        ArrayList<String[]> valid = doPreparedQuery("SELECT UserID FROM dcf_PollCreators WHERE Username LIKE ? AND Password LIKE ?", input, inputTypes, output, outputTypes);
        if(valid.isEmpty()) {
            // invalid credentials supplied
            return 0;
        } else {
            // valid credentials supplied
            this.creatorUsername = username;
            this.creatorPassword = password;
            this.creatorLoggedIn = 1;
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
}
