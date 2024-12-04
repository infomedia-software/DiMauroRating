<%@page import="gestioneDB.GestioneUtenti"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    Utente utente=(Utente)session.getAttribute("utente");  
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Utenti | <%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        
        <script type="text/javascript">
            function nuovo_utente(){                
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/utenti/__nuovo_utente.jsp",
                    data: "",
                    dataType: "html",
                    success: function(id_utente){                        
                        location.href='<%=Utility.url%>/utenti/utente.jsp?id_utente='+id_utente;
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE nuovo_utente");
                    }
                });
            }
             $(function(){
                $('#fileupload').fileupload({              
                    start:function(e,data){
                        mostra_loader("Importazione in corso... l'operazione potrebbe richiedere svariati minuti...");
                    },
                    done: function (e, data) {                
                        $.each(data.files, function (index, file) {
                            var temp=data.result;
                            alert("Importazione avvenuta correttamente");
                            location.reload();
                        });                                
                    },     
                    stop: function (e) {                
                        nascondi_loader();                
                    },                            
                    disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
                    imageMaxWidth: 800,
                    imageMaxHeight: 600,
                    imageCrop: false,
                    progressall: function (e, data) {
                        var progress1 = parseInt(data.loaded / data.total * 100, 10);
                        var progress2 = 100-progress1;
                        $('#progress1').css('width',progress1 + '%');
                        $('#progress2').css('width',progress2 + '%');
                    }
                }); 
            });
    
        </script>
        
    </head>
    <body>
        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id="container">
        
            <h1>                
                Fornitori
                <button class="pulsante float-right" onclick="nuovo_utente()"><img src="<%=Utility.url%>/images/add.png">Nuovo</button>
            </h1>
            <div class="box">
                <div class="etichetta float-right">Importa csv (<a href="importa.csv">Scarica file di esempio</a>)</div>
                <input class="pulsante" id="fileupload" type="file" name="files[]" data-url="<%=Utility.url%>/utenti/__importa_utenti.jsp" multiple>                               
            </div>            
            <jsp:include page="_utenti.jsp"></jsp:include>
            </div>
        </div>
    </body>
</html>
