<%@page import="DB.UsersController"%>
<%@page import="com.mysql.cj.ParseInfo"%>
<%@page import="DB.GraphController"%>
<%@page import="ent.Graph"%>
<%@page import="ent.TypesNames"%>
<%@page import="ent.Key"%>
<%@page import="DB.KeyController"%>
<%@page import="java.util.ArrayList"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="image/icon.ico">

        <title>Florapédia</title>

        <!-- Bootstrap core CSS -->

        <link href="css/bootstrap_1.css" rel="stylesheet">

        <link href="css/bootstrap-grid.min.css" rel="stylesheet">    
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style-sb_1.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <!--   <script>
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
        </script>-->
        <link href="css/cover.css" rel="stylesheet">
        <% boolean logedin = session.getAttribute("loginUsername") != null && session.getAttribute("loginPass") != null
                    && UsersController.INSTANCE.check((String) session.getAttribute("loginUsername"), (String) session.getAttribute("loginPass"));
            if (!logedin) {
        %><script>
            backtopage():

        </script><%
            }%>
    </head>

    <body class="text-center" onload="Init();refreshfamily();">
        <div class="wrapper" id="wrapper">
            <%@include file="./WEB-INF/sidebar.jspf"%>

            <div class="content">

                <%@include file="WEB-INF/sidebarbtn.jspf" %>

                <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">

                    <%@include file="WEB-INF/header.jspf" %>

                    <main role="main" class="inner cover">

                        <% String uc = "";
                            if (request.getParameter("uc") == null) {
                                uc = "mainadd";
                            } else {
                                uc = request.getParameter("uc");
                            }
                            if (uc.equals("mainadd")) {
                        %>
                        <div class="mb-4">
                            <a href="addTaxons.jsp?uc=addgroup" 
                               class="btn btn-lg btn-secondary">Ajouter Group</a>
                        </div>
                        <div class="mb-4">
                            <a href="addTaxons.jsp?uc=addfamily" 
                               class="btn btn-lg btn-secondary">Ajouter Famille</a>
                        </div>
                        <div class="mb-4">
                            <a href="addTaxons.jsp?uc=addgenre" 
                               class="btn btn-lg btn-secondary">Ajouter Genre</a>
                        </div>
                        <div class="mb-4">
                            <a href="addTaxons.jsp?uc=addespece" 
                               class="btn btn-lg btn-secondary">Ajouter Espèce</a>
                        </div>
                        <%} else if (uc.equals("addgroup")) {
                        %>
                        <form action="addTaxons.jsp" method="get">
                            <div class="mb-4">

                                <input name="groupname" type="text" class="btn btn-lg btn-secondary " placeholder="Nom de Groupe" />
                            </div>
                            <div class="mb-4">
                                <input type="submit" value="Ajouter" class="btn btn-lg btn-secondary " />
                                <input type="hidden" value="addinggroup" name="uc"/>

                            </div>
                        </form>
                        <%
                        } else if (uc.equals("addfamily")) {
                        %>
                        <%
                            ArrayList<Key> lskg = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();%>
                        <form action="addTaxons.jsp" method="post">
                            <div class="mb-4">
                                <select name="groupid"  class="btn  btn-lg mt-4" >
                                    <option disabled selected hidden>Nom de Groupe</option>
                                    <%for (Key k : lskg) {%>
                                    <option value="<%=k.getId()%>"><%=k.getName()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="mb-4">
                                <input name="familyname" type="text" class="btn btn-lg mt-4" placeholder="Nom de famille"/>
                            </div>
                            <div class="mb-4">
                                <input type="submit" value="Ajouter" class="btn btn-lg btn-secondary " />
                                <input type="hidden" value="addingfamily" name="uc"/>
                            </div>
                        </form>
                        <%
                        } else if (uc.equals("addgenre")) {
                            ArrayList<Key> lskgroup = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();
                        %>

                        <form action="addTaxons.jsp" method="post" >
                            <div class="mb-4">
                                <select name="groupid" id="groupid" class="btn  btn-lg mt-4" onchange="refreshfamily()"  >
                                    <option disabled selected hidden>Nom de Groupe</option>
                                    <%   for (Key k : lskgroup) {%><option value="<%=k.getId()%>"><%=k.getName()%></option>
                                    <%}%>
                                </select>
                            </div>

                            <div class="mb-4">
                                <select name="familyid"  class="btn  btn-lg mt-4" id="familyid" >
                                </select>
                            </div>
                            <div class="mb-4">
                                <input name="genrename" type="text" class="btn btn-lg mt-4" placeholder="Nom de Genre"/>
                            </div>
                            <div class="mb-4">
                                <input type="submit" value="Ajouter" class="btn btn-lg btn-secondary " />
                                <input type="hidden" value="addinggenre" name="uc"/>
                            </div>
                        </form>
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
                                document.getElementById('familyid').innerHTML = '<option disabled selected hidden>Nom de famille</option>';

                                for (var item of lsgroup[document.getElementById('groupid').selectedIndex - 1].lsf) {
                                    var op = document.createElement("option");
                                    op.value = item["id"];
                                    op.text = item["name"];

                                    document.getElementById('familyid').options.add(op);
                                }
                            }
                        </script>

                        <%
                        } else if (uc.equals("addespece")) {

                            ArrayList<Key> lskgroup = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();
                        %>

                        <form action="AddEspeceServlet" method="post" enctype="multipart/form-data">
                            <div class="mb-4">
                                <select name="groupid" id="groupid" class="btn  btn-lg mt-4" onchange="refreshfamily()"  >
                                    <option disabled selected hidden>Nom de Groupe</option>
                                    <%   for (Key k : lskgroup) {%><option value="<%=k.getId()%>"><%=k.getName()%></option>
                                    <%}%>
                                </select>
                            </div>

                            <div class="mb-4">
                                <select name="familyid"  class="btn  btn-lg mt-4" id="familyid" onchange="refreshgenre()">

                                </select>
                            </div>
                            <div class="mb-4">
                                <select name="genreid"  class="btn  btn-lg mt-4" id="genreid" >
                                </select></div>

                            <div class="mb-4">
                                <input class="btn  btn-lg mt-4" type="text" name="espese_name" placeholder="Nom de l'espèce" />
                            </div>
                            <div class="mb-4">
                                <input class="btn  btn-lg mt-4" type="file" name="image" placeholder="Image de l'espèce"/>
                            </div>
                            <div class="mb-4">
                                <textarea class="btn  btn-lg mt-4" name="description" placeholder="Description"></textarea>
                            </div>
                            <div class="mb-4">
                                <input type="submit" value="Ajouter" class="btn btn-lg btn-secondary " />
                                <input type="hidden" value="addingespece" name="uc"/>
                            </div>

                        </form>
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
                                document.getElementById('familyid').innerHTML = '<option disabled selected hidden>Nom de famille</option>';
                                refreshgenre();
                                if (document.getElementById('groupid').selectedIndex > 0) {
                                    for (var item of lsgroup[document.getElementById('groupid').selectedIndex - 1].lsf) {
                                        var op = document.createElement("option");
                                        op.value = item["id"];
                                        op.text = item["name"];

                                        document.getElementById('familyid').options.add(op);
                                    }

                                }
                                refreshgenre();
                            }
                            function refreshgenre() {

                                document.getElementById('genreid').innerHTML = '<option disabled selected hidden>Nom de genre</option>';
                                if (document.getElementById('familyid').selectedIndex > 0) {
                                    for (var item of lsgroup[document.getElementById('groupid').selectedIndex - 1].lsf[document.getElementById('familyid').selectedIndex - 1].lsg) {
                                        var op = document.createElement("option");
                                        op.value = item["id"];
                                        op.text = item["name"];

                                        document.getElementById('genreid').options.add(op);
                                    }
                                }

                            }
                        </script>

                        <%
                            } else if (uc.equals("addinggroup")) {

                                if (request.getParameter("groupname") != null && !request.getParameter("groupname").equals("")) {
                                    Key k = new Key(request.getParameter("groupname"), TypesNames.GROUP);
                                    System.out.println(GraphController.INSTANCE.findByKey(1));
                                    GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByKey(1), k);
                                    response.sendRedirect("addTaxons.jsp");
                                }
                            } else if (uc.equals("addingfamily")) {

                                if (request.getParameter("groupid") != null && !request.getParameter("groupid").equals("") && request.getParameter("familyname") != null && !request.getParameter("familyname").equals("")) {
                                    Key k = new Key(request.getParameter("familyname"), TypesNames.FAMILY);

                                    GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("groupid"))), k);
                                    response.sendRedirect("addTaxons.jsp");

                                }
                            } else if (uc.equals("addinggenre")) {
                                if (request.getParameter("familyid") != null && !request.getParameter("familyid").equals("") && request.getParameter("genrename") != null && !request.getParameter("genrename").equals("")) {
                                    Key k = new Key(request.getParameter("genrename"), TypesNames.GENRE);

                                    GraphController.INSTANCE.addNewKeyToGraph(GraphController.INSTANCE.findByStartingKeyID(Integer.parseInt(request.getParameter("familyid"))), k);
                                    response.sendRedirect("addTaxons.jsp");

                                }
                            } else if (uc.equals("addingespece")) {
                                //  response.sendRedirect("/jsp/AddEspeceServlet");
                            }
                        %>
                        <%@include file="WEB-INF/backbtn.jspf" %>
                    </main>

                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
                <input  type="hidden" name="uc" value="filter" />
            </div>
        </div>
        <script src="js/resize.js" type="text/javascript"></script>
    </body>
</html>
