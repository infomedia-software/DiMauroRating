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
            function nuovo_questionario(){
                $.ajax({
                    type: "POST",
                    url: "__nuovo_questionario.jsp",
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        location.reload();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function modifica_questionario(id_questionario,inField){
                var campo_da_modificare=inField.id;
                var new_valore=encodeURIComponent(String(inField.value));
                var refresh=inField.getAttribute("refresh");
                
                if(inField.type=="checkbox"){
                    if(inField.checked) 
                        new_valore="si"
                    else
                        new_valore="";
                }
                
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/questionari/__modifica_questionario.jsp?id_questionario="+id_questionario+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore,
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        if(refresh=="si")
                            location.reload();
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
                Questionari
                <button class="pulsante color_green float-right" onclick="nuovo_questionario();"><img src="<%=Utility.img_add%>">Nuovo Questionario</button>
            </h2>
            <table class="tabella">
                <tr>
                    <th style="width: 125px;"></th>
                    <th style="width: 70px;">Nr/Anno</th>
                    <th>Titolo</th>
                    <th style="width: 50px;">Attivo</th>
                    <th style="width: 110px;"></th>
                </tr>
            <% for(Questionario q:GestioneQuestionari.getIstanza().ricerca_questionari("")){ %>
            <tr>
                <td>
                    <a class="pulsante_tabella color_orange" href="<%=Utility.url%>/domande/domande.jsp?id_questionario=<%=q.getId()%>"><img src="<%=Utility.img_edit%>">Domande</a>
                    <a class="pulsante_tabella color_orange" href="<%=Utility.url%>/sezioni/sezioni.jsp?id_questionario=<%=q.getId()%>"><img src="<%=Utility.img_edit%>">Sezioni</a>
                </td>
                <td>
                    <input type="text" placeholder="Nr." value="<%=q.getNr()%>" onchange="modifica_questionario('<%=q.getId()%>',this)" id="nr">
                    <input type="text" value="<%=q.getAnno()%>" onchange="modifica_questionario('<%=q.getId()%>',this)" id="anno">
                </td>
                <td>
                    <input type="text" placeholder="Titolo questionario in italiano" value="<%=q.getTitolo_ita()%>" onchange="modifica_questionario('<%=q.getId()%>',this)" id="titolo_ita">
                    <input type="text" placeholder="Titolo questionario in inglese" value="<%=q.getTitolo_eng()%>" onchange="modifica_questionario('<%=q.getId()%>',this)" id="titolo_eng">
                </td>
                <td style="text-align: center;"><input type="checkbox" id="attivo" <% if(q.is_attivo()){%>checked="true"<%}%>  onchange="modifica_questionario('<%=q.getId()%>',this)"></td>
                <td><button class="pulsante_tabella" onclick="modifica_questionario('<%=q.getId()%>',this)" id="stato" refresh="si"><img src="<%=Utility.img_delete%>">Cancella</button></td>
            </tr>
            <tr>
                <td colspan="5">
                     <a class="pulsante_tabella float-right color_evasa" href="<%=Utility.url%>/questionari/questionari_utenti.jsp?id_questionario=<%=q.getId()%>"><img src="<%=Utility.img_edit%>">Questionari Fornitori</a>
                </td>
            </tr>
            <%}%>
            </table>
        </div>
        </body>
</html>