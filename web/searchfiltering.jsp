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
        <!-- Custom styles for this template -->

        <link href="css/bootstrap-grid.min.css" rel="stylesheet">    

        <%ArrayList<Key> lskgroup = GraphController.INSTANCE.findByStartingKeyID(1).getTaxon();%>

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style-sb_1.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link href="css/cover.css" rel="stylesheet">
        <script>
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
        </script>
    </head>
 <% boolean logedin = session.getAttribute("loginUsername") != null && session.getAttribute("loginPass") != null
                    && UsersController.INSTANCE.check((String) session.getAttribute("loginUsername"), (String) session.getAttribute("loginPass"));
           
        %>
    <body class="text-center" onload="refreshfamily();
        <%if(logedin){%>
        Init();
        <%}%>
        " >

        <% if (logedin) {
        %>
        <div class="wrapper" id="wrapper">
            <%@include file="WEB-INF/sidebar.jspf" %>
            <%
                }%>
            <div class="content">
                <%if (logedin) {%>
              <%@include file="WEB-INF/sidebarbtn.jspf" %>
                <%}%>

                <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
                    <form method="get" id="subform"  action="search.jsp" >
                            <%@include file="WEB-INF/header.jspf" %>
                   
                     
                            <main role="main" class="inner cover">
                                <form method="get" id="subform" class="form-container" action="search.jsp">
                                    <div class="mb-4">
                                        <select class="btn btn-secondary btn-lg" name="groupid" id="groupid" onchange="refreshfamily()" required>
                                            <option value="-2" disabled hidden selected>
                                                Nom de Groupe
                                            </option>
                                            <option value="-1">
                                                Inconnu
                                            </option>
                                            <%for (Key k : lskgroup) {%>
                                            <option value="<%=k.getId()%>">
                                                <%=k.getName()%>
                                            </option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="mb-4"><select class="btn btn-secondary btn-lg" id="familyid" name="familyid"  onchange="refreshgenre()" required>

                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <select class="btn btn-secondary btn-lg" id="genreid" name="genreid" required >
                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <i class="fa fa-search btn btn-secondary" onclick="document.forms[0].submit()">
                                </i> 
                                    </div>
                                        <input  type="hidden" name="uc" value="init" />
                                </form>
                                <%@include file="WEB-INF/backbtn.jspf" %>
                            </main>
                      
                    </form>
                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
                <input  type="hidden" name="uc" value="init" />
            </div>
                <%if(logedin){%>
        </div>
<%}%>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
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
                document.getElementById('familyid').innerHTML = '<option value="-2" disabled hidden selected>Nom de famille</option><option value="-1">Inconnu</option>';
                if (document.getElementById('groupid').selectedIndex < 2) {

                    for (var item of lsgroup) {
                        for (var it of item.lsf) {
                            var op = document.createElement("option");
                            op.value = it["id"];
                            op.text = it["name"];

                            document.getElementById('familyid').options.add(op);
                        }
                    }
                } else {

                    for (var item of lsgroup[document.getElementById('groupid').selectedIndex - 2].lsf) {
                        var op = document.createElement("option");
                        op.value = item["id"];
                        op.text = item["name"];

                        document.getElementById('familyid').options.add(op);
                    }
                }
                refreshgenre();
            }
            function refreshgenre() {
                document.getElementById('genreid').innerHTML = '<option value="-2" disabled hidden selected>Nom de genre</option><option value="-1">Inconnu</option>';

                if (document.getElementById('familyid').selectedIndex < 2 & document.getElementById('groupid').selectedIndex < 2) {
                    for (var i of lsgroup) {
                        for (var j of i.lsf) {
                            for (var k of j.lsg) {

                                var op = document.createElement("option");
                                op.value = k["id"];
                                op.text = k["name"];

                                document.getElementById('genreid').options.add(op);
                            }
                        }
                    }
                }
                if (document.getElementById('familyid').selectedIndex < 2 & document.getElementById('groupid').selectedIndex > 1) {

                    for (var j of lsgroup[document.getElementById('groupid').selectedIndex - 2].lsf) {
                        for (var k of j.lsg) {

                            var op = document.createElement("option");
                            op.value = k["id"];
                            op.text = k["name"];

                            document.getElementById('genreid').options.add(op);
                        }
                    }

                }
                if (document.getElementById('familyid').selectedIndex > 1 & document.getElementById('groupid').selectedIndex < 2) {

                    for (var i of lsgroup) {
                        for (var j of i.lsf) {
                            if (j.id == document.getElementById('familyid').options[document.getElementById('familyid').selectedIndex].value)
                                for (var k of j.lsg) {

                                    var op = document.createElement("option");
                                    op.value = k["id"];
                                    op.text = k["name"];

                                    document.getElementById('genreid').options.add(op);
                                }
                        }
                    }

                }
                if (document.getElementById('familyid').selectedIndex > 1 & document.getElementById('groupid').selectedIndex > 1) {



                    for (var k of lsgroup[ document.getElementById('groupid').selectedIndex - 2].lsf[document.getElementById('familyid').selectedIndex - 2].lsg) {

                        var op = document.createElement("option");
                        op.value = k["id"];
                        op.text = k["name"];

                        document.getElementById('genreid').options.add(op);
                    }


                }


            }
        </script>
        <%if(logedin){%>
        <script src="js/resize.js" type="text/javascript"></script>
        <%}%>
    </body>
</html>
