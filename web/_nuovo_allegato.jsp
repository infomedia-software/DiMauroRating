<%@page import="utility.Utility"%>

<%
    String idrif=Utility.elimina_null(request.getParameter("idrif"));
    String rif=Utility.elimina_null(request.getParameter("rif"));    
%>

<script type='text/javascript'>
    
      $(function () {
        $("#fileupload_<%=rif%>_<%=idrif%>").fileupload({   
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    var nomefile=data.result;                                            
                    $.ajax({
                        type: "POST",
                        url: "<%=Utility.url%>/__nuovo_allegato.jsp",
                        data: "idrif=<%=idrif%>&rif=<%=rif%>&url="+encodeURIComponent(String(nomefile)),
                        dataType: "html",
                        success: function(msg){                            
                            location.reload();
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
    
    function uploadclick_<%=rif%>_<%=idrif%>(){
        document.getElementById('fileupload_<%=rif%>_<%=idrif%>').click();
    }
</script>
    
<input id="fileupload_<%=rif%>_<%=idrif%>" style='display:none' type="file" name="files[]" data-url="<%=Utility.url%>/__upload.jsp" multiple >

<button class='pulsante_tabella float-right' onclick="uploadclick_<%=rif%>_<%=idrif%>();">       
    <img src="<%=Utility.url%>/images/add.png">
    <%if(rif.toUpperCase().
            contains("IMMAGINE")){%>
        Immagine
    <%}else{%>
    Allegato 
        <%}%>
</button>
<div class='height-10'></div>