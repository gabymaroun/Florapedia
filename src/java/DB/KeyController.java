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
import java.util.logging.Level;
import java.util.logging.Logger;
import ent.Key;
import ent.TypesNames;
import java.util.Random;

/**
 *
 * @author xDs
 */
public class KeyController {

    public final static KeyController INSTANCE = new KeyController();

    /*
        IDKEY BIGINT(4) NOT NULL auto_increment ,
        DESCRIPTION VARCHAR(255) NULL  ,
        TYPE VARCHAR(255) NULL  ,
        NAME VARCHAR(255) NULL  ,
        IMAGE LONGBLOB NULL  
     */
    private String createEscpeceString = "insert into florapedia.key  (DESCRIPTION,TYPE,NAME,IMAGE) values (?,?,?,?)";
    private String createKeyString = "insert into florapedia.key  (TYPE,NAME) values (?,?)";

    private String findAllString = "select * from florapedia.key";
    private String findByIdString = "select * from florapedia.key where idKey = ?";
    private String findAllByGraphString = "Select A.idKey , Description, Type,name,image from florapedia.key as A inner join graph_has_key as B where A.idKey=B.idkey AND idgraph=?";

    private PreparedStatement createEscpeceStmt;
    private PreparedStatement createKeyStmt;
    private PreparedStatement findAllStmt;
    private PreparedStatement findByIdStmt;
    private PreparedStatement findAllByGraphStmt;

    private KeyController() {
        try {
            createEscpeceStmt = Datasource.getConnection().prepareStatement(createEscpeceString);
            createKeyStmt = Datasource.getConnection().prepareStatement(createKeyString);
            findAllStmt = Datasource.getConnection().prepareStatement(findAllString);
            findByIdStmt = Datasource.getConnection().prepareStatement(findByIdString);
            findAllByGraphStmt = Datasource.getConnection().prepareStatement(findAllByGraphString);

        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void create(Key k) {
        if (k.getType().equals(TypesNames.ESPECE)) {
            createEspece(k);
        } else if (k.getType().equals(TypesNames.TRANSITION)) {
            createKey(k);

        } else {
            System.out.println("taxon");
            createTaxon(k);
        }
        setIDkey(k);
    }

    private void setIDkey(Key k) {
        try {
            PreparedStatement ps = Datasource.getConnection().prepareStatement("select idkey from florapedia.key where name= ? and type= ? ");
            ps.setString(1, k.getName());
            ps.setString(2, k.getType());
            ResultSet set = ps.executeQuery();
            if (set.next()) {
                k.setId(set.getInt("idkey"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void createEspece(Key ac) {
        try {
            createEscpeceStmt.setString(1, ac.getDescription());
            createEscpeceStmt.setString(2, ac.getType());
            createEscpeceStmt.setString(3, ac.getName());
            createEscpeceStmt.setBlob(4, ac.getImage());

            ac.setId(createEscpeceStmt.executeUpdate());

        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    private void createTaxon(Key ac) {
        try {

            createKeyStmt.setString(1, ac.getType());
            createKeyStmt.setString(2, ac.getName());

            createKeyStmt.execute();
            setIDkey(ac);

        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);

        }
        GraphController.INSTANCE.createByKeyRoot(ac);
    }

    private void createKey(Key ac) {
        try {

            createKeyStmt.setString(1, ac.getType());
            createKeyStmt.setString(2, ac.getName());

            ac.setId(createKeyStmt.executeUpdate());

        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public ArrayList<Key> findAll() {
        ArrayList<Key> ls = new ArrayList<>();
        try {
            ResultSet set = findAllStmt.executeQuery();
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Key> findAllGroups() {
        ArrayList<Key> ls = new ArrayList<>();
        try {

            ResultSet set = Datasource.getConnection().createStatement().executeQuery("select * from florapedia.key where type='" + TypesNames.GROUP + "' ");
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Key> findAllFamillies() {
        ArrayList<Key> ls = new ArrayList<>();
        try {

            ResultSet set = Datasource.getConnection().createStatement().executeQuery("select * from florapedia.key where type='" + TypesNames.FAMILY + "' ");
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Key> findAllGenres() {
        ArrayList<Key> ls = new ArrayList<>();
        try {

            ResultSet set = Datasource.getConnection().createStatement().executeQuery("select * from florapedia.key where type='" + TypesNames.GENRE + "' ");
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Key> findAllEscpeces() {
        ArrayList<Key> ls = new ArrayList<>();
        try {

            ResultSet set = Datasource.getConnection().createStatement().executeQuery("select * from florapedia.key where type='" + TypesNames.ESPECE + "' ");
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));
                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public ArrayList<Key> findAllByGraph(int id) {
        ArrayList<Key> ls = new ArrayList<>();

        try {
            findAllByGraphStmt.setInt(1, id);
            ResultSet set = findAllByGraphStmt.executeQuery();
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);

            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public Key findByKey(int id) {

        try {
            findByIdStmt.setInt(1, id);
            ResultSet set = findByIdStmt.executeQuery();
            if (set.next()) {

                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                return k;
            } else {
                return null;
            }

        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteKeyById(int id) {
        try {
            PreparedStatement pr = Datasource.getConnection().prepareStatement("delete from florapedia.key where idkey=? ");
            pr.setInt(1, id);
            pr.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static ArrayList<Key> findAllTaxon() {
        ArrayList<Key> ls = new ArrayList<>();
        try {
            String findtaxonstr = "select * from florapedia.key where type not like 'transition' and type not like 'espece' ";

            PreparedStatement pr = Datasource.getConnection().prepareCall(findtaxonstr);

            ResultSet set = pr.executeQuery();
            while (set.next()) {
                Key k = new Key();
                k.setType(set.getString("type"));
                k.setId(set.getInt("idkey"));
                k.setName(set.getString("name"));

                if (k.getType().equals(TypesNames.ESPECE)) {
                    k.setImage(set.getBlob("image"));
                    k.setDescription(set.getString("description"));

                }
                ls.add(k);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public void deleteKey(Key k) {
        if (k.isEscpece()) {
            deleteEspece(k);
        }
        if(k.isTaxon()){
            
        }

    }

    private void deleteEspece(Key k) {
        try {
            PreparedStatement st = Datasource.getConnection().prepareStatement("delete from florapedia.key where idKey = ?");
            PreparedStatement st1 = Datasource.getConnection().prepareStatement("delete from relation where idto = ?");
            PreparedStatement st2 = Datasource.getConnection().prepareStatement("delete from relation where idfrom = ?");
            PreparedStatement st3 = Datasource.getConnection().prepareStatement("delete from graph_has_key where idKey = ?");
            
            st.setInt(1, k.getId());
            st1.setInt(1, k.getId());
            st2.setInt(1, k.getId());
            st3.setInt(1, k.getId());
            
            st1.execute();
            st2.execute();
            st3.execute();
            st.execute();
            
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void main(String[] args) {
        /*
        Key k=new Key("rose"+new Random().nextInt(9999), TypesNames.GROUP);
        INSTANCE.create(k);
        System.out.println(k);
        System.out.println(INSTANCE.findAll());
         */
        System.out.println(TypesNames.FAMILY);
        System.out.println(INSTANCE.findAllGroups());
        System.out.println(TypesNames.FAMILY);
        System.out.println(INSTANCE.findAllFamillies());
        // System.out.println(TypesNames.FAMILY);
        //  System.out.println(INSTANCE.findAllEscpeces());
        for (Key k : INSTANCE.findAllEscpeces()) {
            if (k.getName().toLowerCase().contains("No".toLowerCase())) {
                System.out.println(k);
            }
        }

    }
}
