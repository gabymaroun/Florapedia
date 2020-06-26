/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import DB.GraphController;
import DB.KeyController;
import ent.Key;
import ent.TypesNames;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author xD
 */
public class AddKeyServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idgroup=0,idfamily=0,idgenre=0;
        if(request.getParameter("idgroup")!=null){
            idgroup=Integer.parseInt(request.getParameter("idgroup"));
        }
        if(request.getParameter("idfamily")!=null){
            idfamily=Integer.parseInt(request.getParameter("idfamily"));
        }
        if(request.getParameter("idgenre")!=null){
            idgenre=Integer.parseInt(request.getParameter("idgenre"));
        }
        Key k=new Key();
        if(request.getParameter("keyname")!=null&&request.getParameter("typekey")!=null){
            k.setName(request.getParameter("keyname"));
            k.setType(request.getParameter("typekey"));
        }
    
        KeyController.INSTANCE.create(k);
        if(!k.getType().equals(TypesNames.TRANSITION)){
            GraphController.INSTANCE.createByKeyRoot(k);
          
        
        if(k.getType().equals(TypesNames.GROUP)){
            GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(1), k);
        }
        if(k.getType().equals(TypesNames.FAMILY)&&idfamily==0&&idgenre==0){
             GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(idgroup), k);
        }
         if(k.getType().equals(TypesNames.GENRE)&&idgenre==0){
             GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(idfamily), k);
        }
         
        }
         
     
    } 

   

}
