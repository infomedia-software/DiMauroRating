<%@page import="beans.Domanda"%>
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
String last_focus=Utility.elimina_null(request.getParameter("last_focus")); 
String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente")); 
String id_questionario=Utility.elimina_null(request.getParameter("id_questionario")); 
// se il questionario dell'utente ancora non è presente lo creo in stato bozza (b)
if(!id_questionario.equals("") && id_questionario_utente.equals("null")){
    id_questionario_utente=GestioneQuestionari.getIstanza().nuovo_questionario_utente(id_questionario, utente.getId());
    response.sendRedirect(Utility.url+"/questionari/questionario_utente.jsp?id_questionario_utente="+id_questionario_utente+"&id_questionario="+id_questionario);
}

String id_domande_questionario=Utility.getIstanza().query_select("SELECT GROUP_CONCAT(id) AS id_domande_questionario FROM domande WHERE id_questionario="+id_questionario, "id_domande_questionario");
System.out.println("id_domande_questionario->"+id_domande_questionario);

String id_domande_questionario_utente=Utility.getIstanza().query_select("SELECT GROUP_CONCAT(id_domanda) AS id_domande_questionario_utente FROM risposte WHERE id_questionario_utente="+id_questionario_utente, "id_domande_questionario_utente");

id_domande_questionario_utente="_"+id_domande_questionario_utente.replaceAll(",", "__")+"_";
System.out.println("id_domande_questionario->"+id_domande_questionario);
System.out.println("id_domande_questionario_utente->"+id_domande_questionario_utente);

String id_da_inserire="";
String t1[]=id_domande_questionario.split(",");
for(String s:t1){
    if(!id_domande_questionario_utente.contains("_"+s+"_")){
        id_da_inserire=s+","+id_da_inserire;
    }
}
id_da_inserire=Utility.rimuovi_ultima_occorrenza(id_da_inserire, ",");
System.out.println("id_da_inserire="+id_da_inserire);

id_domande_questionario="_"+id_domande_questionario.replaceAll(",", "__")+"_";
String id_da_rimuovere="";
id_domande_questionario_utente=id_domande_questionario_utente.replaceAll("__",",").replaceAll("_", "");
String t2[]=id_domande_questionario_utente.split(",");
for(String s:t2){
    if(!id_domande_questionario.contains("_"+s+"_")){
        id_da_rimuovere=s+","+id_da_rimuovere;
    }
}
id_da_rimuovere=Utility.rimuovi_ultima_occorrenza(id_da_rimuovere, ",");
System.out.println("id_da_rimuovere="+id_da_rimuovere);

