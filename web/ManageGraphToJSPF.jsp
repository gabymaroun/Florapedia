
<%@page import="java.util.Iterator"%>
<%@page import="DB.KeyController"%>
<%@page import="ent.TypesNames"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ent.Relation"%>
<%@page import="ent.Key"%>
<%@page import="DB.GraphController"%>
<%@page import="ent.Graph"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-internet.css" rel="stylesheet" type="text/css"/>
<script src="jquery/jquery.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<link href="css/style-sb.css" rel="stylesheet" type="text/css">
<script src="js/Sweet.min.js" type="text/javascript"></script>

        <title>Florapédia</title>

<link rel="icon" href="../../../../favicon.ico">

<link href="css/bootstrap-grid.min.css" rel="stylesheet"> 
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
<%@include file="./WEB-INF/ManageGraph.jspf"%>

<title>Graphe Management</title>


</head>
<body id="body" onload="Init()" class="" style="">
    <div class="wrapper">
        <%@include file="./WEB-INF/sidebar.jspf"%>

        <div class="content">
            <button type="button" id="sidebarCollapse" class="btn btn-info">
                <i class="fa fa-align-justify"></i> 
            </button>
          
            <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">

                <!-- Modal -->
                <div class="modal fade" id="myModal" role="dialog" style="display: none;">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title">Cle Information</h1>
                            </div>
                            <div class="modal-body">
                                <h3>Caracteristique</h3>
                                <input id="Description" type="text" class="form-control">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" id="Ajouter">Ajouter</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal" id="Close">Close</button>
                            </div>
                        </div>

                    </div>

                </div>
                <div class="modal fade" id="MyTaxonModel" role="dialog" style="display: none;">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title" id="TaxonHeader"></h1>
                            </div>
                            <div class="modal-body">
                                <h3>Nom</h3>
                                <input id="Nom" type="text" class="form-control">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal" id="Ajouter_Taxon">Ajouter Taxon</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal" id="CloseTax">Close</button>
                            </div>
                        </div>

                    </div>

                </div>



                <div id="countainer">
                </div>
                <div class="content">
                    <nav class="navbar navbar-inverse">

                        <div class="container-fluid" id="navbarNav">
                            <ul class="nav navbar-nav">
                                <li><button id="add" class="btn btn-primary btn-blue" data-toggle="modal" data-target="#myModal">Add Cle</button></li>
                                <li><button id="addTaxon" class="btn btn-primary btn-blue" data-toggle="modal" data-target="#MyTaxonModel">Add Taxon</button></li>
                                <li><button id="Move" class="btn btn-primary">Move</button></li>
                                <li><button id="Relation" class="btn btn-primary">Relation</button></li>
                                <li><button id="DeleteRelation" class="btn btn-primary">Delete Relation</button></li>
                                <li><button id="Save" class="btn btn-primary">Save</button></li>
                                <li><button id="Rearrange" class="btn btn-primary">Rearrange</button></li>
                                <li><a href="ManageGraphs.jsp?Rootid=1">Clef Des Groupes</a></li>
                            </ul>
                        </div>
                    </nav>

                    <canvas id="canvas" width="1920" height="938" tabindex="1"></canvas>

                    <div id="DeleteDiv" class="big" >
                        <button class="btn btn-primary" id="DeleteKey" >Delete</button>
                        <div id="TaxonLink"  display="none" >
                        </div>
                    </div>
                </div>
                <%@include file="./WEB-INF/footer.jspf"%>
                </form>
            </div>
            <input  type="hidden" name="uc" value="init" />
        </div>
    </div>
</body>

<div id="test"></div>
<table id="one">
</table>
</html>