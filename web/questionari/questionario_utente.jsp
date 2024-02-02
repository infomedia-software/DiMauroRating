<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="beans.Sezione"%>
<%@page import="beans.QuestionarioUtente"%>
<%@page import="java.util.Map"%>
<%@page import="beans.Risposta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="beans.Questionario"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
Utente utente=(Utente)session.getAttribute("utente");
String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente")); 
String id_questionario=Utility.elimina_null(request.getParameter("id_questionario")); 
// se il questionario dell'utente ancora non è presente lo creo in stato bozza (b)
if(!id_questionario.equals("") && id_questionario_utente.equals("null")){
    id_questionario_utente=GestioneQuestionari.getIstanza().nuovo_questionario_utente(id_questionario, utente.getId());
    response.sendRedirect(Utility.url+"/questionari/questionario_utente.jsp?id_questionario_utente="+id_questionario_utente+"&id_questionario="+id_questionario);
}
Questionario q=GestioneQuestionari.getIstanza().get_questionario(id_questionario);
QuestionarioUtente qu=GestioneQuestionari.getIstanza().get_questionario_utente(id_questionario_utente);
ArrayList<Risposta> risposte=GestioneQuestionari.getIstanza().ricerca_risposte(" risposte.id_questionario_utente="+id_questionario_utente);
Map<String,String> mappa_domande_risposte=GestioneQuestionari.getIstanza().mappa_id_domande_risposte(id_questionario_utente);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        <script type="text/javascript">
            function modifica_risposta(id_risposta,inField){
                var campo_da_modificare=inField.name;
                var new_valore=encodeURIComponent(String(inField.value));
                var refresh=inField.getAttribute("refresh");
                
                if(inField.type=="checkbox"){
                    new_valore=checkbox_selezionate(id_risposta);
                }
                
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/questionari/__modifica_risposta.jsp?id_risposta="+id_risposta+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore,
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        aggiorna_questionario_utente();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function modifica_questionario_utente(id_questionario_utente,inField){
                var campo_da_modificare=inField.name;
                var new_valore=encodeURIComponent(String(inField.value));
                var refresh=inField.getAttribute("refresh");
                if(campo_da_modificare=="stato"){
                    if(!confirm("Sei sicuro di voler inviare il questionario?\nNB:non potrà essere più modificato."))
                        return;
                }
                if(campo_da_modificare=="valutazione" && new_valore=="0"){
                    if(!confirm("Sei sicuro di voler modificare le valutazioni del questionario?"))
                        return;
                }
                
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/questionari/__modifica_questionario_utente.jsp?id_questionario_utente="+id_questionario_utente+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore,
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
            
            function aggiorna_questionario_utente(){
                $("#div_qu").load("<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%> #div_qu_inner",function(){
                    var last_focus=$("#last_focus").val();
                    $("#"+last_focus).select().focus();             
                });
            }
            
            function checkbox_selezionate(id_risposta){
        	var checkedValues = $('.checkbox_'+id_risposta+':checked').map(function() {return this.value;}).get().toString();
                return checkedValues;
            }
            
            function salva_valutazione(id_questionario_utente){
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/questionari/__salva_valutazione.jsp?id_questionario_utente="+id_questionario_utente,
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
            
            $(function(){
                $( document ).on( "focusin", "input, select", function() {
                    $("#last_focus").val(this.id);
                });
            })
        </script>
    </head>
    <body>
    
        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id='container'>
            <h1><%=q.getNr()%> - 
                <% if(utente.is_italiano()){%> <%=q.getTitolo_ita()%> <%}%> 
                <% if(utente.is_inglese()){%> <%=q.getTitolo_eng()%> <%}%> 
                <% if(qu.getData_ora_valutazione()!=null){%>
                    <div class="tag color_green float-right">Valutato il <%=qu.getData_ora_valutazione_it()%></div>
                <%}%>
                <% if(qu.getData_ora_invio()!=null){%>
                    <div class="tag color_green float-right">Inviato il <%=qu.getData_ora_invio_it()%></div>
                <%}%>
                <% if(qu.is_bozza()){%>
                    <div class="tag color_rifiutata float-right">BOZZA</div>
                <%}%>
            </h1>
            <% if(qu.getData_ora_valutazione()!=null){
                Map<String,Integer> mappa_valutazioni=GestioneQuestionari.getIstanza().mappa_valutazioni_sezioni(id_questionario_utente);
                //System.out.println(mappa_valutazioni.toString());
            %>
                <div class="box">
                    <b>Valutazione Questionario</b>
                    <table class="tabella">
                        <tr>
                            <%for(Sezione s:GestioneSezioni.getIstanza().ricerca("")){%>
                                <th style="text-align: center;"><%=s.getTesto_ita()%></th>
                            <%}%>
                            <th>Tot. Questionario</th>
                        </tr>
                        <tr>
                            <%for(Sezione s:GestioneSezioni.getIstanza().ricerca("")){%>
                                <td style="text-align: center;">
                                    <% if(mappa_valutazioni.get(s.getId())!=null){%>
                                        <%=mappa_valutazioni.get(s.getId())%>
                                    <%}else{%>
                                        0
                                    <%}%>
                                </td>
                            <%}%>
                            <td style="text-align: center;"><b><%=Utility.elimina_zero(qu.getValutazione())%></b></td>
                        </tr>
                    </table>
                    <% if(qu.getData_ora_invio()!=null && qu.getData_ora_valutazione()!=null && utente.is_admin()){%>
                        <div class="height-10"></div>
                        <div class="height-10"></div>
                        <button class="pulsante float-right"  onclick="modifica_questionario_utente('<%=id_questionario_utente%>',this)" name="valutazione" value="0">Modifica Valutazione</button>
                    <%}%>
                </div>
                <div class="height-10"></div>
            <%}%>
            <input type='hidden' id='last_focus' readonly="true" tabindex="-1">
            <div id="div_qu">
                <div id="div_qu_inner">
                    <table class="tabella">
                        <tr>
                            <th style="width: 100px;">Sezione</th>
                            <th style="width: 100px;">Nr.</th>
                            <th>Domanda</th>
                            <th>Risposta</th>
                            <%if(utente.is_admin() && qu.getData_ora_invio()!=null){%>
                                <th style="width: 80px;">Valutazione</th>
                            <%}%>
                        </tr>
                        <% for(Risposta r:risposte){%>
                            <% if(r.getDomanda().getVisibile_id().equals("") || mappa_domande_risposte.get(r.getDomanda().getVisibile_id()).equals(r.getDomanda().getVisibile_condizione())){%>
                            <tr>
                                <td>
                                    <% if(utente.is_italiano()){%>
                                        <%=r.getDomanda().getSezione().getTesto_ita()%>
                                    <%}else{%>
                                        <%=r.getDomanda().getSezione().getTesto_eng()%>
                                    <%}%>
                                </td>
                                <td><%=r.getDomanda().getSezione().getNr()%></td>
                                <td>
                                    <% if(utente.is_italiano()){%>
                                        <%=r.getDomanda().getTesto_ita()%>
                                    <%}else{%>
                                        <%=r.getDomanda().getTesto_eng()%>
                                    <%}%>
                                </td>
                                <td <% if(!utente.getId().equals(qu.getUtente().getId()) || qu.getData_ora_invio()!=null){%> style="pointer-events: none;" <%}%>>
                                    <% if(r.getDomanda().is_testo()){%>
                                        <input type="text" id="<%=r.getId()%>" name="risposta" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=r.getRisposta()%>">
                                    <%}%>
                                    <% if(r.getDomanda().is_numero()){%>
                                        <input type="number" id="<%=r.getId()%>" name="risposta" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=r.getRisposta()%>">
                                    <%}%>
                                    <% if(r.getDomanda().is_checkbox()){%>
                                    <% String valori[]=r.getDomanda().getValori().split(",");
                                        for(String v:valori){%>
                                            <%=v%> <input type="checkbox" id="<%=r.getId()%>" name="risposta" class="checkbox_<%=r.getId()%>" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=v%>" <% if(r.getRisposta().contains(v)){%> checked="true"<%}%>>
                                        <%}%>
                                    <%}%>
                                    <% if(r.getDomanda().is_select()){%>
                                        <% String valori[]=r.getDomanda().getValori().split(",");%>
                                        <select name="risposta" id="<%=r.getId()%>" onchange="modifica_risposta('<%=r.getId()%>',this)">
                                            <option value="">Seleziona la risposta</option>
                                            <%for(String v:valori){%>
                                                <option value="<%=v%>" <% if(r.getRisposta().equals(v)){%>selected="true"<%}%>><%=v%></option>
                                            <%}%>
                                        </select>
                                    <%}%>
                                    <% if(r.getDomanda().is_allegato()){%>
                                    
                                              <%
                                            String queryallegati=" allegati.rif='QUESTIONARIO_UTENTE' AND allegati.idrif="+Utility.is_null(id_questionario_utente)+" AND allegati.stato='1' ORDER BY allegati.id DESC";
                                            %>
                                            <jsp:include page="../_allegati.jsp">
                                                <jsp:param name="query" value="<%=queryallegati%>"></jsp:param>
                                            </jsp:include>

                                            <div class="height-10"></div>
                                            <jsp:include page="../_nuovo_allegato.jsp">
                                                <jsp:param name="idrif" value="<%=id_questionario_utente%>"></jsp:param>
                                                <jsp:param name="rif" value="QUESTIONARIO_UTENTE"></jsp:param>
                                            </jsp:include>
                                            
                                    <%}%>
                                </td>
                                <%if(utente.is_admin() && qu.getData_ora_invio()!=null){%>
                                    <td style="text-align: right;">
                                        <input style="text-align: right;" type="number" id="<%=r.getId()%>" name="valutazione" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=Utility.elimina_zero(r.getValutazione())%>">
                                    </td>
                                <%}%>
                            </tr>
                            <%}%>
                        <%}%>
                    </table>
                    
                    <% if(qu.getData_ora_invio()==null && !utente.is_admin()){%>
                        <button class="pulsante float-right" name="stato" value="1" onclick="modifica_questionario_utente('<%=id_questionario_utente%>',this)" >Invia Questionario</button>
                    <%}%>
                    <% if(qu.getData_ora_invio()!=null && qu.getData_ora_valutazione()==null && utente.is_admin()){%>
                        <button class="pulsante float-right"  onclick="salva_valutazione('<%=id_questionario_utente%>',this)" >Salva Valutazione</button>
                    <%}%>
                    
                </div>
            </div>
        </div>
    </body>
</html>