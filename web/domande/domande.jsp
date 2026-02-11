<%@page import="java.util.ArrayList"%>
<%@page import="beans.Domanda"%>
<%@page import="beans.Questionario"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="beans.Sezione"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Utente utente=(Utente)session.getAttribute("utente"); 
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    Questionario questionario=GestioneQuestionari.getIstanza().get_questionario(id_questionario);
    ArrayList<Sezione> sezioni=GestioneSezioni.getIstanza().ricerca("");
    ArrayList<Domanda> domande=GestioneQuestionari.getIstanza().ricerca_domande(" domande.id_questionario="+id_questionario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        <script type="text/javascript">
            
            function nuova_domanda(){
                var id_sezione=$("#form_nuova_domanda #id_sezione").val();
                if(id_sezione==""){
                    alert("Selezionare una sezione per procedere.");
                    return;
                }
                mostra_loader("Operazione in corso");
                $.ajax({
                    type: "POST",
                    url: "__nuova_domanda.jsp",
                    data: $("#form_nuova_domanda").serialize(),
                    dataType: "html",
                    success: function(msg){
                        aggiorna_domande();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function nuova_domanda_condizione(id_questionario, id_sezione,id_domanda_principale){
                mostra_loader("Operazione in corso");
                $.ajax({
                    type: "POST",
                    url: "__nuova_domanda.jsp?id_domanda_principale="+id_domanda_principale+"&id_questionario="+id_questionario+"&id_sezione="+id_sezione,
                    data: $("#form_nuova_domanda").serialize(),
                    dataType: "html",
                    success: function(msg){
                        aggiorna_domande();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function modifica_domanda(id_domanda,inField){
                var campo_da_modificare=inField.id;
                var new_valore=encodeURIComponent(String(inField.value));
                var refresh=inField.getAttribute("refresh");
                if(campo_da_modificare=="nr"){
                    var new_ordinamento=parseInt(new_valore);
                    var id_sezione=$(inField).attr("id_sezione");
                    if (!Number.isInteger(parseFloat(new_valore))) {
                        alert("Il valore inserito non è un numero intero!");
                        $(inField).val($(inField).attr("old_value"));
                        return;
                    }
                    if(new_ordinamento<1){
                        alert("Impossibile inserire un numero minore di 1");
                        $(inField).val($(inField).attr("old_value"));
                        return;
                    }
                }
                
                if(inField.type=="checkbox"){
                    if(inField.checked) 
                        new_valore="si"
                    else
                        new_valore="";
                }
                if(campo_da_modificare=="peso"){
                    var peso=parseFloat(new_valore);
                    if(peso<0 || peso>1){
                        var old_value=inField.getAttribute("old_value");
                        alert("Inserire un peso compreso tra 0 e 1");
                        $(inField).val(old_value);
                        $(inField).focus();
                        return;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "__modifica_domanda.jsp?id_domanda="+id_domanda+"&campo_da_modificare="+campo_da_modificare+"&new_valore="+new_valore+"&id_sezione="+id_sezione,
                    data: "",
                    dataType: "html",
                    success: function(msg){
                        if(msg.includes("errore")){
                            alert(msg);
                            $(inField).val($(inField).attr("old_value"));
                            return;
                        }
                        if(refresh=="si")
                            aggiorna_domande();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                    }
                });
            }
            
            function aggiorna_domande(){
                mostra_loader("Operazione in corso...");
                $("#div_domande").load("<%=Utility.url%>/domande/domande.jsp?id_questionario=<%=id_questionario%> #div_domande_inner",function(){nascondi_loader();})
            }
            
            function nascondi_popup(){
                function_nascondi_popup();
                $('html, body').animate({ scrollTop: $(document).height() }, 'slow');
            }
        </script>
    </head>
    <body>
    
        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id='container'>
            <h2>
                Domande del questionario <%=questionario.getNr()%>/<%=questionario.getAnno()%> - <%=questionario.getTitolo_ita()%>
                <div class="clear"></div>
                <a class="pulsante float-left" target="_blank" href="stampa_domande.jsp?id_questionario=<%=id_questionario%>">Stampa</a>
                <button class="pulsante color_green float-right" onclick="mostra_popup('_nuova_domanda.jsp?id_questionario=<%=id_questionario%>');"><img src="<%=Utility.img_add%>">Nuova Domanda</button>
            </h2>
            <div class="height-10"></div>
            <div id="div_domande">
                <div id="div_domande_inner">
                
                <% //int max_ordinamento=1; 
                String id_sezione_corrente="";
                for(Domanda d:domande){
                    if(!d.getSezione().getId().equals(id_sezione_corrente) || id_sezione_corrente.equals("")){
                        id_sezione_corrente=d.getSezione().getId();
                    %>
                        <h3>Sezione <%=d.getSezione().getTesto_ita()%></h3>
                    <%}%>
                <div class="box">
                    
                    <% if(d.getVisibile_id().equals("")){%>
                        <h5>Domanda <%=d.getSezione().getTesto_ita()%> <%=d.getSezione().getNr()%>.<input type="number" style="width: 50px;" placeholder="Nr." refresh="si" value="<%=d.getNr()%>" old_value="<%=d.getNr()%>" id_sezione="<%=id_sezione_corrente%>" onchange="modifica_domanda('<%=d.getId()%>',this)" id="nr"></h5>
                    <%}%>
                    <div class="width-50 float-left"></div>
                    
                    <div class="clear"></div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Domanda in italiano</div>
                        <div class="valore">
                            <textarea onchange="modifica_domanda('<%=d.getId()%>',this)" id="testo_ita"><%=Utility.standardizza_textarea(d.getTesto_ita())%></textarea> 
                        </div>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Domanda in inglese</div>
                        <div class="valore">
                            <textarea onchange="modifica_domanda('<%=d.getId()%>',this)" id="testo_eng"><%=Utility.standardizza_textarea(d.getTesto_eng())%></textarea> 
                        </div>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Tipologia</div>
                        <div class="valore">
                            <select id="tipo" onchange="modifica_domanda('<%=d.getId()%>',this)" refresh="si">
                                <option value="<%=Domanda.tipo_SI_NO%>" <% if(d.is_si_no()){%>selected<%}%>>Si/No</option>
                                <option value="<%=Domanda.tipo_TESTO%>" <% if(d.is_testo()){%>selected<%}%>>Testuale</option>
                                <option value="<%=Domanda.tipo_NUMERO%>" <% if(d.is_numero()){%>selected<%}%>>Numerica</option>
                                <option value="<%=Domanda.tipo_SELECT%>" <% if(d.is_select()){%>selected<%}%>>Scelta Esclusiva</option>
                                <option value="<%=Domanda.tipo_CHECKBOX%>" <% if(d.is_checkbox()){%>selected<%}%>>Scelta Multipla</option>
                                <option value="<%=Domanda.tipo_ALLEGATO%>" <% if(d.is_allegato()){%>selected<%}%>>File Allegato</option>
                            </select>
                        </div>
                        <% if(d.is_select() || d.is_checkbox()){%>
                            <div class="etichetta">Valori della scelta (separati da virgola)</div>
                            <div class="valore">
                                <textarea id="valori" onchange="modifica_domanda('<%=d.getId()%>',this)"><%=Utility.standardizza_textarea(d.getValori())%></textarea>
                            </div>
                        <%}%>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Peso</div>
                        <div class="valore">
                            <input type="text" placeholder="Peso" min="0" max="1" old_value="<%=Utility.elimina_zero(d.getPeso())%>" value="<%=Utility.elimina_zero(d.getPeso())%>" onchange="modifica_domanda('<%=d.getId()%>',this)" id="peso">
                        </div>
                            <% if(!d.getVisibile_id().equals("")){%>
                            <div class="etichetta">Visibile se la domanda</div>
                            <div class="valore">
                                <select id="visibile_id" refresh="si" onchange="modifica_domanda('<%=d.getId()%>',this)" style="pointer-events: none;">
                                    <option value="">Sempre</option>
                                    <% for(Domanda dd:domande){%>
                                        <option value="<%=dd.getId()%>" <% if(d.getVisibile_id().equals(dd.getId())){%> selected="true" <%}%> ><%=dd.getSezione().getNr()%>.<%=dd.getNr()%></option>
                                    <%}%>
                                </select>
                            </div>
                            
                                <div class="etichetta">è uguale a </div>
                                <div class="valore">
                                    <input type="text" id="visibile_condizione"  onchange="modifica_domanda('<%=d.getId()%>',this)" value="<%=d.getVisibile_condizione()%>">
                                </div>
                            
                            <%}%>
                    </div>
                    <div class="clear"></div>
                        <button class="pulsante_tabella float-right" onclick="modifica_domanda('<%=d.getId()%>',this)" id="stato" refresh="si" value="-1"><img src="<%=Utility.img_delete%>">Cancella</button>
                        <% if(d.getVisibile_id().equals("")){%>
                            <button class="pulsante_tabella color_green float-right" onclick="nuova_domanda_condizione('<%=id_questionario%>','<%=d.getSezione().getId()%>','<%=d.getId()%>')"><img src="<%=Utility.img_add%>">Domanda su condizione</button>
                        <%}%>
                    <div class="clear"></div>
                </div>
                <div class="height-10"></div>
                <%}%>
                <button class="pulsante color_green float-right" onclick="mostra_popup('_nuova_domanda.jsp?id_questionario=<%=id_questionario%>');"><img src="<%=Utility.img_add%>">Nuova Domanda</button>
                </div>
            </div>
        </div>
    </body>
</html>