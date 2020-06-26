
<%@page import="DB.KeyController"%>
<%@page import="ent.TypesNames"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ent.Relation"%>
<%@page import="ent.Key"%>
<%@page import="DB.GraphController"%>
<%@page import="ent.Graph"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="css/font-awesome.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap-internet.css" rel="stylesheet" type="text/css"/>
<script src="jquery/jquery.js" type="text/javascript"></script>
<script src="js/boostrap.js" type="text/javascript"></script>
<link href="css/style-sb.css" rel="stylesheet" type="text/css">
<script>

</script>

<script>
    function Init() {
    <% Graph C = new Graph();
            int Working = 0, Genre = 0;
            String UserRequest = request.getParameter("Graph");
            String Taxon = "";

            if (UserRequest != null) {
                Working = 1;
                C = GraphController.INSTANCE.findByKey(Integer.parseInt(request.getParameter("Graphid")));
                if (UserRequest.equals(TypesNames.ROOT)) {
                    Taxon = TypesNames.GROUP;
                } else if (UserRequest.equals(TypesNames.GROUP)) {
                    Taxon = TypesNames.FAMILY;
                } else if (UserRequest.equals(TypesNames.FAMILY)) {
                    Taxon = TypesNames.GENRE;
                } else {
                    Genre = 1;
                }
            }

            ArrayList<Key> Taxons = KeyController.INSTANCE.findAllTaxon();
            ArrayList<Key> Groupes = new ArrayList<>();
            ArrayList<Key> Families = new ArrayList<>();
            ArrayList<Key> Genres = new ArrayList<>();
            for (Key K : Taxons) {
                if (K.getType().equals(TypesNames.GROUP)) {
                    Groupes.add(K);
                } else if (K.getType().equals(TypesNames.FAMILY)) {
                    Families.add(K);
                } else {
                    Genres.add(K);
                }
            }
    %>
        var GHolder, FHolder ,link;
    <%
                        for (Key K : Groupes) {
    %>
        link = document.createElement("a");
        GHolder = document.getElementById("GroupesSubMenu");
        link.setAttribute("href", "test2.jsp?Graph=" + '<%=K.getType()%>' + "&Graphid=" +<%=GraphController.INSTANCE.findByStartingKeyID(K.getId()).getID()%>);
        link.innerHTML = '<%=K.getName()%>';
        GHolder.appendChild(link);
    <%
                      }

                      for (Key K : Taxons) {
    %>
                    var Holder;<%
                if (K.getType().equals(TypesNames.GROUP)) {
    %>

    <%
                } else if (K.getType().equals(TypesNames.FAMILY)) {
    %>

    <%
                } else {
    %>

    <%
                        }
                    }


    %>
                    document.getElementById("TaxonHeader").innerHTML = '<%=Taxon%>' + " Informations";
                    var MouseX;
                    var MouseY;
                    var State;
                    var count = 0;
                    var Rcount = 0;
                    var SelectedKey1 = 9999;
                    var SelectedKey2 = 9999;
                    var SelectedRightIndex = 9999;
                    var lastPositions = {
                        X: 0,
                        Y: 0
                    };
                    function Target(e)
                    {
                        if (e.offsetX)
                        {
                            MouseX = e.offsetX;
                            MouseY = e.offsetY;
                        } else
                        {
                            MouseX = e.layerX;
                            MouseY = e.layerY;
                        }
                    }
                    var dragStart = {
                        Varx: 0,
                        Vary: 0
                    };
                    var dragEnd;
                    var drag = false;
                    function Key() {
                        this.realID;
                        this.id;
                        this.Description;
                        this.Type;
                        this.x;
                        this.y;
                    }

                    function Relation() {
                        this.id;
                        this.realID;
                        this.Key1;
                        this.Key1Pos;
                        this.Key2;
                        this.Key2Pos;
                    }
                    var getTextHeight = function () {

                        var text = $('<span>Hg</span>').css({fontFamily: '12pt Calibri'});
                        var block = $('<div style="display: inline-block; width: 1px; height: 0px;"></div>');

                        var div = $('<div></div>');
                        div.append(text, block);

                        var body = $('body');
                        body.append(div);

                        try {

                            var result = {};

                            block.css({verticalAlign: 'baseline'});
                            result.ascent = block.offset().top - text.offset().top;

                            block.css({verticalAlign: 'bottom'});
                            result.height = block.offset().top - text.offset().top;

                            result.descent = result.height - result.ascent;

                        } finally {
                            div.remove();
                        }

                        return result;
                    };
                    function reset() {
                        /*if (SelectedIndex !== 9999) {
                         document.getElementById(Keys[SelectedIndex].id + "div").style.display = "none";
                         }*/
                        SelectedIndex = 9999;
                        SelectedKey1 = 9999;
                        SelectedKey2 = 9999;
                    }
                    var SelectedIndex = 9999;
                    var Keys = [];
                    var DeletedKeys = [];
                    var Relations = [];
                    var DeletedRelations = [];

                    var c = document.getElementById("canvas");

                    var size = {
                        width: window.innerWidth || document.body.clientWidth,
                        height: window.innerHeight || document.body.clientHeight
                    };

                    function FillRelations() {

                        var ul = document.getElementById("Data");

                        while (ul.firstChild) {

                            ul.removeChild(ul.firstChild);
                        }
                        /*while(ul.firstChild) ul.removeChild(ul.firstChild);
                         }*/

                        Relations.forEach(function (i, j) {
                            var li = document.createElement("li");
                            li.setAttribute("id", i.Key1 + "To" + i.Key2);
                            li.innerHTML = "From " + i.Key1 + " To " + i.Key2;
                            document.getElementById("Data").appendChild(li);
                        });

                    }

                    c.width = size.width;
                    c.height = size.height;
                    var Paint = c.getContext("2d");
                    function DrawInit() {
                        Paint.clearRect(0, 0, canvas.width, canvas.height);
                        Keys.forEach(function (i, j) {
                            if (lastPositions.X === i.x && lastPositions.Y === i.y) {

                                Keys[j].x += j * 30;
                                Keys[j].y += j * 30;
                                lastPositions.X = Keys[j].x;
                                lastPositions.Y = Keys[j].y;
                                /*var div = document.getElementById(i.id + "div");
                                 div.style.top = i.y + 125 + "px";
                                 div.style.left = i.x + 0 + "px";*/
                            }

                            if (i.Description.localeCompare("") === 0) {
                                Paint.fillStyle = "#FF0000";
                                Paint.fillRect(i.x, i.y, 150, 50);
                            } else {
                                Paint.font = '12pt Calibri';
                                Paint.fillStyle = 'black';
                                if (i.Type.localeCompare('<%=TypesNames.TRANSITION%>') !== 0) {
                                    Paint.font = '16pt Calibri';
                                    Paint.fillStyle = 'red';
                                }
                                var width = Paint.measureText(i.Description).width;
                                var height = getTextHeight().height + 3;
                                Paint.beginPath();
                                Paint.moveTo(i.x, i.y + height);
                                Paint.lineTo(i.x + width, i.y + height);
                                Paint.stroke();
                                Paint.fillText(i.Description, i.x, i.y + 20);
                            }
                            lastPositions.X = 25;
                            lastPositions.Y = 25;
                        });
                        Relations.forEach(function (i, j) {
                        
                            Paint.beginPath();
                            // Staring point (10,45)
                            Paint.moveTo(Keys[i.Key1Pos].x + Paint.measureText(Keys[i.Key1Pos].Description).width, Keys[i.Key1Pos].y + getTextHeight().height + 3);
                            // End point (180,47)
                            Paint.lineTo(Keys[i.Key2Pos].x, Keys[i.Key2Pos].y + getTextHeight().height + 3);
                            // Make the line visible
                            Paint.stroke();
                        });
                        lastPositions.X = 25;
                        lastPositions.Y = 25;
                    }
                    function Draw() {

                        Paint.clearRect(0, 0, canvas.width, canvas.height);
                        Keys.forEach(function (i, j) {
                            Paint.fillStyle = "#FF0000";

                            if (j === SelectedKey1 || j === SelectedIndex || j === SelectedKey2) {

                                Paint.fillStyle = "#A30000";
                            }
                            if (i.Description.localeCompare("") === 0)
                                Paint.fillRect(i.x, i.y, 150, 50);
                            else {

                                Paint.font = '12pt Calibri';
                                Paint.fillStyle = 'black';
                                if (i.Type.localeCompare('<%=TypesNames.TRANSITION%>') !== 0) {
                                    Paint.font = '16pt Calibri';
                                    Paint.fillStyle = 'red';
                                }
                                var width = Paint.measureText(i.Description).width;
                                var height = getTextHeight().height + 3;

                                Paint.beginPath();
                                Paint.moveTo(i.x, i.y + height);
                                Paint.lineTo(i.x + width, i.y + height);
                                Paint.stroke();
                                Paint.fillText(i.Description, i.x, i.y + 20);
                            }

                        });
                        Relations.forEach(function (i, j) {

                            Paint.beginPath();
                            // Staring point (10,45)
                            Paint.moveTo(Keys[i.Key1Pos].x + Paint.measureText(Keys[i.Key1Pos].Description).width, Keys[i.Key1Pos].y + getTextHeight().height + 3);
                            // End point (180,47)
                            Paint.lineTo(Keys[i.Key2Pos].x, Keys[i.Key2Pos].y + getTextHeight().height + 3);
                            // Make the line visible
                            Paint.stroke();
                        });
                    }

                    document.getElementById("Close").addEventListener("click", function () {
                        document.getElementById("Description").value = "";
                        reset();

                    });
                    document.getElementById("add").addEventListener("click", function () {
                         document.getElementById("Description").value="";
                         setTimeout(function() { document.getElementById("Description").focus(); }, 160);
                    });
                    document.getElementById("addTaxon").addEventListener("click", function () {
                        document.getElementById("Nom").value="";
                        setTimeout(function() { document.getElementById("Nom").focus(); }, 160);
                    });
                    document.getElementById("CloseTax").addEventListener("click", function () {
                        document.getElementById("Nom").value = "";
                        reset();
                    });
                    $(document).on("click", "#Save", function () { // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
                        <% if (UserRequest != null){ %>
                        var URL = "ModGraphServlet?uc=addgraph&";
                        var index;
                        URL += "idroot=" + '<%=C.getRoot().getId()%>' + "&typeroot=" + '<%=C.getRoot().getType()%>' + "&drn=" + DeletedRelations.length;
                        
                        DeletedRelations.forEach(function (i, j) {
                            URL += "&drid" + j + "=" + i.id;
                        });
                        URL += "&dkn=" + DeletedKeys.length;

                        DeletedKeys.forEach(function (i, j) {
                            URL += "&dkid" + j + "=" + i.realID;
                        });
                        URL += "&newkeyn=" + Keys.length;

                        Keys.forEach(function (i, j) {
                            URL += "&idreal" + j + "=" + i.realID + "&idfake" + j + "=" + i.id + "&name" + j + "=" + i.Description + "&type" + j + "=" + i.Type;
                        });
                        URL += "&newreln=" + Relations.length;
                        var A;
                        Relations.forEach(function (i, j) {
                            A = i.realID+"";
                            alert(i.id);
                            if (A.localeCompare("") === 0){
                                alert(i.id);
                                URL += "&idfrom" + j + "=" + i.Key1 + "&idto" + j + "=" + i.Key2 ;}
                        });
                        
                        $.get(URL, function (responseText) {
                            alert(responseText);
                        });
                    <%}%>
                    });
                    document.getElementById("DeleteKey").addEventListener("click", function () {
                        var A=Keys[this.value].id+"";
                        if (A.localeCompare("") === 0) {
                            DeletedKeys.push({realID:Keys[this.value].realID});
                            
                        } 
                        Keys.splice(this.value, 1);
                    });
                    document.getElementById("Move").addEventListener("click", function () {
                        State = "Move";
                        reset();
                    });
                    document.getElementById("DeleteRelation").addEventListener("click", function () {
                        State = "Delete Relation";
                        reset();
                    });
                    document.getElementById("Relation").addEventListener("click", function () {
                        State = "Relation";

                        reset();
                    });
                    document.getElementById("canvas").addEventListener('contextmenu', event => {
                        event.preventDefault();
                        var divi = document.getElementById("DeleteDiv");
                        divi.style.display = "none";
                        Keys.some(function (i, j) {
                            if (i.x < MouseX && i.x + 150 > MouseX && i.y < MouseY && i.y + 50 > MouseY && i.Description.localeCompare("") === 0 || i.x < MouseX && i.x + Paint.measureText(i.Description).width > MouseX && i.y < MouseY && i.y + getTextHeight().height > MouseY && i.Description.localeCompare("") !== 0) {
                                document.getElementById("DeleteKey").value = j;
                                divi.style.top = MouseY + canvas.getBoundingClientRect().top + "px";
                                divi.style.left = MouseX + "px";
                                divi.style.display = "block";
                                return true;
                            }
                            return false;
                        });
                    });

                    document.getElementById("Ajouter_Taxon").addEventListener("click", function () {
                        AddKey('<%=Taxon%>', 1);
                    });

                    document.getElementById("Ajouter").addEventListener("click", function () {
                        AddKey('<%=TypesNames.TRANSITION%>', 0);
                    });
                    function AddKey(Vari, M) {
                        var NewKey = new Key();
                        NewKey.realID = "";
                        NewKey.id = count;
                        count += 1;
                        if (M === 0)
                            NewKey.Description = document.getElementById("Description").value;
                        else
                            NewKey.Description = document.getElementById("Nom").value;
                        NewKey.Type = Vari;
                        NewKey.x = 25;
                        NewKey.y = 25;
                        Keys.push({realID: NewKey.realID, id: NewKey.id, Description: NewKey.Description, Type: NewKey.Type, x: NewKey.x, y: NewKey.y});
                        /*
                         * 
                         *
                         Right Click menu
                         *
                         *
                         */
                        DrawInit();
                    }
                    ;



                    c.addEventListener("mousedown", function (event) {
                        Target(event);
                        if (State.localeCompare("Move") === 0) {
                            if (SelectedIndex !== 9999) {
                                // document.getElementById(Keys[SelectedIndex].id + "div").style.display = "none";
                            }
                            if (SelectedRightIndex !== 9999) {
                                document.getElementById(Keys[SelectedRightIndex].id + "menu").style.display = "none";
                            }
                            Keys.some(function (i, j) {
                                //alert("Width: " + Paint.measureText(i.Description).width + " And Height : " + getTextHeight('12pt Calibri').height);
                                if (i.x < MouseX && i.x + 150 > MouseX && i.y < MouseY && i.y + 50 > MouseY && i.Description.localeCompare("") === 0 || i.x < MouseX && i.x + Paint.measureText(i.Description).width > MouseX && i.y < MouseY && i.y + getTextHeight().height > MouseY && i.Description.localeCompare("") !== 0) {
                                    SelectedIndex = j;

                                    /*document.getElementById(Keys[SelectedIndex].id + "div").style.display = "block";*/
                                    dragStart.Varx = MouseX - Keys[SelectedIndex].x;
                                    dragStart.Vary = MouseY - Keys[SelectedIndex].y;


                                    drag = true;
                                    return true;
                                } else {
                                    SelectedIndex = 9999;
                                }
                                drag = false;
                                return false;
                            });
                        } else {
                            Keys.some(function (i, j) {
                                if (i.x < MouseX && i.x + 150 > MouseX && i.y < MouseY && i.y + 50 > MouseY) {
                                    if (SelectedKey1 === 9999)
                                        SelectedKey1 = j;
                                    else
                                        SelectedKey2 = j;

                                }
                            });
                            if (SelectedKey1 !== 9999 && SelectedKey2 !== 9999) {
                                
                                if (SelectedKey1 !== SelectedKey2) {
                                    
                                    if (State.localeCompare("Relation") === 0) {
                                        var NewRelation = new Relation();
                                        NewRelation.id = Rcount++;
                                        NewRelation.realID = "";
                                        var A=Keys[SelectedKey1].id+"",
                                            B=Keys[SelectedKey2].id+"";
                                        
                                        if(A.localeCompare("")===0)
                                            NewRelation.Key1 = Keys[SelectedKey1].realID;
                                        else
                                            NewRelation.Key1 = Keys[SelectedKey1].id;
                                        
                                        if(B.localeCompare("")===0)
                                            NewRelation.Key2 = Keys[SelectedKey2].realID;
                                        else
                                            NewRelation.Key2 = Keys[SelectedKey2].id;
                                        NewRelation.Key1Pos = SelectedKey1;
                                        NewRelation.Key2Pos = SelectedKey2;
                                        Relations.push({id:NewRelation.id,realID:"",Key1: NewRelation.Key1, Key1Pos: NewRelation.Key1Pos, Key2: NewRelation.Key2, Key2Pos: NewRelation.Key2Pos});
                                        //test code//

                                        SelectedKey1 = 9999;
                                        SelectedKey2 = 9999;
                                    } else {
                                        var A,B,C;
                                        A = Keys[SelectedKey1].id+"";if(A.localeCompare("")===0){A=Keys[SelectedKey1].realID+"";}
                                        B = Keys[SelectedKey2].id+"";if(B.localeCompare("")===0){B=Keys[SelectedKey2].realID+"";}
                                        
                                        Relations.some(function (i, j) {
                                            if (i.Key1 === parseInt(A,10) && i.Key2 === parseInt(B,10)) {
                                                C = i.id+"";
                                                if (C.localeCompare("")===0) {
                                                    DeletedRelations.push({id: i.realID});
                                                }
                                                Relations.splice(j, 1);
                                                reset();
                                            }
                                        });
                                        reset();
                                    }
                                } else {
                                    SelectedKey1 = 9999;
                                    SelectedKey2 = 9999;
                                }
                            }

                            FillRelations();
                        }

                        Draw();
                    });

                    c.addEventListener("mousemove", function (event) {
                        if (drag && event.which === 1) {
                            Target(event);

                            Keys[SelectedIndex].x = MouseX - dragStart.Varx;
                            Keys[SelectedIndex].y = MouseY - dragStart.Vary;
                            var divi = document.getElementById("DeleteDiv");
                            if (divi.style.display === "block") {
                                /*  divi.style.top = parseInt(divi.style.top , 10)+ MouseY - dragStart.Vary +"px";
                                 divi.style.left= parseInt(divi.style.left , 10)+ MouseX - dragStart.Varx+ "px";*/

                            }
                            /*var div = document.getElementById(Keys[SelectedIndex].id + "div");
                             div.style.top = Keys[SelectedIndex].y + 125 + "px";
                             div.style.left = Keys[SelectedIndex].x + 0 + "px";*/
                            Draw();
                        }

                    });
                    c.addEventListener("mouseup", function (event) {
                        drag = false;
                    });
                    function checkEnter(e) {
                        e = e || event;
                        var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
                        return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
                    }


                    if (<%=Working%> === 1) {
    <%
        ArrayList<Relation> ARR = C.getLsr();
        ArrayList<Key> ARK = C.getLsk();
        for (Key K : ARK) {
    %>
                        Keys.push({realID:<%=K.getId()%>, id: "", Description: '<%=K.getName()%>', Type: '<%=K.getType()%>', x: 25, y: 25});

    <%
        }

        for (Relation R : ARR) {
    %>
                        Relations.push({id: "", realID:<%=R.getID()%>, Key1: <%=R.getFrom().getId()%>, Key1Pos: <%=ARK.indexOf(R.getFrom())%>, Key2: <%=R.getTo().getId()%>, Key2Pos:<%=ARK.indexOf(R.getTo())%>});
    <% }

    %>
                        DrawInit();
                        FillRelations();
                        if (<%=Genre%> === 1) {
                            document.getElementById("addTaxon").disabled = true;
                        }
                    }

                }
                function dragElement(elmnt) {
//alert(elmnt.id + "header");
                    var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
                    if (document.getElementById(elmnt.id + "header")) {
                        /* if present, the header is where you move the DIV from:*/

                        document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
                        //alert(elmnt.id + "header");
                    } else {
                        /* otherwise, move the DIV from anywhere inside the DIV:*/
                        elmnt.onmousedown = dragMouseDown;
                    }

                    function dragMouseDown(e) {

                        e = e || window.event;
                        e.preventDefault();
                        // get the mouse cursor position at startup:
                        pos3 = e.clientX;
                        pos4 = e.clientY;
                        document.onmouseup = closeDragElement;
                        // call a function whenever the cursor moves:
                        document.onmousemove = elementDrag;
                    }

                    function elementDrag(e) {

                        e = e || window.event;
                        e.preventDefault();
                        // calculate the new cursor position:
                        pos1 = pos3 - e.clientX;
                        pos2 = pos4 - e.clientY;
                        pos3 = e.clientX;
                        pos4 = e.clientY;
                        // set the element's new position:
                        elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
                        elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
                    }

                    function closeDragElement() {
                        /* stop moving when mouse button is released:*/
                        document.onmouseup = null;
                        document.onmousemove = null;
                    }
                }

                $(document).ready(function () {
                    $('#sidebarCollapse').on('click', function () {
                        $('#sidebar').toggleClass('active');
                    });
                });
