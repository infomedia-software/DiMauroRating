<%@page import="beans.Risposta"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="beans.Utente"%>
<%@page import="beans.Allegato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneAllegati"%> 
<%@page import="utility.Utility"%>
<%
    Utente utente=(Utente)session.getAttribute("utente");
    String query=Utility.elimina_null(request.getParameter("query"));
    String id_risposta=Utility.elimina_null(request.getParameter("id_risposta"));
    String cartella_upload=Utility.elimina_null(request.getParameter("cartella_upload"));
    
    Risposta r=GestioneQuestionari.getIstanza().ricerca_risposte(" risposte.id="+id_risposta).get(0);
    ArrayList<Allegato> allegati=GestioneAllegati.getIstanza().ricercaAllegati(query);
%>

<script type='text/javascript'>
    
    function aggiorna_allegati(){                
        //var queryallegati=$("#queryallegati").val();                    
        //var id_risposta=$("#id_risposta").val();                    
        //$("#allegati").load("<%=Utility.url%>/_allegati.jsp?query="+encodeURIComponent(String(queryallegati))+"&id_risposta="+id_risposta+" #allegati_inner",function(){nascondi_loader();});
        location.reload();
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
</script>

<input type='hidden' id='queryallegati' value="<%=query%>">
<input type='hidden' id='id_risposta' value="<%=id_risposta%>">
<input type='hidden' id='allegati' value="<%=allegati.size()%>">
<div id='allegati'>
    <div id='allegati_inner'>        
        
        <%if(allegati.size()==0){%>
            <div class="messaggio">Nessun Allegato presente</div>
            <input type='hidden' class="risposta" name="risposta" domanda="<%=r.getDomanda().getSezione().getNr()%>.<%=r.getDomanda().getNr()%> <% if(utente.is_italiano()){%>No attachments<%}else{%><%}%>" value="">
        <%}else{%>
            <input type='hidden' class="risposta" name="risposta" domanda="<%=r.getDomanda().getSezione().getNr()%>.<%=r.getDomanda().getNr()%> <% if(utente.is_italiano()){%><%=r.getDomanda().getTesto_ita()%><%}else{%><%=r.getDomanda().getTesto_eng()%><%}%>"  value="si">
            <table class="tabella">
                <tr>  
                    <th style="width:50px"></th>
                    <th>Nome File</th>
                    <th style="width: 45px"></th>
                </tr>
                <%for(Allegato allegato:allegati){%>
                    <tr>                
                        <td>
                            <a href='<%=Utility.url%>/allegati/<%=cartella_upload%>/<%=allegato.getUrl()%>' class="pulsante_small" target="_blank" style="pointer-events: auto">                        
                                <img src="<%=Utility.img_link%>" alt="edit">
                            </a>
                        </td>
                        <td style="overflow: hidden;">
                            <a href='<%=Utility.url%>/allegati/<%=cartella_upload%>/<%=allegato.getUrl()%>' target="_blank" style="pointer-events: auto">                        
                                <%=allegato.getUrl()%>
                            </a>
                        </td>                        
                        <td>                            
                            <button class="pulsante_small color_red" type="button" onclick="modifica_allegato(this,'<%=allegato.getId()%>');" id="stato" value="-1">
                                <img src="<%=Utility.url%>/images/delete.png" alt="edit">
                            </button>                            
                        </td>
                    </tr>
                <%}%>
            </table>
        <%}%>
    </div>
</div>