/*** INSERISCO LE DOMANDE CHE MANCANO ***/
if(!id_da_inserire.equals("")){
    ArrayList<Domanda> domande=GestioneQuestionari.getIstanza().ricerca_domande(" domande.id IN ("+id_da_inserire+")");
    if(domande.size()>0){
        String query_risposte="INSERT INTO risposte(id_questionario_utente,id_domanda,stato) VALUES ";
        for(Domanda d:domande){
            query_risposte=query_risposte+"("+Utility.is_null(id_questionario_utente)+","+Utility.is_null(d.getId())+",'1'),";
        }
        query_risposte=Utility.rimuovi_ultima_occorrenza(query_risposte, ",");
        Utility.getIstanza().query_insert(query_risposte);
    }
}
/** CANCELLO LE DOMANDE IN PIU ***/
if(!id_da_rimuovere.equals("")){
    Utility.getIstanza().query("DELETE FROM risposte WHERE id_domanda IN ("+id_da_rimuovere+") ");
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
                mostra_loader("");
                if(inField.type=="checkbox"){
                    new_valore=checkbox_selezionate(id_risposta);                    
                    if(new_valore.toLowerCase().includes("no")){
                        new_valore="no";
                    }
                }
                if(campo_da_modificare=="valutazione"){
                    var valutazione=parseFloat(new_valore);
                    if(valutazione<0 || valutazione>10){
                        var old_value=inField.getAttribute("old_value");      
                        alert("Inserire una valutazione da 0 a 10.");
                        $(inField).val(old_value);
                        nascondi_loader();
                        return;
                    }
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
                
                var last_focus=$("#last_focus").val();
                if(campo_da_modificare=="stato" && new_valore=="1"){
                    if(!confirm("Sei sicuro di voler inviare il questionario?\nNB:non potrà essere più modificato."))
                        return;
                }
                if(campo_da_modificare=="stato" && new_valore=="b"){
                    if(!confirm("Sei sicuro di voler trasformare il questionario in bozza?\nNB:potrai apportare modifiche al questionario."))
                        return;
                }
                if(campo_da_modificare=="valutazione" && new_valore=="0"){
                    if(!confirm("Sei sicuro di voler modificare le valutazioni del questionario?"))
                        return;
                }
                mostra_loader("");
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/questionari/__modifica_questionario_utente.jsp?id_questionario_utente="+id_questionario_utente+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore,
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        location.href='<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%>&last_focus='+last_focus;
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function aggiorna_questionario_utente(){
               /* $("#div_qu").load("<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%> #div_qu_inner",function(){
                    var last_focus=$("#last_focus").val();
                    $("#"+last_focus).select().focus();             
                     
                });*/
                var last_focus=$("#last_focus").val();
                location.href='<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%>&last_focus='+last_focus;
            }
        
            function modifica_allegato(inField,id_allegato){
                var new_valore=inField.value;
                var campo_da_modificare=inField.id;
                if(campo_da_modificare==='stato'){
                    if(confirm("Procedere alla cancellazione dell'allegato?")===false){            
                        return;
                    }
                }
                var query="UPDATE allegati SET "+campo_da_modificare+"='"+encodeURIComponent(String(new_valore))+"' WHERE id="+id_allegato;
                if(campo_da_modificare==='stato')
                    mostra_loader("Operazione in corso...");
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/__query.jsp",
                    data: "query="+query,
                    dataType: "html",
                    success: function(msg){
                        if(campo_da_modificare==='stato')
                            aggiorna_allegati();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE modifica_allegato()");
                    }
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
                        location.href='<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%>&last_focus='+last_focus;
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
                
            }
            
            function controlla_risposte(id_questionario_utente,inField) {
                var errore="";
                $('input[name="risposta"], select[name="risposta"]').each(function() {
                    var type = $(this).prop('type');
                    var classe = $(this).attr('class');
                    if ( ($(this).is(":visible") && type!='checkbox') || classe=="risposta" ) {
                        var valore=$(this).val();
                        if(valore==""){
                            errore=errore+"<br>- "+$(this).attr('domanda');
                        }
                    }
                });
                if(errore==""){
                    modifica_questionario_utente('<%=id_questionario_utente%>',inField);
                }else{
                    errore="Verifica di aver compilato correttamente le seguenti domande:<br>"+errore;
                    $("#errore").html(errore);
                    $("#errore").show();
                }
                return toReturn;
            }
            
            function rigenera_questionario(id_questionario_utente,id_questionario){
                if(confirm("Sicuro di voler aggiornare il questionario? Tutte le risposte saranno perse.")){
                    mostra_loader("Aggiornamento in corso");
                    $.ajax({
                        type: "POST",
                        url: "<%=Utility.url%>/questionari/__rigenera_questionario_utente.jsp?id_questionario_utente="+id_questionario_utente+"&id_questionario="+id_questionario,
                        data: "",
                        dataType: "html",
                        success: function(msg){
                            location.href='<%=Utility.url%>/questionari/questionario_utente.jsp?id_questionario_utente=<%=id_questionario_utente%>&id_questionario=<%=id_questionario%>&last_focus='+last_focus;
                        },
                        error: function(){
                            alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                        }
                    });
                }
            }
            
            $(function(){
                $( document ).on( "focusin", "input, select", function() {
                    $("#last_focus").val(this.id);
                });
                $("#<%=last_focus%>").focus();
            })
        </script>
    </head>
    <body>
    
        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id='container'>
            <h1><%=q.getNr()%> -  
                <% if(utente.is_italiano()){%> <%=q.getTitolo_ita()%> <%}%> 
                <% if(utente.is_inglese()){%> <%=q.getTitolo_eng()%> <%}%> 
                <% if(qu.getData_ora_invio()==null && utente.is_admin_questionari()){%>
                    <!-- button class="pulsante_tabella color_orange float-right" onclick="rigenera_questionario('<%=id_questionario_utente%>','<%=id_questionario%>')">Aggiorna Questionario</button-->
                <%}%>
                <% if(qu.getData_ora_valutazione()!=null){%>
                    <div class="tag color_green float-right">Valutato il <%=qu.getData_ora_valutazione_it()%></div>
                <%}%>
                <% if(qu.getData_ora_invio()!=null){%>
                    <div class="tag color_green float-right">Inviato il <%=qu.getData_ora_invio_it()%></div>
                    <% if(utente.is_admin_questionari()){%>
                        <button class="pulsante_tabella color_orange float-right" value="b" name="stato" onclick="modifica_questionario_utente('<%=id_questionario_utente%>',this)">Passa in Bozza</button>
                    <%}%>
                <%}%>
                <% if(qu.is_bozza()){%>
                    <div class="tag color_rifiutata float-right">BOZZA</div>
                <%}%>
                <button class="pulsante_tabella float-right" onclick="window.print()">Stampa</button>
            </h1>
            <% if(qu.getData_ora_valutazione()!=null){
                Map<String,Double> mappa_valutazioni=GestioneQuestionari.getIstanza().mappa_valutazioni_sezioni(id_questionario_utente);
                Map<String,Double> mappa_valutazioni_massime_sezioni=GestioneQuestionari.getIstanza().mappa_valutazioni_massime_sezioni(id_questionario_utente);
                Map<String,Double> mappa_valutazioni_massime_questionari_utenti=GestioneQuestionari.getIstanza().mappa_valutazioni_massime_questionari_utenti(id_questionario);
                //System.out.println(mappa_valutazioni_massime_questionari_utenti.toString());
                
            %>
                <div class="box">
                    <b>Valutazione Questionario</b>
                    <table class="tabella">
                        <tr>
                            <%for(Sezione s:GestioneSezioni.getIstanza().ricerca("id_questionario="+id_questionario)){%>
                                <th style="text-align: center;"><%=s.getTesto_ita()%></th>
                            <%}%>
                            <th>Tot. Questionario</th>
                        </tr>
                        <tr>
                            <%for(Sezione s:GestioneSezioni.getIstanza().ricerca(" id_questionario="+id_questionario)){%>
                                <td style="text-align: center;">
                                    <% if(mappa_valutazioni.get(s.getId())!=null){%>
                                        <%=Utility.elimina_zero(mappa_valutazioni.get(s.getId()))%>/<%=Utility.elimina_zero(mappa_valutazioni_massime_sezioni.get(s.getId()))%>
                                        <br>
                                        <h5><%=Utility.elimina_zero(Utility.arrotonda_double(mappa_valutazioni.get(s.getId())*100/mappa_valutazioni_massime_sezioni.get(s.getId()),2))%>%</h5>
                                    <%}else{%>
                                        0
                                    <%}%>
                                </td>
                            <%}%>
                            <td style="text-align: center;">
                                <% if(mappa_valutazioni_massime_questionari_utenti.get(qu.getUtente().getId())!=null){%>
                                    <b><%=Utility.elimina_zero(qu.getValutazione())%>/<%=Utility.elimina_zero(mappa_valutazioni_massime_questionari_utenti.get(qu.getUtente().getId()))%></b>
                                    <h4><%=Utility.elimina_zero(Utility.arrotonda_double(qu.getValutazione()*100/mappa_valutazioni_massime_questionari_utenti.get(qu.getUtente().getId()),2))%>%</h4>
                                <%}else{%>
                                    0
                                <%}%>
                            </td>
                        </tr>
                    </table>
                    <% if(qu.getData_ora_invio()!=null && qu.getData_ora_valutazione()!=null && utente.is_admin_questionari()){%>
                        <div class="height-10"></div>
                        <div class="height-10"></div>
                        <button class="pulsante float-right"  onclick="modifica_questionario_utente('<%=id_questionario_utente%>',this)" name="valutazione" value="0">Modifica Valutazione</button>
                    <%}%>
                </div>
                <div class="height-10"></div>
            <%}%>
            <input type='hidden' id='last_focus' readonly="true" tabindex="-1" value="<%=last_focus%>">
            <div id="div_qu">
                <div id="div_qu_inner">
                    <table class="tabella">
                        <tr>
                            <th style="width: 100px;"><% if(utente.is_italiano()){%>Sezione<%}else{%>Section<%}%></th>
                            <th style="width: 100px;">Nr.</th>
                            <th><% if(utente.is_italiano()){%>Domanda<%}else{%>Question<%}%></th>
                            <th><% if(utente.is_italiano()){%>Risposta<%}else{%>Answer<%}%></th>
                            <%if(utente.is_admin_questionari()&& qu.getData_ora_invio()!=null){%>
                                <th style="width: 80px;">Peso</th>
                                <th style="width: 80px;">Valutazione</th>
                            <%}%>
                        </tr>
                        <% for(Risposta r:risposte){%>
                            <% if(r.getDomanda().getVisibile_id().equals("") || mappa_domande_risposte.get(r.getDomanda().getVisibile_id()).contains(r.getDomanda().getVisibile_condizione())){%>
                            <tr>
                                <td>
                                    <%=r.getDomanda().getSezione().getNr()%>
                                    <% if(utente.is_italiano()){%>
                                        <%=r.getDomanda().getSezione().getTesto_ita()%>
                                    <%}else{%>
                                        <%=r.getDomanda().getSezione().getTesto_eng()%>
                                    <%}%>
                                </td>
                                <td title="<%=r.getId()%>"><% if(r.getDomanda().getVisibile_id().equals("")){%><%=r.getDomanda().getSezione().getNr()%>.<%=r.getDomanda().getNr()%><%}%></td>
                                <td>
                                    <% if(utente.is_italiano()){%>
                                        <%=r.getDomanda().getTesto_ita()%>
                                    <%}else{%>
                                        <%=r.getDomanda().getTesto_eng()%>
                                    <%}%>
                                </td>
                                <td id="risposta_<%=r.getId()%>" <% if((!utente.getId().equals(qu.getUtente().getId()) && !utente.is_admin_questionari()) || qu.getData_ora_invio()!=null){%> style="pointer-events: none;" <%}%>>
                                    <% if(r.getDomanda().is_testo()){%>
                                        <input type="text" domanda="<% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_ita()%><%}%>" id="<%=r.getId()%>" name="risposta" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=r.getRisposta()%>">
                                    <%}%>
                                    <% if(r.getDomanda().is_numero()){%>
                                        <input type="number" domanda="<% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_ita()%><%}%>" id="<%=r.getId()%>" name="risposta" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=r.getRisposta()%>">
                                    <%}%>
                                    <% if(r.getDomanda().is_checkbox()){%>
                                        <input type="hidden" domanda="<% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_ita()%><%}%>" id="<%=r.getId()%>" class="risposta" id="<%=r.getId()%>" name="risposta" value="<%=r.getRisposta()%>">
                                    <% String valori[]=r.getDomanda().getValori().split(",");
                                        for(String v:valori){%>
                                            <%=v%> 
                                            <input type="checkbox" id="<%=r.getId()%>" name="risposta" class="checkbox_<%=r.getId()%>" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=v%>" 
                                                <% if(r.getRisposta().toLowerCase().contains(v.toLowerCase())){%> checked="true"<%}%>
                                                <% if(r.getRisposta().toLowerCase().equals("no") && !v.toLowerCase().equals("no") ){%>disabled="true"<%}%>>
                                        <%}%>
                                    <%}%>
                                    <% if(r.getDomanda().is_select()){%>
                                        <% String valori[]=r.getDomanda().getValori().split(",");%>
                                        <select name="risposta" domanda="<% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_ita()%><%}%>" id="<%=r.getId()%>" onchange="modifica_risposta('<%=r.getId()%>',this)">
                                            <option value="">Seleziona la risposta</option>
                                            <%for(String v:valori){%>
                                                <option value="<%=v%>" <% if(r.getRisposta().equals(v)){%>selected="true"<%}%>><%=v%></option>
                                            <%}%>
                                        </select>
                                    <%}%>
                                    <% if(r.getDomanda().is_si_no()){%>
                                        
                                        <select name="risposta" domanda="<% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_ita()%><%}%>" id="<%=r.getId()%>" onchange="modifica_risposta('<%=r.getId()%>',this)">
                                            <option value="">Seleziona la risposta</option>
                                            <option value="si" <% if(r.getRisposta().equals("si")){%>selected="true"<%}%>>si</option>
                                            <option value="no" <% if(r.getRisposta().equals("no")){%>selected="true"<%}%>>no</option>
                                            <option value="n/a" <% if(r.getRisposta().equals("n/a")){%>selected="true"<%}%>>n/a</option>
                                        </select>
                                    <%}%>
                                    <% if(r.getDomanda().is_allegato()){%>
                                    
                                              <%
                                            String queryallegati=" allegati.rif='QUESTIONARIO_UTENTE' AND allegati.idrif="+Utility.is_null(r.getId())+" AND allegati.stato='1' ORDER BY allegati.id DESC";
                                            %>
                                            <jsp:include page="../_allegati.jsp">
                                                <jsp:param name="query" value="<%=queryallegati%>"></jsp:param>
                                                <jsp:param name="id_risposta" value="<%=r.getId()%>"></jsp:param>
                                            </jsp:include>
                                        <% if(qu.getData_ora_invio()==null){%>
                                            <div class="height-10"></div>
                                            <jsp:include page="../_nuovo_allegato.jsp">
                                                <jsp:param name="idrif" value="<%=r.getId()%>"></jsp:param>
                                                <jsp:param name="rif" value="QUESTIONARIO_UTENTE"></jsp:param>
                                            </jsp:include>
                                        <%}%>    
                                    <%}%>
                                </td>
                                <%if(utente.is_admin_questionari()&& qu.getData_ora_invio()!=null){%>
                                    <td style="text-align: right;">
                                        <%=Utility.elimina_zero(r.getDomanda().getPeso())%>
                                    </td>
                                    <td style="text-align: right;">
                                        <input style="text-align: right;<% if(qu.getData_ora_valutazione()!=null){%> pointer-events: none;<%}%>" type="number" id="<%=r.getId()%>"  name="valutazione" min="0" max="10" onchange="modifica_risposta('<%=r.getId()%>',this)" value="<%=Utility.elimina_zero(r.getValutazione())%>" old_value="<%=Utility.elimina_zero(r.getValutazione())%>">
                                    </td>
                                <%}%>
                            </tr>
                            <%}%>
                        <%}%>
                    </table>
                    <div class="box" id="errore" style="display: none;border:1px solid red;"></div>
                    <% if(qu.getData_ora_invio()==null){%>
                        <button class="pulsante float-right" name="stato" value="1" onclick="controlla_risposte('<%=id_questionario_utente%>',this);" >Invia Questionario</button>
                    <%}%>
                    <% if(qu.getData_ora_invio()!=null && qu.getData_ora_valutazione()==null && utente.is_admin_questionari()){%>
                        <button class="pulsante float-right"  onclick="salva_valutazione('<%=id_questionario_utente%>',this)" >Salva Valutazione</button>
                    <%}%>
                    
                </div>
            </div>
        </div>
    </body>
</html>