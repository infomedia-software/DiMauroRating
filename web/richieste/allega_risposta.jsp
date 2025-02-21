<%@page import="gestioneDB.GestioneUtenti"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="beans.RichiestaRiga"%>
<%@page import="java.util.ArrayList"%>
<% 
    Utente utente=(Utente)session.getAttribute("utente"); 
    String id_richiesta=Utility.elimina_null(request.getParameter("id_richiesta"));
    // forzatura login per accesso soggetti
    String n=Utility.elimina_null(request.getParameter("n"));
    String p=Utility.elimina_null(request.getParameter("p"));
    if(utente==null && !n.equals("") && !p.equals("")){
        utente=GestioneUtenti.getIstanza().login(n, p);
    }
    ArrayList<RichiestaRiga> rrs=GestioneRichieste.getIstanza().ricerca_richieste_righe(" id_soggetto="+utente.getId()+" AND id_richiesta="+id_richiesta);
    RichiestaRiga rr=null;
    if(rrs.size()>0)
        rr=rrs.get(0);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>    
        <script type="text/javascript">
           $(function () {

                $("#fileupload_RISPOSTA_MODULO").fileupload({   
                   done: function (e, data) {
                       $.each(data.files, function (index, file) {
                           var nomefile=data.result;       
                           $.ajax({
                               type: "POST",
                               url: "<%=Utility.url%>/richieste/__allega_risposta.jsp?id_richiesta=<%=id_richiesta%>&id_soggetto=<%=utente.getId()%>&nome_file="+nomefile,
                               data: "",
                               dataType: "html",
                               success: function(msg){
                                   alert("File correttamente allegato");
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
        </script>
      
    </head>
    <body>

        <jsp:include page="../_menu.jsp"></jsp:include>
        <div id='container'>
            <h1><%=utente.getRagione_sociale()%></h1>
            <div class="box">
                <div class="etichetta">File da controfirmare</div>
                <div class="valore">
                <span><a href="<%=Utility.url%>/allegati/<%=id_richiesta%>/<%=rr.getRichiesta().getFile_risposta()%>" target="_blank">Modulo Allegato (<%=rr.getRichiesta().getFile_risposta()%>)</a></span>
                </div>
            </div>
            <div class="height-10"></div>
            <% if(!rr.is_risposto()){%>
                <div class="box">
                    <h3>Allega il File Firmato</h3>
                    <input id="fileupload_RISPOSTA_MODULO" type="file" name="files[]" data-url="<%=Utility.url%>/__upload.jsp?cartella_upload=<%=id_richiesta%>/<%=utente.getId()%>">
                </div>
            <%}else{%>
                <div class="box" style="border: 1px solid green;">
                    <div class="etichetta">File Allegato</div>
                    <div class="valore">
                        <a href="<%=Utility.url%>/allegati/<%=id_richiesta%>/<%=utente.getId()%>/<%=rr.getUpload_risposta()%>" target="_blank"><%=rr.getUpload_risposta()%></a>
                    </div>
                    <div class="etichetta">Data Invio</div>
                    <div class="valore">
                        <%=rr.getData_risposta_it()%>
                    </div>
                </div>
            <%}%>
            <div class="height-10"></div>
            <div class="margin-auto">
                <button class="margin-auto pulsante_tabella" onclick="logout();">Esci</button>
            </div>
        </div>    
    </body>
</html>