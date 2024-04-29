<%@page import="beans.Richiesta"%>
<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="beans.Questionario"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="beans.Sezione"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Utente utente=(Utente)session.getAttribute("utente"); %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>    
        <script type="text/javascript">
            function nuova_richiesta(){
                $.ajax({
                    type: "POST",
                    url: "__nuova_richiesta.jsp",
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        location.href="<%=Utility.url%>/richieste/richiesta.jsp?id_richiesta="+msg;
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
         
        </script>
    </head>
    <body>
                
            <jsp:include page="../_menu.jsp"></jsp:include>
            <div id='container'>
            <h2>
                Email
                <button class="pulsante color_green float-right" onclick="nuova_richiesta();"><img src="<%=Utility.img_add%>">Nuova Email</button>
            </h2>
            <table class="tabella">
                <tr>
                    <th style="width: 125px;"></th>
                    <th style="width: 70px;">Numero</th>
                    <th>Oggetto</th>
                    <th style="width: 110px;"></th>
                </tr>
                <% for(Richiesta r:GestioneRichieste.getIstanza().ricerca_richieste("")){ %>
            <tr>
                <td>
                    <a class="pulsante_tabella color_orange" href="<%=Utility.url%>/richieste/richiesta.jsp?id_richiesta=<%=r.getId()%>"><img src="<%=Utility.url%>/images/email.png">Invia</a>
                </td>
                <td>
                    <input type="number" placeholder="Numero" value="<%=r.getNumero()%>" onchange="modifica_richiesta('<%=r.getId()%>',this)" id="numero">
                </td>
                <td>
                    <input type="text" placeholder="Oggetto richiesta" value="<%=r.getOggetto()%>" onchange="modifica_richiesta('<%=r.getId()%>',this)" id="oggetto">
                </td>
                <td><button class="pulsante_tabella" onclick="modifica_richiesta('<%=r.getId()%>',this)" id="stato" refresh="si"><img src="<%=Utility.img_delete%>">Cancella</button></td>
            </tr>
            
            <%}%>
            </table>
        </div>
        </body>
</html>