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
        </script>
        
    </head>
    <body>
        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id="container">
        
            <h1>                
                Fornitori
            </h1>
          
            <jsp:include page="_utenti.jsp"></jsp:include>
            </div>
        </div>
    </body>
</html>
