<%@page import="beans.Utente"%>
<%@page import="beans.Allegato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneAllegati"%> 
<%@page import="utility.Utility"%>
<%
    Utente utente=(Utente)session.getAttribute("utente");
    String query=Utility.elimina_null(request.getParameter("query"));
    ArrayList<Allegato> allegati=GestioneAllegati.getIstanza().ricercaAllegati(query);
%>

<script type='text/javascript'>
    
    function aggiorna_allegati(){                
        var queryallegati=$("#queryallegati").val();                    
        $("#allegati").load("<%=Utility.url%>/_allegati.jsp?query="+encodeURIComponent(String(queryallegati))+" #allegati_inner",function(){nascondi_loader();});
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


<div id='allegati'>
    <div id='allegati_inner'>        
        
        <%if(allegati.size()==0){%>
            <div class="messaggio">Nessun Allegato presente</div>
        <%}else{%>
            <table class="tabella">
                <tr>  
                    <th style="width:50px"></th>
                    <th>Nome File</th>
                    <th style="width: 45px"></th>
                </tr>
                <%for(Allegato allegato:allegati){%>
                    <tr>                
                        <td>
                            <a href='<%=Utility.url%>/allegati/<%=allegato.getUrl()%>' class="pulsante_small" target="_blank">                        
                                <img src="<%=Utility.img_link%>" alt="edit">
                            </a>
                        </td>
                        <td style="overflow: hidden;">
                            <a href='<%=Utility.url%>/allegati/<%=allegato.getUrl()%>' target="_blank">                        
                                <%=allegato.getUrl()%>
                            </a>
                        </td>                        
                        <td>                            
                            <button class="pulsante_small color_red" onclick="modifica_allegato(this,'<%=allegato.getId()%>');" id="stato" value="-1">
                                <img src="<%=Utility.url%>/images/delete.png" alt="edit">
                            </button>                            
                        </td>
                    </tr>
                <%}%>
            </table>
        <%}%>
    </div>
</div>