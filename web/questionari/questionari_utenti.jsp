<%@page import="beans.QuestionarioUtente"%>
<%@page import="beans.Questionario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Utente utente=(Utente)session.getAttribute("utente"); %>
<% 
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    ArrayList<QuestionarioUtente> lista=GestioneQuestionari.getIstanza().ricerca_questionari_utenti_id_questionario(id_questionario);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Questionari</title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
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
        
    </head>
    <body>
    <jsp:include page="../_menu.jsp"></jsp:include>
    <div id='container'>

        <h1>Questionari</h1>
        <div class="box">
            <input type="text" id="search" class="ricerca float-right" placeholder="Ricerca...">
            <table class="tabella" id="tabella">
                <tr>
                    <th style="width: 130px;"></th>
                    <th>Fornitore</th>
                    <th style="width: 100px;">Nr.</th>
                    <th>Titolo</th>
                    <th style="width: 120px;">Valutazione</th>
                    <th style="width: 180px;">Situazione</th>
                </tr>
                <tbody>
            <%  for(QuestionarioUtente q:lista){%>
                <tr>
                    <td>
                        <% if(q.getData_ora_valutazione()!=null || q.getData_ora_invio()==null){%>
                            <a href="questionari/questionario_utente.jsp?id_questionario_utente=<%=q.getId()%>&id_questionario=<%=q.getId_questionario()%>" class="pulsante_tabella color_orange"><img src="<%=Utility.img_edit%>">Visualizza</a>
                        <%}%>
                        <% if(q.getData_ora_valutazione()==null && q.getData_ora_invio()!=null){%>
                            <a href="questionari/questionario_utente.jsp?id_questionario_utente=<%=q.getId()%>&id_questionario=<%=q.getId_questionario()%>" class="pulsante_tabella color_orange"><img src="<%=Utility.img_edit%>">Valuta</a>
                        <%}%>
                    </td>
                    <td><%=q.getUtente().getRagione_sociale()%></td>
                    <td><%=q.getNr()%>/<%=q.getAnno()%></td>
                    <td>
                        <% if(utente.is_italiano()){%><%=q.getTitolo_ita()%><%}%>
                        <% if(utente.is_inglese()){%><%=q.getTitolo_eng()%><%}%>
                    </td>
                    <td>
                        <% if(q.getData_ora_valutazione()!=null){%>
                            <%=Utility.elimina_zero(q.getValutazione())%>
                        <%}%>
                        <% if(q.getData_ora_valutazione()==null && q.getData_ora_invio()!=null){%>
                            <div class="tag color_rifiutata">Da Valutare</div>
                        <%}%>
                    </td>
                    <td>
                        <% if(q.getStato()==null){%>
                            <div class="tag color_rifiutata">Da Iniziare</div>
                        <%}else{%>
                            <% if(q.is_bozza()){%>
                                <div class="tag color_rifiutata">Bozza</div>
                            <%}%>
                            <% if(q.getData_ora_invio()!=null){%>
                                <div class="tag color_green">Inviato il <%=q.getData_ora_invio_it()%></div>
                            <%}%>
                        <%}%>
                    </td>
                </tr>
          <%}%>
                </tbody>
            </table>
        </div>
    </div>
    </body>
</html>
