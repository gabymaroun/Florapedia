<%-- 
    Document   : sidebar
    Created on : Dec 8, 2018, 9:50:33 PM
    Author     : Gaby's
--%>
<%@page import="DB.UsersController"%>
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
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/icon.ico">

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap-grid.min.css" rel="stylesheet"> 
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="css/style-sb_1.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link href="css/cover.css" rel="stylesheet">

        <title>Florapédia</title>
    </head>
    <body class="text-center" id="body" onload="Init()">

        <div class="wrapper" id="wrapper">
            <%@include file="./WEB-INF/sidebar.jspf"%>

            <div class="content">
                <%@include file="WEB-INF/sidebarbtn.jspf" %>

                <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">


                    <main role="main" class="inner cover">
                        <% boolean logedin = session.getAttribute("loginUsername") != null && session.getAttribute("loginPass") != null
                                    && UsersController.INSTANCE.check((String) session.getAttribute("loginUsername"), (String) session.getAttribute("loginPass"));
                            if (!logedin) {
                        %><jsp:forward page="Login.jsp" /><%}
                            String uc = "";
                            uc = request.getParameter("uc");
                            if (request.getParameter("uc") == null) {
                                uc = "main";
                            }

                            if (uc.equals("main")) {%>
                        <div class="inner">
                            <h1 class="masthead-brand">Welcome to  Fl<a href="cover.jsp" style="text-decoration: none"><img src="image/ico.png" height="30px" width="30px" />rapedia</h1>
                        </div>

                        <%} else if (uc.equals("logout")) {
                                session.setAttribute("loginUsername", null);
                                session.setAttribute("loginPass", null);
                                response.sendRedirect("cover.jsp");
                            }%>

                    </main>

                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
                <input  type="hidden" name="uc" value="filter" />
            </div>
        </div>
        <script src="js/resize.js" type="text/javascript"></script>
    </body>
</html>