<%@page import="java.util.Map"%>
<%@page import="beans.RichiestaRiga"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%@page import="beans.Allegato"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneAllegati"%>
<%@page import="beans.Richiesta"%>
<%@page import="gestioneDB.GestioneRichieste"%>
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
    String id_richiesta=Utility.elimina_null(request.getParameter("id_richiesta"));
    String risposto=Utility.elimina_null(request.getParameter("risposto"));
    Richiesta r=GestioneRichieste.getIstanza().get_richiesta(id_richiesta);
    Map<String,RichiestaRiga> mappa_soggetto_richieste=GestioneRichieste.getIstanza().mappa_soggetto_richieste(id_richiesta);
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>    
        <script type="text/javascript">
            
            
            function nuova_richiesta_righe(){
                var oggetto=$("#form_invia_mail #oggetto").val();
                var testo=$("#form_invia_mail #testo").val();
                var allegati=parseInt($("#form_invia_mail #allegati").val());
                var modulo=$("#form_invia_mail #modulo").val();
                var id_soggetti=$("#form_invia_mail #id_soggetti").val();
                var altre_mail=$("#form_invia_mail #altre_mail").val();
                if(oggetto=="" || testo=="" || allegati==0 || modulo=="" || (id_soggetti=="" && altre_mail=="") ){
                    alert("Impossibile procedere.\nVerifica di aver inserito l'oggetto, il testo, gli allegati, il modulo e di aver selezionato almeno un'azienda con indirizzo email settato");
                    return;
                }
                if(confirm("Sei sicuro di voler inviare le mail alle aziende selezionate?")){
                    mostra_loader("Invio mail in corso...");
                    $.ajax({
                        type: "POST",
                        url: "__nuova_richiesta_righe.jsp",
                        data: $("#form_invia_mail").serialize(),
                        dataType: "html",
                        success: function(msg){
                            alert("Email inviate correttamente.");
                            location.reload();
                        },
                        error: function(){
                            alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                        }
                    });
                }
            }
            
           
            
              $(function () {
                $("#oggetto").focus();
                $("#fileupload_RICHIESTA_MODULO").fileupload({   
                    done: function (e, data) {
                        $.each(data.files, function (index, file) {
                            var nomefile=data.result;       
                            $.ajax({
                                type: "POST",
                                url: "<%=Utility.url%>/richieste/__modifica_richiesta.jsp?id_richiesta=<%=id_richiesta%>&campo_da_modificare=file_risposta&new_valore="+nomefile,
                                data: "",
                                dataType: "html",
                                success: function(msg){
                                    location.reload();
                                },
                                error: function(){
                                    alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE");
                                }
                            });
                        });
                    },
                    disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
                    imageMaxWidth: 800,
                    imageMaxHeight: 600,
                    imageCrop: false,
                    progressall: function (e, data) {
                        mostra_loader("Caricamento Allegato in corso...");                
                    }
                }); 
            });
            
            function selectall(inField){
                $('.checkbox_soggetti').prop('checked', inField.checked);   
                seleziona_soggetto();
            }

            function seleziona_soggetto(){
                var id_soggetti = $('.checkbox_soggetti:checked').map(function() {return this.value;}).get().toString();
                $("#id_soggetti").val(id_soggetti);
                
            }
            
            function seleziona_altre_mail(){
                var altre_mail = $('.checkbox_altre_mail:checked').map(function() {return this.value;}).get().toString();
                $("#altre_mail").val(altre_mail);
                
            }
            
            function aggiorna_utente(){
                mostra_loader("Modifica in corso...");
                location.reload();
            }
            
           
            
            $(document).ready(function(){
                $("#search").on("keyup", function() {
                      var value = $(this).val().toLowerCase();
                      $("#tabella tbody tr").filter(function() {
                              $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                      });
                });
              });

        </script>
        <style>
            #tabella td, #tabella td input,#tabella td a,#tabella td div{
                font-size: 10px !important;
            }
        </style>
    </head>
    <body>
                
            <jsp:include page="../_menu.jsp"></jsp:include>
            <div id='container'>
            
            <h2>
                Richiesta <%=r.getNumero()%>
                <button class="pulsante_tabella float-right" onclick="modifica_richiesta('<%=r.getId()%>',this)" id="stato" refresh="si"><img src="<%=Utility.img_delete%>">Cancella</button>
            </h2>
            <div class="height-10"></div>
            <div class="box">
            <form id="form_invia_mail">
                <input type="hidden" name="id_richiesta" value="<%=id_richiesta%>">
                <div class="etichetta">Oggetto</div>
                <div class="valore"><input type="text" placeholder="Oggetto richiesta" value="<%=r.getOggetto()%>" onchange="modifica_richiesta('<%=r.getId()%>',this)" id="oggetto" name="oggetto"></div>
                <div class="etichetta">Testo</div>
                <div class="valore"><textarea placeholder="Testo email..." onchange="modifica_richiesta('<%=r.getId()%>',this)" id="testo" name="testo"><%=r.getTesto()%></textarea></div>
                <div class="width-50 float-left">
                    <div class="etichetta">Allegati</div>
                    <div class="valore">
                    <% String queryallegati=" allegati.rif='RICHIESTA_ALLEGATI' AND allegati.idrif="+Utility.is_null(r.getId())+" AND allegati.stato='1' ORDER BY allegati.id DESC";%>
                    <jsp:include page="../_allegati.jsp">
                        <jsp:param name="query" value="<%=queryallegati%>"></jsp:param>
                        <jsp:param name="id_risposta" value="<%=r.getId()%>"></jsp:param>
                        <jsp:param name="cartella_upload" value="<%=id_richiesta%>"></jsp:param>
                    </jsp:include>

                    <div class="height-10"></div>
                    <jsp:include page="../_nuovo_allegato.jsp">
                        <jsp:param name="idrif" value="<%=r.getId()%>"></jsp:param>
                        <jsp:param name="rif" value="RICHIESTA_ALLEGATI"></jsp:param>
                        <jsp:param name="cartella_upload" value="<%=id_richiesta%>"></jsp:param>
                    </jsp:include>

                    </div>
                </div>
                
                <div class="width-50 float-left">
                    <div class="etichetta">Modulo da Controfirmare</div>
                    <div class="valore">
                        <input type="hidden" value="<%=r.getFile_risposta()%>" id="modulo" name="modulo">
                            <%if(!r.getFile_risposta().equals("")){ %>
                                <span>
                                    <a href="<%=Utility.url%>/allegati/<%=id_richiesta%>/<%=r.getFile_risposta()%>" target="_blank">Modulo Allegato (<%=r.getFile_risposta()%>)</a>
                                </span>
                                    <button type="button" onclick="modifica_richiesta('<%=id_richiesta%>',this);" refresh="si" id="file_risposta" class="pulsante_small color_red float-right"><img src="<%=Utility.img_delete%>"></button>
                                <div class="height-10"></div>
                            <%}else{%>
                                <input id="fileupload_RICHIESTA_MODULO" type="file" name="files[]" data-url="<%=Utility.url%>/__upload.jsp?cartella_upload=<%=id_richiesta%>">
                            <%}%>
                    </div>
                </div>
                
                <div class="clear"></div>
                <!-- DESTINATARI -->
                <div class="etichetta">
                    Destinatari
                </div>
                <button class="pulsante color_evasa" type="button" onclick="nuova_richiesta_righe()"><img src="<%=Utility.url%>/images/email.png">Invia Email</button>
                    <input type="text" id="search" class="float-right" placeholder="Ricerca..." style="margin-top: 5px; height: 25px; padding-left: 5px;">
                    <a class="pulsante_tabella float-right color_eee" <% if(risposto.equals("no")){%> style="color:white;background-color: #008744;" <%}%> href="<%=Utility.url%>/richieste/richiesta.jsp?id_richiesta=<%=id_richiesta%>&risposto=no">Mancata Risposta</a>
                    <a class="pulsante_tabella float-right color_eee" <% if(risposto.equals("si")){%> style="color:white;background-color: #008744;" <%}%> href="<%=Utility.url%>/richieste/richiesta.jsp?id_richiesta=<%=id_richiesta%>&risposto=si">Risposto</a>
                    <input type="hidden" name="id_soggetti" id="id_soggetti">
                    <input type="hidden" name="altre_mail" id="altre_mail">
                    <table class="tabella" id="tabella">
                        <thead>
                            <tr>
                                <th style="width: 30px;padding-left: 0px;"><input type="checkbox" onclick="selectall(this)"></th>
                                <th style="width: 40px;">Codice</th>
                                <th>Azienda</th>
                                <th>Email Principale</th>
                                <th>Altre Email</th>
                                <th style="width: 100px;">Ultimo Invio</th>
                                <th>Data Risposta</th>
                                <th style="width: 50px;">Log</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Utente s:GestioneUtenti.getIstanza().fornitori()){
                                RichiestaRiga rr=new RichiestaRiga();
                                if(mappa_soggetto_richieste.get(s.getId())!=null)
                                    rr=mappa_soggetto_richieste.get(s.getId());
                                if(risposto.equals("") || (risposto.equals("si") && !rr.getData_risposta_it().equals("")) || (risposto.equals("no") && rr.getData_risposta_it().equals("")) ){
                                    if(!s.getEmail_principale().equals("") || !s.getEmail().equals("")){
                            %>
                                    <tr>
                                        <td>
                                            <input type="checkbox" value="<%=s.getId()%>" email="<%=s.getEmail_principale()%>" class="checkbox_soggetti" onclick="seleziona_soggetto()">
                                        </td>
                                        <td><%=s.getCodice()%></td>
                                        <td><a href="<%=Utility.url%>/utenti/utente.jsp?id_utente=<%=s.getId()%>" target="_blank"><%=s.getRagione_sociale()%></a></td>
                                        <td>
                                            <%  String email_principale=s.getEmail_principale();
                                                boolean altre_mail=true;
                                                if(email_principale.equals("")){
                                                    email_principale=s.getEmail();
                                                    altre_mail=false;
                                                }
                                                 %>
                                                <input type="text" value="<%=email_principale%>" id="email_principale" onchange="modifica_utente('<%=s.getId()%>',this)">
                                            
                                        </td>
                                        <td>
                                            <%  if(altre_mail){
                                                String[] emails=s.getEmail().split(",");
                                                int i=0;
                                                for(String email:emails){
                                                    if(!email.equals("")){%>
                                                    <div style="float: left; width: 20px;">
                                                        <input type='checkbox' class="checkbox_altre_mail" value="<%=s.getId()%>_<%=i%>" style='width: 15px; height: 15px;' onclick="seleziona_altre_mail()">
                                                    </div>
                                                    <div style="float: left; width: calc(100% - 20px); font-size: 8px;">
                                                        <%=email%>
                                                    </div>
                                                    <div class="clear"></div>
                                                <%i++;}%>
                                            <%}%>
                                            <%}%>
                                        </td>
                                        <td><%=rr.getData_ultimo_invio_it()%></td>
                                        <td>
                                            <% if(rr.is_risposto()){%>
                                                <div class="tag color_evasa"><a style="color:white;" href="<%=Utility.url%>/allegati/<%=id_richiesta%>/<%=s.getId()%>/<%=rr.getUpload_risposta()%>" target="_blank"><%=rr.getData_risposta_it()%></div>
                                            <%}%>
                                        </td>                               
                                        <td>
                                            <%if(mappa_soggetto_richieste.get(s.getId())!=null){%>
                                                <button type="button" class="pulsante_small float-right" onclick="mostra_popup('_log.jsp?id_richiesta_riga=<%=rr.getId()%>')"><img src="<%=Utility.url%>/images/search.png"></button>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <%}%>
                                <%}%>
                            <%}%>
                        </tbody>
                        </table>
                        <div class="height-10"></div>
                        
                        
                    </form>
                </div>
        </div>
    </body>
</html>