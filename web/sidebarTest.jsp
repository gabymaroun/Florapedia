<%-- 
    Document   : sidebarTest
    Created on : Jan 13, 2019, 12:00:39 AM
    Author     : Gaby's
--%>

<%@page import="com.mysql.cj.ParseInfo"%>
<%@page import="DB.GraphController"%>
<%@page import="ent.Graph"%>
<%@page import="ent.TypesNames"%>
<%@page import="ent.Key"%>
<%@page import="DB.KeyController"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        
        <!--    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
           <link rel="icon" href="../../../../favicon.ico">
   
     
   
           <link href="css/bootstrap-grid.min.css" rel="stylesheet"> 
           <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
           <link rel="stylesheet" href="css/style-sb_1.css">
           <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
           <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
           <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
           <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
           
           <script>
               $(document).ready(function () {
                   $('#sidebarCollapse').on('click', function () {
                       $('#sidebar').toggleClass('active');
                   });
               });
           </script> -->
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/sidenav.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css"  type="text/css"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
        <link href="css/cover.css" rel="stylesheet">
        <title>Florapédia</title>
    </head>
    <body class="text-center" onload="refreshfamily()">

        <!--    <div class="wrapper">
               
    
                <div class="content">
                    <button type="button" id="sidebarCollapse" class="btn btn-info">
                        <i class="fa fa-align-justify"></i> 
                    </button>
                    <nav class="navbar navbar-expand-lg navbar-light bg-light"> 
    
    
                        <button class="navbar-toggler" type="button" data-toggle="collapse" 
                                data-target="#navbarNav" aria-controls="navbarNav" 
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
    
                    </nav>-->
        <div class="container-fluid">
            <div class="row d-flex d-md-block flex-nowrap wrapper">


                <%@include file="./WEB-INF/newsidebar.jspf"%>

                <main role="main" class="col-md-9 col px-5 pl-md-2 pt-2 main mx-auto">
                    <a href="#" data-target="#sidebar" data-toggle="collapse" aria-expanded="false"><i class="fa fa-navicon fa-2x py-2 p-1"></i></a>

                    <% String uc = "";  
                        Graph g = (Graph) session.getAttribute("graph");
                        ArrayList<Key> lsk = null;
                        if (request.getParameter("uc") == null) {
                            uc = "mainadd";
                        } else {
                            uc = request.getParameter("uc");
                        }
                        if (uc.equals("mainadd")) {%>
                    <div class="inner">
                        <h1 class="masthead-brand">Welcome to Flora</h1>
                    </div>
                    <%} else if (uc.equals("addgroup")) {
                    %>
                    <%@include file="./WEB-INF/header.jspf"%>
                    <%@include file="./WEB-INF/groupe.jspf"%>

                    <%
                    } else if (uc.equals(
                            "addfamily")) {
                    %>
                    <% if (GraphController.INSTANCE.findByStartingKeyID(1) != null && GraphController.INSTANCE.findByStartingKeyID(1).getTaxon().size() > 1) {
                            ArrayList<Key> lskg = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();%>
                    <%@include file="./WEB-INF/header.jspf"%>
                    <%@include file="./WEB-INF/famille.jspf"%>
                    <%}
                    } else if (uc.equals(
                            "addgenre")) {
                        ArrayList<Key> lskgroup = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();
                    %>
                    <%@include file="./WEB-INF/header.jspf"%>
                    <%@include file="./WEB-INF/genre.jspf"%>
                    <script type="text/javascript">
                        var lsgroup = [];
                        <%for (Key kg : lskgroup) {%>
                        var group = {id:<%=kg.getId()%>, name: '<%=kg.getName()%>', lsf: []};
                        <%for (Key kf : GraphController.INSTANCE.findByStartingKeyID(kg.getId()).getTaxon()) {%>
                        var family = {id:<%=kf.getId()%>, name: '<%=kf.getName()%>', lsg: []};
                        <%for (Key kge : GraphController.INSTANCE.findByStartingKeyID(kf.getId()).getTaxon()) {%>
                        var genre = {id:<%=kge.getId()%>, name: '<%=kge.getName()%>'};
                        family["lsg"].push(genre);
                        <%}%>
                        group["lsf"].push(family);
                        <%}%>
                        lsgroup.push(group);
                        <%
                            }
                        %>
                        function refreshfamily() {
                            document.getElementById('familyid').innerHTML = '';

                            for (var item of lsgroup[document.getElementById('groupid').selectedIndex].lsf) {
                                var op = document.createElement("option");
                                op.value = item["id"];
                                op.text = item["name"];

                                document.getElementById('familyid').options.add(op);
                            }
                        }
                    </script>

                    <%
                    } else if (uc.equals(
                            "addespece")) {

                        ArrayList<Key> lskgroup = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();
                    %>
                    <%@include file="./WEB-INF/header.jspf"%>
                    <%@include file="./WEB-INF/espece.jspf"%>

                    <script type="text/javascript">
                        var lsgroup = [];
                        <%for (Key kg : lskgroup) {%>
                        var group = {id:<%=kg.getId()%>, name: '<%=kg.getName()%>', lsf: []};
                        <%for (Key kf : GraphController.INSTANCE.findByStartingKeyID(kg.getId()).getTaxon()) {%>
                        var family = {id:<%=kf.getId()%>, name: '<%=kf.getName()%>', lsg: []};
                        <%for (Key kge : GraphController.INSTANCE.findByStartingKeyID(kf.getId()).getTaxon()) {%>
                        var genre = {id:<%=kge.getId()%>, name: '<%=kge.getName()%>'};
                        family["lsg"].push(genre);
                        <%}%>
                        group["lsf"].push(family);
                        <%}%>
                        lsgroup.push(group);
                        <%
                            }
                        %>
                        function refreshfamily() {
                            document.getElementById('familyid').innerHTML = '';
                            if (document.getElementById('groupid').selectedIndex > -1) {
                                for (var item of lsgroup[document.getElementById('groupid').selectedIndex].lsf) {
                                    var op = document.createElement("option");
                                    op.value = item["id"];
                                    op.text = item["name"];

                                    document.getElementById('familyid').options.add(op);
                                }
                                refreshgenre();
                            }
                        }
                        function refreshgenre() {
                            document.getElementById('genreid').innerHTML = '';
                            if (document.getElementById('familyid').selectedIndex > -1) {
                                for (var item of lsgroup[document.getElementById('groupid').selectedIndex].lsf[document.getElementById('familyid').selectedIndex].lsg) {
                                    var op = document.createElement("option");
                                    op.value = item["id"];
                                    op.text = item["name"];

                                    document.getElementById('genreid').options.add(op);
                                }
                            }
                        }
                    </script>
                    <p id="msg"></p>
                    <%
                        } else if (uc.equals(
                                "addinggroup")) {

                            if (request.getParameter("groupname") != null && !request.getParameter("groupname").equals("")) {
                                Key k = new Key(request.getParameter("groupname"), TypesNames.GROUP);

                                GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByKey(1), k);
                                response.sendRedirect("sidebar.jsp");
                            }
                        } else if (uc.equals(
                                "addingfamily")) {

                            if (request.getParameter("groupid") != null && !request.getParameter("groupid").equals("") && request.getParameter("familyname") != null && !request.getParameter("familyname").equals("")) {
                                Key k = new Key(request.getParameter("familyname"), TypesNames.FAMILY);

                                GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("groupid"))), k);
                                response.sendRedirect("sidebar.jsp");

                            }
                        } else if (uc.equals(
                                "addinggenre")) {
                            if (request.getParameter("familyid") != null && !request.getParameter("familyid").equals("") && request.getParameter("genrename") != null && !request.getParameter("genrename").equals("")) {
                                Key k = new Key(request.getParameter("genrename"), TypesNames.GENRE);

                                GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("familyid"))), k);
                                response.sendRedirect("sidebar.jsp");

                            }
                        } else if (uc.equals("addingespece")) {
                            //  response.sendRedirect("/jsp/AddEspeceServlet");
                        }%>
                </main>


                <input  type="hidden" name="uc" value="filter" />
                <!--   </div>
               </div>-->
            </div>

        </div>
        <%@include file="./WEB-INF/footer.jspf"%>
    </body>
</html>