<%-- 
    Document   : homepage
    Created on : Oct 30, 2018, 4:47:02 PM
    Author     : Gaby's
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
    <head> 
        <title>Login</title>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="image/icon.ico">
        <link href="css/bootstrap_1.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/cover.css" rel="stylesheet">
        <link href="css/bootstrap-grid.min.css" rel="stylesheet">

        <script type="text/javascript">
            window.history.forward();
            function noBack() {
                window.history.forward();
            }
        </script>
        <% if (session.getAttribute("loginUsername") != null
                    && session.getAttribute("loginPass") != null
                    && UsersController.INSTANCE.check((String) session.getAttribute("loginUsername"), (String) session.getAttribute("loginPass"))) {
                response.sendRedirect("sidebar.jsp");
            } else {%>


        <%@include file="session.jspf" %><%}%>
    </head>


    <body class="text-center" onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="" >


        <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
            <%@include file="WEB-INF/header.jspf" %>
            <main role="main" class="inner cover">
                <form class="form-container" method="post">


                    <h5 class="mb-4">Connectez-vous</h5>

                    <div class="form-group">
                        <label class="btn btn-lg mt-4">Nom d'utilisateur : </label>
                        <input type="text" class="btn btn-lg mt-4" id="loginUsername" name="loginUsername" required>
                    </div>

                    <div class="form-group">
                        <label class="btn btn-lg mt-4">Mot de passe : </label>
                        <input type="password" class="btn btn-lg mt-4" id="loginPass" name="loginPass" required>
                    </div>

                    <%                        if (request.getParameter("loginUsername") != null && request.getParameter("loginPass") != null && UsersController.INSTANCE.check(request.getParameter("loginUsername"), request.getParameter("loginPass")) == false) {%>
                    <div class="text-danger " style="font-size:12px;">
                        <i class="fas fa-exclamation-triangle"></i>
                        Le nom d'utilisateur ou le mot de passe que vous avez entré est incorrect.
                    </div>
                    <%
                            request.setAttribute("login", "");
                        }%>


                    <button type="submit" class="btn btn-lg mt-4 btn-block" style="background-color:#fff;
                            color:rgba(0,42,52,1);"
                            value="login" name="loginBtn" id="loginBtn">
                        S'identifier
                    </button>
                </form>
                <br/>
                <%@include file="WEB-INF/backbtn.jspf" %>
            </main>

            <%@include file="WEB-INF/footer.jspf" %>
        </div>



    </body>

</html>