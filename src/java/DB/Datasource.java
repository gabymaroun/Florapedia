/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author orifi
 */
public class Datasource {

    private static Connection con = null;
    private static ResourceBundle bundle = null;

     public static Connection getConnection() {
       if (con == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
              
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/florapedia", "root", "root");
              
             
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Datasource.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(Datasource.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        return con;
    }

    public static void closeConnection() {
        if (con != null) {
            try {
                con.close();
                DriverManager.getConnection("jdbc:mysql://localhost:3306/florapedia;shutdown=true");
            } catch (SQLException ex) {
                //Logger.getLogger(Datasource.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static ResourceBundle getBundle() {
        if (bundle == null) {
            bundle = ResourceBundle.getBundle("Resources.icon");
        }
        return bundle;
    }
 /*   public static void main(String[] args) {
        System.out.println(getConnection());
        closeConnection();
    }*/
    
    
}
