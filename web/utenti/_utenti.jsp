<%@page import="beans.Utente"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%
    String query=Utility.elimina_null(request.getParameter("query"));
    Utente utente=(Utente)session.getAttribute("utente");  
    ArrayList<Utente> utenti=GestioneUtenti.getIstanza().ricerca(" id>1 ");
%>
<script>
$(document).ready(function(){
    $("#search").focus();
    $("#search").on("keyup", function() {
          var value = $(this).val().toLowerCase();
          $("#tabella tbody tr").filter(function() {
                  $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
          });
    });
});

</script>
<div class="box">
    <input type="text" id="search" class="ricerca float-right" placeholder="Ricerca...">
    <table class="tabella" id="tabella">
        <tr>
            <th></th>
            <th>Ragione Sociale</th>
            <th>Referente</th>
            <th>Email</th>                
            <th>P.Iva</th>                
        </tr>
        <tbody>
        <%for(Utente utente_temp:utenti){%>
            <tr>
                <td><a href="<%=Utility.url%>/utenti/utente.jsp?id_utente=<%=utente_temp.getId()%>" class="pulsante_tabella"><img src="<%=Utility.img_edit%>">Dettagli</a></td>
                <td><%=utente_temp.getRagione_sociale()%></td>
                <td><%=utente_temp.getReferente()%></td>
                <td>
                    <% if(utente.is_admin_richieste()){%><%=utente_temp.getEmail_principale()%><%}%>
                    <% if(utente.is_admin_richieste()){%><%=utente_temp.getEmail()%><%}%>
                </td>
                <td><%=utente_temp.getPiva()%></td>
            </tr>
        <%}%>  
        </tbody>
    </table>
</div>