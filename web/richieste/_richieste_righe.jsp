<%@page import="beans.Utente"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="beans.RichiestaRiga"%>
<%@page import="utility.Utility"%>
<% 
    String id_soggetto=Utility.elimina_null(request.getParameter("id_soggetto"));
    ArrayList<RichiestaRiga> rrs=GestioneRichieste.getIstanza().ricerca_richieste_righe(" id_soggetto="+id_soggetto+" ORDER BY numero ASC ");
%>

<table class="tabella">
       <thead>
            <tr>
                <th>Richiesta</th>
                <th>Ultimo Invio</th>
                <th>Data Risposta</th>
                <th style="width: 50px;">Log</th>
            </tr>
        </thead>
        <tbody>
            <% for(RichiestaRiga rr:rrs){%>
            <tr>
                <td><a href="<%=Utility.url%>/richieste/richiesta.jsp?id_richiesta=<%=rr.getRichiesta().getId()%>"><%=rr.getRichiesta().getNumero()%> <%=rr.getRichiesta().getOggetto()%></a></td>
                <td><%=rr.getData_ultimo_invio_it()%></td>
                <td>
                    <% if(rr.is_risposto()){%>
                        <div class="tag color_evasa"><%=rr.getData_risposta_it()%></div>
                    <%}%>
                </td>
                <td><button type="button" class="pulsante_small float-right" onclick="mostra_popup('<%=Utility.url%>/richieste/_log.jsp?id_richiesta_riga=<%=rr.getId()%>')"><img src="<%=Utility.url%>/images/search.png"></button></td>
            </tr>

            <%}%>
        </tbody>
</table>
