<%@page import="utility.Utility"%>

<%
    String idrif=Utility.elimina_null(request.getParameter("idrif"));
    String rif=Utility.elimina_null(request.getParameter("rif"));    
%>

<script type='text/javascript'>
    
      $(function () {
        $("#fileupload_<%=rif%>").fileupload({   
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    var nomefile=data.result;                                            
                    $.ajax({
                        type: "POST",
                        url: "<%=Utility.url%>/__nuovo_allegato.jsp",
                        data: "idrif=<%=idrif%>&rif=<%=rif%>&url="+encodeURIComponent(String(nomefile)),
                        dataType: "html",
                        success: function(msg){
                            <%if(rif.contains("IMMAGINE")){%>
                                location.reload();
                            <%}else{%>
                                aggiorna_allegati();
                            <%}%>
                        },
                        error: function(){
                            alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE fileupload");
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
    
    function uploadclick_<%=rif%>(){
        document.getElementById('fileupload_<%=rif%>').click();
    }
</script>
    
<input id="fileupload_<%=rif%>" style='display:none' type="file" name="files[]" data-url="<%=Utility.url%>/__upload.jsp" multiple >

<button class='pulsante float-right' onclick="uploadclick_<%=rif%>();">       
    <img src="<%=Utility.url%>/images/add.png">
    <%if(rif.toUpperCase().
            contains("IMMAGINE")){%>
        Immagine
    <%}else{%>
    Allegato 
        <%}%>
</button>
<div class='height-10'></div>