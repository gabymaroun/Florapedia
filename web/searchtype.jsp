<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">

        <link href="css/bootstrap-grid.min.css" rel="stylesheet"><link href="css/cover.css" rel="stylesheet">
    </head>

    <body class="text-center">

        <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
            <%@include file="WEB-INF/header.jspf" %>

            <main role="main" class="inner cover">
                <div class="mb-4">
                    <a href="searchByName.jsp" class="btn  btn-secondary btn-lg">
                        Rechercher par nom  <i class="fa fa-id-card"></i> 
                    </a>
                </div> <div class="mb-4">
                    <a href="searchfiltering.jsp" class="btn  btn-secondary btn-lg">
                        Filtration du recherche  <i class="fa fa-filter"></i> 
                    </a>

                </div>
                <%@include file="WEB-INF/backbtn.jspf" %>
            </main>

            <%@include file="WEB-INF/footer.jspf" %>
        </div>



    </body>
</html>
