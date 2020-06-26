<%@page import="DB.UsersController"%>
<%@page import="java.util.Base64"%>
<%@page import="ent.TypesNames"%>
<%@page import="DB.KeyController"%>
<%@page import="ent.Key"%>
<%@page import="ent.Key"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
     <link rel="icon" href="image/icon.ico">

        <title>Cover Template for Bootstrap</title>

        <!-- Bootstrap core CSS -->

        <link href="css/bootstrap_1.css" rel="stylesheet">

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
        </script> <link href="css/cover.css" rel="stylesheet">
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
                    <%@include file="WEB-INF/header.jspf" %>
                    <main role="main" class="inner cover">

                        <%
                            int id;
                            if (request.getParameter("id") != null) {
                                id = Integer.parseInt(request.getParameter("id"));
                                Key e = KeyController.INSTANCE.findByKey(id);
                                if (e != null && e.getType().equals(TypesNames.ESPECE)) {
                        %>
                        <center>
                            <h1 class="btn-lg">
                                <%=e.getName()%>
                            </h1>
                            <%/*
                            response.setContentType("image/png");
                            OutputStream os=response.getOutputStream();
                            os.write(e.getImage().getBytes(1, (int)e.getImage().length()));
                            os.flush();
                            os.close();*/
                                if (e.getImage() != null) {
                            %>
                            <img height="300px" width="200px" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString((e.getImage().getBytes(1, (int) e.getImage().length())))%>" />
                            <br/>
                            <%} else {%><img height="300px" width="200px" src="image/noimage.jpg" />
                            <br/><%}

                                if (e.getDescription() != null) {
                            %>
                            <div class="btn-lg"><%=e.getDescription()%></div>
                            <%} else {
                            %>
                            <div class="mb-4">Description not found</div>
                            <%}%>

                            <% if (logedin) {
                            %>  
                            <a href="deleteEspeceServlet?id=<%=e.getId()%>" class="btn btn-secondary btn-md">Delete</a>
                            <%
                }%>


                        </center>

                        <%
                        } else {

                        %><div class="mb-4">no result found</div><%}
                        } else {

                        %><div class="mb-4">no result found</div><%    }

                        %>


                        <br/>
                        <%@include file="WEB-INF/backbtn.jspf" %>
                    </main>



                    <%@include file="./WEB-INF/footer.jspf"%>
                </div>
                <input  type="hidden" name="uc" value="filter" />
            </div>
                <%if(logedin){%>
        </div><%}%>
 <script src="js/resize.js" type="text/javascript"></script>
    </body>
</html>
