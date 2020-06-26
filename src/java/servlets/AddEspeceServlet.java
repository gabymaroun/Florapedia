package servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import DB.GraphController;
import DB.KeyController;
import com.mysql.cj.jdbc.Blob;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.IOUtils;
import ent.Key;
import ent.TypesNames;

/**
 *
 * @author Violet
 */
@MultipartConfig
public class AddEspeceServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            String uc = request.getParameter("uc");
            if (uc == null || !uc.equals("addingespece")) {
                response.sendRedirect("addTaxons.jsp");
                return;
            }
            String name = request.getParameter("espese_name"),
                    description = request.getParameter("description"),
                    idgenre = request.getParameter("genreid");
            Blob image;
            Part imagepart = request.getPart("image");
            out.println(name + "<br/>" + description + "<br/>" + imagepart);
            if (imagepart != null && name != null && description != null && idgenre != null 
                    && GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(idgenre)) != null) {
                image = new Blob(IOUtils.toByteArray(imagepart.getInputStream()), null);
                Key e = new Key(name, image, TypesNames.ESPECE, description);
                //KeyController.INSTANCE.create(e);
                GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(idgenre)), e);
                out.println(e.getId());
                response.sendRedirect("afficheEspece.jsp?id=" + e.getId());
            }
        } catch (Exception ex) {
            response.sendRedirect("cover.html");
            out.println(ex.getMessage());
            return;
        }

    }
}
