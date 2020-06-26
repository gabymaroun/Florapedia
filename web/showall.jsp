<%@page import="DB.UsersController"%>
<%@page import="java.util.Comparator"%>
<%@page import="DB.KeyController"%>
<%@page import="ent.Key"%>
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

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="css/style-sb_1.css"> 
        <script>
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
        </script>

        <link href="css/cover.css" rel="stylesheet">
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
                <%if (logedin) {%><%@include file="WEB-INF/sidebarbtn.jspf" %>
                <%}%>
                <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
                    <%@include file="./WEB-INF/header.jspf"%>
                    <main role="main" class="inner cover">
                        <%ArrayList<Key> lsk = new ArrayList<Key>();
                            String uc = request.getParameter("uc");

                            if (uc == null) {%>
                        <div class=" mb-4">
                            <a href="showall.jsp?uc=groups" class="btn btn-lg btn-secondary ">Groupes</a>
                        </div>
                        <div class="mb-4">

                            <a href="showall.jsp?uc=famillies" class="btn btn-lg btn-secondary ">Familles</a>
                        </div>
                        <div class=" mb-4">
                            <a href="showall.jsp?uc=genres" class="btn btn-lg btn-secondary">Genres</a>
                        </div>
                        <div class=" mb-4">
                            <a href="showall.jsp?uc=especes" class="btn btn-lg btn-secondary">Espèces</a>
                        </div>
                        <%} else if (uc.equals("groups")) {
                                lsk = KeyController.INSTANCE.findAllGroups();
                            } else if (uc.equals("genres")) {
                                lsk = KeyController.INSTANCE.findAllGenres();
                            } else if (uc.equals("famillies")) {
                                lsk = KeyController.INSTANCE.findAllFamillies();
                            } else if (uc.equals("especes")) {
                                lsk = KeyController.INSTANCE.findAllEscpeces();
                            }
                            lsk.sort(new Comparator<Key>() {
                                @Override
                                public int compare(Key o1, Key o2) {
                                    return o1.getName().compareTo(o2.getName());
                                }
                            });
                            if (lsk != null && lsk.size() > 0) {
                                for (Key k : lsk) {
                                    if (logedin) {

                                        if (k.isTaxon()) {
                        %>
                        <div class="mb-4">
                            <a class="btn btn-lg btn-secondary"  href="ManageGraphs.jsp?Rootid=<%=k.getId()%>" ><%=k.getName()%></a> 
                        </div> <%}
                            if (k.isEscpece()) {
                        %>
                        <div class="mb-4">
                            <a class="btn btn-lg btn-secondary" href="afficheEspece.jsp?id=<%=k.getId()%>" ><%=k.getName()%></a> 
                        </div><%}
                        } else {
                            if (k.isEscpece()) {
                        %>
                        <div class="mb-4">
                            <a class="btn btn-lg btn-secondary" href="afficheEspece.jsp?id=<%=k.getId()%>" ><%=k.getName()%></a> 
                        </div><%} else {
                        %>
                        <div class="mb-4">
                            <div class="btn btn-lg btn-secondary"> <%=k.getName()%></div>
                        </div>

                        <%
                                    }
                                }
                            }}

                        %>

                        <%@include file="WEB-INF/backbtn.jspf" %>
                    </main>
                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
            </div>

            <script>
                function resizeWrapper() {

                    document.getElementById("wrapper").style.height = window.innerHeight;
                    document.body.style.height = window.innerHeight;

                }
            </script>
            <%if (logedin) {%>      
        </div><%}%>
         <script src="js/resize.js" type="text/javascript"></script>
    </body>
</html>
