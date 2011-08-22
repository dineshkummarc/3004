/* INDIVIDUAL DARREN
 * Handles all queries relating to the 'users' table
 */
package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;
/**
 *
 * @author Darren
 */
public class users {
    Connection conn;
    private int userID;
    private String userName;
    private String password;
    private String email;
    private String location;
    private String userLevel;

    public users(int userID, String userName, String password, String email,
            String location, String userLevel) {
        this.userID = userID;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.location = location;
        this.userLevel = userLevel;
    }

    public users(int userID) {
        this(userID, "", "", "", "", "");
    }

    public users(String userName, String password, String email,
            String location, String userLevel) {
        this(-1, userName, password, email, location, userLevel);
    }

    public users() {
        this(-1, "", "", "", "", "");
    }
    
    /**
     * Establishes a Oracle connection.
     */
    private Connection getOracleConnection() {
        conn=null;
        try {
            /* Load the Oracle JDBC Driver and register it. */
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            /* Open a new connection */
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "CSSE3004GF", "pass123");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@oracle.students.itee.uq.edu.au:1521:iteeo", "S4203040", "318491");
        } catch(Exception ex){
            System.out.println(ex.toString());
        }
        return conn;
    }
    
    /**
     * Runs the specified query.
     * 
     * @param query The query string to run.
     * @return ResultSet returned from running query.
     */
    private ResultSet runQuery(String query) {
        try {
            if(conn == null) {
                getOracleConnection();
            }
            Statement statement = conn.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            return resultSet;
        } catch (SQLException e) {
            System.out.println("answers.runQuery(): " + e.toString());
            return null;
        }
    }
    
    /**
     * Closes any open Oracle connection.
     */
    private void closeOracleConnection() {
        try {
            conn.close();
            conn = null;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
    }
    
    /**
     * Attempts to add this user to the database. 
     * Database will not be checked for success.
     * Will not update existing question.
     * 
     * Pre-condition: The userID must be set to an non-existing userID
     * 
     * @return  0    for attempt made.
     *          -1   for invalid user properties.
     *          -2   for undefined error.
     */
    public int addUser() {
        int pk = -1;
        int test = -1;
        try {
            if (getUserID() != -1) {
                return -1;
            } else if (getUserName().equals("")) {
                return -1;
            } else if (getPassword().equals("")) {
                return -1;
            } else if (getEmail().equals("")) {
                return -1;
            } else if (getLocation().equals("")) {
                return -1;
            } else if ((!getUserLevel().equals("Web User")) &&
                    (!getUserLevel().equals("Key User")) &&
                    (!getUserLevel().equals("Poll Master")) &&
                    (!getUserLevel().equals("Poll Creator")) &&
                    (!getUserLevel().equals("Poll Admin")) &&
                    (!getUserLevel().equals("System Admin"))) {
                return -1;
            } 
            
            System.out.println(getUserID());
            System.out.println(getUserName());
            System.out.println(getPassword());
            System.out.println(getEmail());
            System.out.println(getLocation());
            System.out.println(getUserLevel());
            
            getOracleConnection();
            
            //FHere
            PreparedStatement statement = conn.prepareStatement("INSERT INTO Users(UserID, userName, password, email, location, userLevel, created, expired) VALUES (useq.nextval, ?, ?, ?, ?, ?, TO_DATE('2011-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2013-02-18 06:42:21', 'YYYY-MM-DD HH24:MI:SS'))");
            System.out.println("\n addUser() got called;");
            statement.setString(1, getUserName());
            statement.setString(2, getPassword());
            statement.setString(3, getEmail());
            statement.setString(4, getLocation());
            statement.setString(5, getUserLevel());
            
            statement.executeUpdate();
            
            statement = conn.prepareStatement("SELECT useq.currval FROM dual");
            ResultSet rset = statement.executeQuery();
            if(rset.next()) {
                pk = rset.getInt(1);
                //rset.getInt("questID");
            }
            System.out.println("pk: " + pk);
            statement.close();
            closeOracleConnection();
            return pk;
        } catch (SQLException e) {
            System.out.println("addUser(): " + e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to edit this user in the database. 
     * Database will not be checked for success.
     * Will not add a new question.
     * 
     * Pre-condition: The userID must be set to an existing user
     * 
     * @return  0    for attempt made.
     *          -1   for invalid user properties.
     *          -2   for undefined error.
     */
    public int editUser() {
        try {
            if ((getUserID() == -1) && (getUserName().equals(""))) {
                return -1;
            } else if (getPassword().equals("")) {
                return -1;
            } else if (getEmail().equals("")) {
                return -1;
            } else if (getLocation().equals("")) {
                return -1;
            } else if ((!getUserLevel().equals("Web User")) &&
                    (!getUserLevel().equals("Key User")) &&
                    (!getUserLevel().equals("Poll Master")) &&
                    (!getUserLevel().equals("Poll Creator")) &&
                    (!getUserLevel().equals("Poll Admin")) &&
                    (!getUserLevel().equals("System Admin"))) {
                return -1;
            }
            
            getOracleConnection();
            PreparedStatement statement;
            if (getUserID() == -1) {
            statement = conn.prepareStatement("UPDATE Users SET userName=?, password=?,"
                    + "email=?, location=?, userLevel=? WHERE userName=?");
                statement.setString(1, getUserName());
                statement.setString(2, getPassword());
                statement.setString(3, getEmail());
                statement.setString(4, getLocation());
                statement.setString(5, getUserLevel());
                statement.setString(6, getUserName());
            } else {
            statement = conn.prepareStatement("UPDATE Users SET userName=?, password=?,"
                    + "email=?, location=?, userLevel=? WHERE userID=?"); 
                statement.setString(1, getUserName());
                statement.setString(2, getPassword());
                statement.setString(3, getEmail());
                statement.setString(4, getLocation());
                statement.setString(5, getUserLevel());
                statement.setInt(6, getUserID());
            }
            
            
            statement.executeUpdate();
            statement.close();

            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * Attempts to delete this user from the database. 
     * Database will not be checked for success.
     * 
     * Pre-condition: The userID must be set to an existing user
     * 
     * @return  0    for attempt made
     *          -1   for unset user ID.
     *          -2   for undefined error.
     */
    public int deleteUser() {
        try {
            if (getUserID() == -1) {
                return -1;
            } 
            /* Delete User */
            String query= "DELETE FROM Users WHERE userID=" + getUserID();
            runQuery(query);
            closeOracleConnection();
            
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    /**
     * Attempts to find user by userID. 
     * Updates properties of this instance of user to result found.
     * 
     * Pre-condition: The userID must be set to an existing user
     * 
     * @return  0    for attempt made
     *          -1   for unset or invalid user ID.
     *          -2   for undefined error.
     */
    public int getUser() {
        try {
            if (getUserID() == -1) {
                return -1;
            } 
            
            String query= "SELECT * FROM Users WHERE userID=" + getUserID();
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setUserID(resultSet.getInt("userID"));
                setUserName(resultSet.getString("userName"));
                setPassword(resultSet.getString("password"));
                setEmail(resultSet.getString("email"));
                setLocation(resultSet.getString("location"));
                setUserLevel(resultSet.getString("userLevel"));
            }
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }
    
    public int getUserByUserName() {
        try {
            if (getUserName().equals("")) {
                return -1;
            } 
            
            String query= "SELECT * FROM Users WHERE userName='" + getUserName() + "'";
            ResultSet resultSet = runQuery(query);
            while (resultSet.next()) {
                setUserID(resultSet.getInt("userID"));
                setUserName(resultSet.getString("userName"));
                setPassword(resultSet.getString("password"));
                setEmail(resultSet.getString("email"));
                setLocation(resultSet.getString("location"));
                setUserLevel(resultSet.getString("userLevel"));
            }
            closeOracleConnection();
            return 0;
        } catch (Exception e) {
            System.out.println(e.toString());
            return -2;
        }
    }

    /**
     * @return the userID
     */
    public int getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     * @return the userName
     */
    public String getUserName() {
        return userName;
    }

    /**
     * @param userName the userName to set
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * @return the userLevel
     */
    public String getUserLevel() {
        return userLevel;
    }

    /**
     * @param userLevel the userLevel to set
     */
    public void setUserLevel(String userLevel) {
        this.userLevel = userLevel;
    }
}