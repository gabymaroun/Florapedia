package servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import DB.Datasource;
import DB.GraphController;
import DB.KeyController;
import DB.RelationController;
import ent.Graph;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ent.Key;
import ent.Relation;
import java.sql.PreparedStatement;
import java.util.ArrayList;

/**
 *
 * @author Violet
 */
@MultipartConfig
public class ModGraphServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        String uc = request.getParameter("uc");
        if (uc.equals("addgraph")) {

            Graph g = new Graph();
            if (request.getParameter("idroot") != null && request.getParameter("typeroot") != null) {
                g = GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("idroot")));
            } else {
                return;
            }

            int drn, dkn,dGn, newkeyn, newreln;
            if (request.getParameter("drn") != null) {
                drn = Integer.parseInt(request.getParameter("drn"));
                for (int i = 0; i < drn; i++) {
                    RelationController.INSTANCE.deleteRelationById(Integer.parseInt(request.getParameter("drid" + i)));
                }
            }
            if (request.getParameter("dkn") != null) {
                drn = Integer.parseInt(request.getParameter("dkn"));
                for (int i = 0; i < drn; i++) {
                    try {
                        PreparedStatement pr = Datasource.getConnection().prepareStatement("delete from florapedia.graph_has_key where IDKEY=? ");
                        pr.setInt(1, Integer.parseInt(request.getParameter("dkid" + i)));
                        pr.executeUpdate();
                    } catch (Exception E) {

                    }
                    KeyController.INSTANCE.deleteKeyById(Integer.parseInt(request.getParameter("dkid" + i)));
                }
            }
            if (request.getParameter("dGn") != null) {
                dGn = Integer.parseInt(request.getParameter("dGn"));
                for (int i = 0; i < dGn; i++) {
                    try {
                        int id=Integer.parseInt(request.getParameter("dgid" + i));
                        PreparedStatement pr = Datasource.getConnection().prepareStatement("delete from florapedia.graph_has_key where IDKEY=? ");
                        pr.setInt(1, id);
                        pr.executeUpdate();
                        pr = Datasource.getConnection().prepareStatement("delete from florapedia.graph where IDKEYROOT=? ");
                        pr.setInt(1, id);
                        pr.executeUpdate();
                        pr = Datasource.getConnection().prepareStatement("delete from florapedia.key where IDKEY=? ");
                        pr.setInt(1, id);
                        pr.executeUpdate();
                    } catch (Exception E) {
                    }
                }
            }
            ArrayList<Key> lsktoadddatabase = new ArrayList<>();
            ArrayList<Relation> lsrtoadddatabase = new ArrayList<>();
            if (request.getParameter("newkeyn") != null) {
                for (int i = 0; i < Integer.parseInt(request.getParameter("newkeyn")); i++) {
                    if (request.getParameter("idreal" + i) != null && request.getParameter("idreal" + i).equals("")) {
                        if (request.getParameter("idfake" + i) != null && request.getParameter("name" + i) != null && request.getParameter("type" + i) != null) {

                            Key k = new Key(Integer.parseInt(request.getParameter("idfake" + i)),
                                    request.getParameter("name" + i),
                                    request.getParameter("type" + i));
                            k.setName(k.getName().replace("'", "&#39"));
                            g.addKey(k);
                            lsktoadddatabase.add(k);
                        }
                    }
                }
                if (request.getParameter("newreln") != null) {
                    for (int i = 0; i < Integer.parseInt(request.getParameter("newreln")); i++) {
                        if (request.getParameter("idfrom" + i) != null && request.getParameter("idto" + i) != null) {
                            Key from = g.getKeyInLSK(Integer.parseInt(request.getParameter("idfrom" + i))), to = g.getKeyInLSK(Integer.parseInt(request.getParameter("idto" + i)));
                            if (from != null && to != null) {
                                Relation r = new Relation(from, to);
                                g.addRelation(r);
                                lsrtoadddatabase.add(r);
                            }
                        }
                    }
                }

            }
            //GraphController.INSTANCE.create(g);

            GraphController.INSTANCE.addGraphNewKeysToDatabase(g, lsktoadddatabase);
            for (Relation r : lsrtoadddatabase) {
                RelationController.INSTANCE.create(r);
            }
            response.getWriter().write("Success");
        } else if (uc.equals("getgraph")) {
            Graph g = new Graph();
            if (request.getParameter("idroot") != null) {
                System.out.println("Nigga it's "+request.getParameter("idroot"));
                g = GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("idroot")));
                response.getWriter().write(g.getLsk().size()+"");
            } else {
                return;
            }
             
        }
        
    }
}
