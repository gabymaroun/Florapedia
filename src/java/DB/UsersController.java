/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author xDs
 */
public class UsersController {

    public final static UsersController INSTANCE = new UsersController();

  
    private UsersController() {
       
    }

    public boolean check(String username,String password) {
      
        try {
            PreparedStatement pr=Datasource.getConnection().prepareCall("select * from florapedia.users where username=? and password=? ");
            pr.setString(1, username);
            pr.setString(2, password);
            
            ResultSet set = pr.executeQuery();
            if (set.next()) {
                 set.close();
                return true;
            }else{
                 set.close();
                return false;}
         
        } catch (SQLException ex) {
            Logger.getLogger(UsersController.class.getName()).log(Level.SEVERE, null, ex);
        }

     return false;
    }
    public static void main(String[] args) {
        System.out.println(INSTANCE.check("admin", "admin"));
    }
}
