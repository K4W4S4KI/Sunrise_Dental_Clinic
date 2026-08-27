package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {


    	String username = "root";
		String password = "12345";
        Class.forName("com.mysql.jdbc.Driver");

        // Creates connection Sunrise Dental database
        Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/sunrisedc_db?useSSL=false&allowPublicKeyRetrieval=true",username,password);

        return con;
    }

    public static void main(String[] args) {
        try {

            Connection conn = DBConnect.getConnection();

            // Checks the connection was successful
            if (conn != null) {
                System.out.println("Database connected successfully!");
            }

        } catch (Exception e) {

            // Prints the error details if the connection fails
            e.printStackTrace();
        }
    }
    
    
}