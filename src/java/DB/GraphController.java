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
import ent.Graph;
import ent.Key;
import ent.Relation;

/**
 *
 * @author xDs
 */
public class GraphController {

    public final static GraphController INSTANCE = new GraphController();

    private String createString = "insert into florapedia.Graph  (idkeyroot) values (?)";
    private String findAllString = "select * from florapedia.Graph";
    private String findByIdString = "select * from florapedia.Graph where florapedia.Graph.idGraph= ?";
    private String findByStartingKeyIDString = "select * from florapedia.Graph where idkeyroot=?";

    private PreparedStatement createStmt;
    private PreparedStatement findAllStmt;
    private PreparedStatement findByIdStmt;
    private PreparedStatement findByStartingKeyIDStmnt;

    private GraphController() {
        try {
            findByStartingKeyIDStmnt = Datasource.getConnection().prepareStatement(findByStartingKeyIDString);
            createStmt = Datasource.getConnection().prepareStatement(createString);
            findAllStmt = Datasource.getConnection().prepareStatement(findAllString);
            findByIdStmt = Datasource.getConnection().prepareStatement(findByIdString);

        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void createByKeyRoot(Key k) {
        Graph g = new Graph(k);
        create(g);
    }

    public void create(Graph ac) {
        try {

            createStmt.setInt(1, ac.getRoot().getId());
            createStmt.executeUpdate();
            setGraphID(ac);
            PreparedStatement pr = Datasource.getConnection().prepareStatement("insert into florapedia.graph_has_key (idgraph,idkey)values(?,?)");
            pr.setInt(1, ac.getID());
            pr.setInt(2, ac.getRoot().getId());
            pr.execute();
        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);

        }
    }

    public void addNewKeyToGraph(Graph g, Key k) {
        try {
            int idgraph = g.getID();
            KeyController.INSTANCE.create(k);
            PreparedStatement pr = Datasource.getConnection().prepareStatement("insert into florapedia.graph_has_key (idgraph,idkey)values(?,?)");
            pr.setInt(1, idgraph);
            pr.setInt(2, k.getId());
            pr.execute();
        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addGraphNewKeysToDatabase(Graph g, ArrayList<Key> lsk) {
        for (Key k : lsk) {

            addNewKeyToGraph(g, k);

        }
    }

    private void setGraphID(Graph g) {
        try {
            PreparedStatement ps = Datasource.getConnection().prepareStatement("select idgraph from florapedia.graph where idkeyroot= ?");
            ps.setInt(1, g.getRoot().getId());

            ResultSet set = ps.executeQuery();
            if (set.next()) {
                g.setID(set.getInt("idgraph"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Graph> findAll() {
        ArrayList<Graph> ls = new ArrayList<>();
        try {
            ResultSet set = findAllStmt.executeQuery();
            while (set.next()) {

                Graph C;
                C = new Graph(KeyController.INSTANCE.findByKey(Integer.parseInt(set.getString(2))));
                C.setID(set.getInt("idgraph"));
                C.setLsk(KeyController.INSTANCE.findAllByGraph(C.getID()));
                for (Key Cc : C.getLsk()) {
                    for (Relation R : RelationController.INSTANCE.findAllByFromKeyId(Cc.getId())) {
                        C.getLsr().add(R);
                    }
                }
                ls.add(C);
            }
            set.close();
        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return ls;
    }

    public Graph findByKey(int id) {

        try {
            findByIdStmt.setInt(1, id);
            ResultSet set = findByIdStmt.executeQuery();

            if (set.next()) {

                Graph C;
                C = new Graph(KeyController.INSTANCE.findByKey(set.getInt("idkeyroot")));
                C.setID(id);

                C.setLsk(KeyController.INSTANCE.findAllByGraph(C.getID()));
                for (Key Cc : C.getLsk()) {
                    for (Relation R : RelationController.INSTANCE.findAllByFromKeyId(Cc.getId())) {
                        if (C.getLsk().contains(R.getTo())) {
                            C.addRelation(R);
                        }
                    }
                }
                return C;
            }

        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Graph findByStartingKeyID(int id) {

        try {
            findByStartingKeyIDStmnt.setInt(1, id);
            ResultSet set = findByStartingKeyIDStmnt.executeQuery();

            if (set.next()) {
                Key k = KeyController.INSTANCE.findByKey(id);
                Graph g = GraphController.INSTANCE.findByKey(set.getInt(1));
                if (k != null && g != null) {
                    return g;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Graph findByTransitionKeyID(int id) {

        try {
            String query = "select idgraph from graph_has_key where idkey= ? ";
            PreparedStatement st = Datasource.getConnection().prepareStatement(query);
            st.setInt(1, id);
            ResultSet set = st.executeQuery();

            if (set.next()) {
                Key k = KeyController.INSTANCE.findByKey(id);
                Graph g = GraphController.INSTANCE.findByKey(set.getInt(1));
                if (k != null && g != null) {
                    return g;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(GraphController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteGraphById(int id) {
        try {
            PreparedStatement pr = Datasource.getConnection().prepareStatement("delete from florapedia.graph where idgraph=? ");
            PreparedStatement pr1 = Datasource.getConnection().prepareStatement("delete from florapedia.graph_has_key where idgraph=? ");

            pr.setInt(1, id);
            pr1.setInt(1, id);
            pr1.executeUpdate();
            pr.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(KeyController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void main(String[] args) {
        //  System.out.println(INSTANCE.findByStartingKeyID(1));
        /*  Key k = new Key("rose" + new Random().nextInt(9999), TypesNames.GROUP);
        KeyController.INSTANCE.create(k);
        Graph g = new Graph(k);
        Key k1 = new Key("rose" + new Random().nextInt(9999), TypesNames.TRANSITION);
        KeyController.INSTANCE.create(k1);
        Key k2 = new Key("rose" + new Random().nextInt(9999), TypesNames.TRANSITION);
        KeyController.INSTANCE.create(k2);
        Relation r = new Relation(k1, k2);
        RelationController.INSTANCE.create(r);
        g.addKey(k1);
        g.addKey(k2);
        g.addRelation(r);
        INSTANCE.create(g);
        //INSTANCE.deleteGraphById(1);
        System.out.println(INSTANCE.findAll());*/
 /*  for (Key k : INSTANCE.findByStartingKeyID(8).getLsk()) {
            System.out.println(k.getId());
        }*/

    }
}
