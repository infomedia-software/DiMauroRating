<%@page import="gestioneDB.GestioneUtenti"%>
<%@page import="utility.Utility"%>
<%@page import="beans.Utente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    
    Utente utente_sessione=(Utente)session.getAttribute("utente");
     
    String id_utente=Utility.elimina_null(request.getParameter("id_utente"));
    Utente utente=GestioneUtenti.getIstanza().get_utente(id_utente);    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=utente.getRagione_sociale()%> | <%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        <script>
            function modifica_utente(id_utente,inField){
                var new_valore=inField.value;
                var campo_da_modificare=inField.id;
                if(campo_da_modificare==="stato"){
                    if(confirm("Procedere alla cancellazione dell'utente?")===false){
                        return;
                    }
                }
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/utenti/__modifica_utente.jsp",
                    data: "new_valore="+encodeURIComponent(String(new_valore))+"&campo_da_modificare="+campo_da_modificare+"&id_utente="+id_utente,
                    dataType: "html",
                    success: function(msg){
                        if(campo_da_modificare==="stato"){
                            location.href='<%=Utility.url%>/utenti/utenti.jsp';
                        }                
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE modifica_utente");
                    }
                });
            }
        </script>
    </head>
    <body>
        <jsp:include page="../_menu.jsp"></jsp:include>
        
        <div id="container">
            
            <h1>                                                     
                <%=utente.getRagione_sociale()%>
                
                <button class="pulsante_tabella float-right" onclick="modifica_utente(<%=id_utente%>,this);" id="stato" value="-1"><img src="<%=Utility.img_delete%>">Cancella</button>
               
            </h1>
                <div class="box">
           
                    <div class='etichetta'>Ragione Sociale</div>
                        <div class='valore'>
                            <input type='text' id='ragione_sociale' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getRagione_sociale()%>" >
                            <div class="height-10"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>P.Iva / C.F.</div>
                            <div class='valore'>
                                <input type='text' id='piva' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getPiva()%>">
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Email</div>
                            <div class='valore'>
                                <input type='text' id='email' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getEmail()%>">
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Referente</div>
                            <div class='valore'>
                                <input type='text' id='referente'  onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getReferente()%>">
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Ruolo</div>
                            <div class='valore'>
                                <input type='text' id='ruolo' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getRuolo()%>" >
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Indirizzo</div>
                            <div class='valore'>
                                <input type='text' id='indirizzo' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getIndirizzo()%>">
                            </div>
                        </div>
                        <div class="width-25 float-left">
                            <div class='etichetta'>Comune</div>
                            <div class='valore'>
                                <input type='text' id='comune' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getComune()%>">
                            </div>
                        </div>
                        <div class="width-25 float-left">
                            <div class='etichetta'>Provincia</div>
                            <div class='valore'>
                                <input type='text' id='provincia' onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getProvincia()%>">
                            </div>
                        </div>
                        <div class="etichetta">Lingua</div>
                        <div class="valore">
                            <select id="lingua" onchange="modifica_utente(<%=id_utente%>,this);" value="<%=utente.getProvincia()%>">
                                <option value="<%=Utente.LINGUA_IT%>" <% if(utente.is_italiano()){%>selected="true"<%}%>>Italiano</option>
                                <option value="<%=Utente.LINGUA_EN%>" <% if(utente.is_inglese()){%>selected="true"<%}%>>English</option>
                            </select>
                        </div>
                        <div class="height-10"></div>
                </div>
        </div>                                
    </body>
</html>
