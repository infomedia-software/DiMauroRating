<%@page import="java.util.Map"%>
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
    Questionario questionario=GestioneQuestionari.getIstanza().get_questionario(id_questionario);
    Map<String,Double> mappa_valutazioni_massime_questionari_utenti=GestioneQuestionari.getIstanza().mappa_valutazioni_massime_questionari_utenti(id_questionario);
  //  double valutazione_massima=GestioneQuestionari.getIstanza().valutazione_massima_questionario(id_questionario);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Questionario <%=questionario.getTitolo_ita()%></title>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.4/xlsx.full.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2.0.5/FileSaver.min.js"></script>
        <script>
            function exportToExcel() {
                const table = document.getElementById('tabella');
                const wb = XLSX.utils.table_to_book(table, {sheet: "Sheet JS"});
                const wbout = XLSX.write(wb, {bookType: 'xlsx', bookSST: true, type: 'binary'});
                const blob = new Blob([s2ab(wbout)], {type: 'application/octet-stream'});
                saveAs(blob, 'questionari.xlsx');
            }

            function s2ab(s) {
                const buf = new ArrayBuffer(s.length);
                const view = new Uint8Array(buf);
                for (let i = 0; i !== s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
                return buf;
            }
        </script>
        
    </head>
    <body>
    <jsp:include page="../_menu.jsp"></jsp:include>
    <div id='container'>

        <h1>Questionario  <%=questionario.getTitolo_ita()%> </h1>
        <button onclick="exportToExcel()" class="float-right pulsante_tabella color_green">Esporta in Excel</button>
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
                            <a href="<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=q.getId()%>&id_questionario=<%=q.getId_questionario()%>" class="pulsante_tabella color_orange"><img src="<%=Utility.img_edit%>">Dettagli</a>
                        <%}%>
                        <% if(q.getData_ora_valutazione()==null && q.getData_ora_invio()!=null){%>
                            <a href="<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=q.getId()%>&id_questionario=<%=q.getId_questionario()%>" class="pulsante_tabella color_orange"><img src="<%=Utility.img_edit%>">Dettagli</a>
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
                           <% if(mappa_valutazioni_massime_questionari_utenti.get(q.getUtente().getId())!=null){%>
                                <%=Utility.elimina_zero(Utility.arrotonda_double(q.getValutazione()*100/mappa_valutazioni_massime_questionari_utenti.get(q.getUtente().getId()),2))%>%
                           <%}%>
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
