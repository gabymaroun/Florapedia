/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import ent.Key;
import ent.Relation;
import ent.TypesNames;

/**
 *
 * @author xDs
 */
public class RelationController {

    public final static RelationController INSTANCE = new RelationController();

    private String createString = "insert into florapedia.relation  (idfrom,idto) values (?,?)";
    private String findAllString = "select * from florapedia.relation";
    private String findByIdString = "select * from florapedia.relation where idrelation = ?";
    private String findAllByFrom = "select * from florapedia.relation where idfrom=?";

    private PreparedStatement createStmt;
    private PreparedStatement findAllStmt;
    private PreparedStatement findByIdStmt;
    private PreparedStatement findAllByFromStmt;

    private RelationController() {
        try {
            createStmt = Datasource.getConnection().prepareStatement(createString);
            findAllStmt = Datasource.getConnection().prepareStatement(findAllString);
            findByIdStmt = Datasource.getConnection().prepareStatement(findByIdString);
            findAllByFromStmt = Datasource.getConnection().prepareStatement(findAllByFrom);

        } catch (SQLException ex) {
            Logger.getLogger(RelationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void create(Relation ac) {
        try {
            createStmt.setInt(1, ac.getFrom().getId());
            createStmt.setInt(2, ac.getTo().getId());
            createStmt.execute();
            setIdRelation(ac);
           
        } catch (SQLException ex) {
            Logger.getLogger(RelationController.class.getName()).log(Level.SEVERE, null, ex);
            
        }
    }
    private void setIdRelation(Relation r){
        try {
            PreparedStatement ps=Datasource.getConnection().prepareStatement("select idrelation from florapedia.relation where idfrom= ? and idto= ? ");
            ps.setInt(1, r.getFrom().getId());
            ps.setInt(2, r.getTo().getId());
            ResultSet set=ps.executeQuery();
            if(set.next()){
                r.setID(set.getInt("idrelation"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    public ArrayList<Relation> findAll() {
        ArrayList<Relation> ls = new ArrayList<>();
        try {
            ResultSet set = findAllStmt.executeQuery();
            while (set.next()) {
                      Relation r=new Relation(set.getInt("idrelation"), KeyController.INSTANCE.findByKey(set.getInt("idfrom")), KeyController.INSTANCE.findByKey(set.getInt("idto")));
          
                   if(!ls.contains(r)){
                       ls.add(r);
                   }
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(RelationController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Relation> findAllByFromKeyId(int id) {
        ArrayList<Relation> ls = new ArrayList<>();
        
        try {
            findAllByFromStmt.setInt(1, id);
            ResultSet set = findAllByFromStmt.executeQuery();
            while (set.next()) {
                ls.add(new Relation(set.getInt(1), KeyController.INSTANCE.findByKey(Integer.parseInt(set.getString(2))), KeyController.INSTANCE.findByKey(Integer.parseInt(set.getString(3)))));
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(RelationController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public Relation findByKey(int id) {
        try {
            findByIdStmt.setInt(1, id);
            ResultSet set = findByIdStmt.executeQuery();
            if (set.next()) {
                Relation r=new Relation(set.getInt("idrelation"), KeyController.INSTANCE.findByKey(set.getInt("idfrom")), KeyController.INSTANCE.findByKey(set.getInt("idto")));
            return r;
            } else {
                return null;
            }

        } catch (SQLException ex) {
            Logger.getLogger(RelationController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public void deleteRelationById(int id){
        try {
            PreparedStatement pr=Datasource.getConnection().prepareStatement("delete from florapedia.relation where IDRELATION=? ");
            pr.setInt(1, id);
            pr.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
   /* public static void main(String[] args) {
        Key k=new Key("rose"+new Random().nextInt(9999), TypesNames.ESPECE);
        KeyController.INSTANCE.create(k);
        Key k1=new Key("rose"+new Random().nextInt(9999), TypesNames.ESPECE);
        KeyController.INSTANCE.create(k1);
        Relation r=new Relation(k ,k1);
        INSTANCE.create(r);
        
        System.out.println(INSTANCE.findAll());
    }*/
}
