<%@page contentType="text/html" pageEncoding="UTF-8" session="true"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="image/icon.ico">
        <title>Bienvenue sur Florapédia</title>

        <link href="css/bootstrap_1.css" rel="stylesheet">
        <!-- Custom styles for this template -->

        <link href="css/bootstrap-grid.min.css" rel="stylesheet"><link href="css/cover.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css">
        <link href="css/cover.css" rel="stylesheet">

    </head>

    <body class="text-center">

        <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
            <%@include file="WEB-INF/header.jspf" %>

            <main role="main" class="inner cover">

                <div class="mb-4">
                    Florapédia est un site Web qui vous permet de rechercher des espèces.
                </div>
                <div class="mb-4">
                    <div class="mb-4">
                        <a href="searchtype.jsp" class="btn btn-lg btn-secondary ">Rechercher <i class="fa fa-search"></i></a>
                    </div> <div class="mb-4">  <a href="Login.jsp" class="btn btn-lg btn-secondary ">S'identifier  <i class="fa fa-user"></i></a>
                    </div> <div class="mb-4">  <a href="showall.jsp" class="btn btn-lg btn-secondary ">Voire tous les taxons  <i class="fa fa-book"></i></a>
                    </div>

            </main>

            <%@include file="WEB-INF/footer.jspf" %>
        </div>



    </body>
</html>
