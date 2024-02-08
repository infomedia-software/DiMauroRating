<%@page import="beans.Sezione"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Utente utente=(Utente)session.getAttribute("utente"); 
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        <script type="text/javascript">
            function nuova_sezione(){
                $.ajax({
                    type: "POST",
                    url: "__nuova_sezione.jsp?id_questionario=<%=id_questionario%>",
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
            
            function modifica_sezione(id_sezione,inField){
                var campo_da_modificare=inField.id;
                var new_valore=encodeURIComponent(String(inField.value));
                var refresh=inField.getAttribute("refresh");
                $.ajax({
                    type: "POST",
                    url: "__modifica_sezione.jsp?id_sezione="+id_sezione+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore,
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
                Sezioni
                <button class="pulsante color_green float-right" onclick="nuova_sezione();"><img src="<%=Utility.img_add%>">Nuova Sezione</button>
            </h2>
            <div class="height-10"></div>
            <div class="box">
                
                <table class="tabella" id="tabella">
                    <tr>
                        <th>Nr.</th>
                        <th>Nome ITA</th>
                        <th>Nome ENG</th>
                        <th style="width: 110px;"></th>
                    </tr>
                <tbody>
                <% for(Sezione s:GestioneSezioni.getIstanza().ricerca(" id_questionario="+id_questionario)){ %>
                
                <tr>
                    <td><input type="number" placeholder="Nr." value="<%=s.getNr()%>" onchange="modifica_sezione('<%=s.getId()%>',this)" id="nr"></td>
                    <td><input type="text" placeholder="Nome sezione in italiano" value="<%=s.getTesto_ita()%>" onchange="modifica_sezione('<%=s.getId()%>',this)" id="testo_ita"></td>
                    <td><input type="text" placeholder="Nome sezione in inglese" value="<%=s.getTesto_eng()%>" onchange="modifica_sezione('<%=s.getId()%>',this)" id="testo_eng"></td>
                    <td><button class="pulsante_tabella" onclick="modifica_sezione('<%=s.getId()%>',this)" id="stato" refresh="si"><img src="<%=Utility.img_delete%>">Cancella</button></td>
                </tr>                
                <%}%>
                </tbody>
                </table>
            </div>
        </div>
    </body>
</html>