</script>

        <style>
            canvas {border: 1px solid  black;position:relative;}
            div.big {
                position: absolute;
                z-index: 9;
                background-color: #f1f1f1;
                text-align: center;
                border: 1px solid #d3d3d3;
                display: none;
            }

            div.small {
                padding: 10px;
                cursor: move;
                z-index: 10;
                background-color: #2196F3;
                color: #fff;
            }
            #holder {
                display:block;

                width:800px;
                height:600px;
            }.form-group {
                position: relative;
                margin-bottom: 1.5rem;
            }

            .form-control-placeholder {
                position: absolute;
                top: 0;
                padding: 7px 0 0 13px;
                transition: all 200ms;
                opacity: 0.5;
            }

            .form-control:focus + .form-control-placeholder,
            .form-control:valid + .form-control-placeholder {
                font-size: 75%;
                transform: translate3d(0, -100%, 0);
                opacity: 1;
            }

            .slider {
                -webkit-appearance: none;
                width: 100%;
                height: 25px;
                background: #d3d3d3;
                outline: none;
                opacity: 0.7;
                -webkit-transition: .2s;
                transition: opacity .2s;
            }

            .slider:hover {
                opacity: 1;
            }

            .slider::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                width: 25px;
                height: 25px;
                background: #4CAF50;
                cursor: pointer;
            }

            .slider::-moz-range-thumb {
                width: 25px;
                height: 25px;
                background: #4CAF50;
                cursor: pointer;
            }
        </style>

        <title>Graphe Management</title>


    </head>
    <body id="body" onload="Init()" class="" style="">


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



        <div class="wrapper">
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>FloraPedia</h3>
                </div>


                <ul class="list-unstyled components">
