<%@page import="DB.UsersController"%>
<%@page import="java.util.Base64"%>
<%@page import="DB.KeyController"%>
<%@page import="ent.Key"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DB.GraphController"%>
<%@page import="ent.Graph"%>
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

   <body class="text-center" onload="Init();" >

        <% boolean logedin = session.getAttribute("loginUsername") != null && session.getAttribute("loginPass") != null
                    && UsersController.INSTANCE.check((String) session.getAttribute("loginUsername"), (String) session.getAttribute("loginPass"));
            if (logedin) {
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

                    <%@include  file="WEB-INF/header.jspf" %>

                    <main role="main" class="inner cover">
                        <% String uc = "";
                            uc = request.getParameter("uc");

                        %>
                        <form action="searchByName.jsp" method="get">
                            <div class="mb-4">
                                <input type="hidden" name="uc" value="searchingbyname" />
                                <input type="text" name="searchinput" class="btn btn-secondary btn-lg" /> &nbsp;<i class="fa fa-search btn btn-secondary" onclick="document.forms[0].submit()">
                                </i> 
                            </div>
                        </form>
                        <%if (uc != null && uc.equals("searchingbyname")) {
                                String tosearch = request.getParameter("searchinput");
                                if (tosearch == null) {
                                    tosearch = "";
                                }
                                ArrayList<Key> lsk = new ArrayList<Key>();
                                if (tosearch.equals("")) {
                                    lsk = KeyController.INSTANCE.findAllEscpeces();
                                } else {
                                    for (Key k : KeyController.INSTANCE.findAllEscpeces()) {
                                        if (k.getName().toLowerCase().contains(tosearch.toLowerCase())) {
                                            lsk.add(k);
                                        }
                                    }
                                }
                                if (lsk.size() > 0) {
                        %>
                        <div class="row" ><%
                           for (Key k : lsk) {
                               %>
                            <%@include file="WEB-INF/rowespece.jspf" %><%    }


                            %></div><%                        } else {
                        %> <div class="mb-4">
                            Aucun résultat trouvé</div><%
                                    }
                                }
                            %>

                        <div class="mb-4"></div>
                        <%@include file="WEB-INF/backbtn.jspf" %>

                    </main>


                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
                <input  type="hidden" name="uc" value="init" />
            </div>
            <%if (logedin) {%>
        </div>
        <%}%>
        <script src="js/resize.js" type="text/javascript" ></script>
    </body>
</html>