<<<<<<< .mine

                    <li>
||||||| .r22
<<<<<<< .mine
                    <li>
                        <a href="test2.jsp?Graph=root&amp;GraphName=">Clef Des Groupes</a>
||||||| .r17
                    <li>A
                        <a href="test2.jsp?Graph=root&amp;GraphName=">Clef Des Groupes</a>
=======
                    <li id="RootPage">
=======
>>>>>>> .r25
                        <a href="test2.jsp?Graph=root&amp;Graphid=1">Clef Des Groupes</a>
<<<<<<< .mine

||||||| .r22
>>>>>>> .r18
=======
>>>>>>> .r25
                    </li>
                    <li>
                        <!–-Groupes ->
                        <a href="#GroupesSubMenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Groupes</a>
                        <ul class="collapse list-unstyled" id="GroupesSubMenu">

                        </ul> 
                    </li>
                    <!–-Families ->
                    <li>
                        <a href="#">Services</a>
                    </li>
                    <li>
                        <a href="#">Contact Us</a>
                    </li>
                </ul>


            </nav>
            <div class="content">
                <nav class="navbar navbar-inverse">

                    <button type="button" id="sidebarCollapse" class="btn btn-info">
                        <i class="fa fa-align-justify"></i> <span >toggle sidebar</span>

                        <!--<a class="navbar-brand" href="#">Navbar</a> -->
                    </button>
                    <div class="container-fluid" id="navbarNav">
                        <ul class="nav navbar-nav">
                            <li><button id="add" class="btn btn-primary btn-blue" data-toggle="modal" data-target="#myModal">Add Cle</button></li>
                            <li><button id="addTaxon" class="btn btn-primary btn-blue" data-toggle="modal" data-target="#MyTaxonModel">Add Taxon</button></li>
                            <li><button id="Move" class="btn btn-primary">Move</button></li>
                            <li><button id="Relation" class="btn btn-primary">Relation</button></li>
                            <li><button id="DeleteRelation" class="btn btn-primary">Delete Relation</button></li>
                            <li><button id="Save" class="btn btn-primary">Save</button></li>
                        </ul>
                    </div>
                </nav>

                <canvas id="canvas" width="1920" height="938" tabindex="1"></canvas>

                <div id="DeleteDiv" class="big" >
                    <button class="btn btn-primary" id="DeleteKey" >Delete</button>
                </div>
            </div>





        </div>
        <div id="countainer">
        </div>



        <div>
            <ul id="Data">
                <li>Here are the data</li>
            </ul>
        </div>




        <script>

        </script>
    </body>

</html>
