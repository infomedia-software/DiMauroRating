<%@page import="utility.Utility"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
<link rel="stylesheet" type="text/css" href="<%=Utility.url%>/css/stile_dimauro_rating.css">
<link rel="stylesheet" type="text/css" media="only screen and (max-width: 1023px)" href="<%=Utility.url%>/css/stile_dimauro_rating_responsive.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700|Roboto:300,400,500,600,700">        <!--end::Fonts -->

<meta name="theme-color" content="#92B13C" />
<script type="text/javascript" src="<%=Utility.url%>/utility/js/jquery-3.3.1.min.js"></script>

<!-- Datatables-->
<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>

<!-- Upload File-->   
<script src="<%=Utility.url%>/js/upload/js/vendor/jquery.ui.widget.js"></script>
<script src="<%=Utility.url%>/js/upload/js/jquery.iframe-transport.js"></script>
<script src="<%=Utility.url%>/js/upload/js/jquery.fileupload.js"></script>
<script src="<%=Utility.url%>/js/upload/js/load-image.min.js"></script>
<script src="<%=Utility.url%>/js/upload/js/canvas-to-blob.min.js"></script>    
<script src="<%=Utility.url%>/js/upload/js/jquery.fileupload-process.js"></script>
<script src="<%=Utility.url%>/js/upload/js/jquery.fileupload-image.js"></script>
<link rel="stylesheet" href="<%=Utility.url%>/js/upload/css/jquery.fileupload.css">


<script type="text/javascript">
    function mostra_loader(testo){
        $("#loader").show();
        $("#loader_testo").html(testo);
    }
    function nascondi_loader(){
        $("#loader").hide();
        $("#loader_testo").html("");         
    }     
    var popup_visibile=false;
    function nascondi_popup(){
        function_nascondi_popup();
    }    
    
    function function_nascondi_popup(){
        $("#popup_container #popup_contenuto").html("");
        $("#popup_container").hide();        
        popup_visibile=false;
    }
    
    var popup_visibile2=false;
    function mostra_popup2(arg,full_screen){     
        mostra_loader("Caricamento in corso...");              
        if(full_screen!==undefined){
            $("#popup2").css("width","calc(100% - 20px)");
        }else{
            $("#popup2").css("width","1000px");
        }
        $("#popup2 #popup2_contenuto").load(arg,function(){carica_datatable();nascondi_loader();});
        $("#popup2_container").show();        
        popup_visibile=true;
    }
    
    function nascondi_popup2(){
        function_nascondi_popup2();
    }    
    
    function function_nascondi_popup2(){
        $("#popup_container2 #popup2_contenuto").html("");
        $("#popup2_container").hide();        
        popup_visibile=false;
    }
    
    
    
    
    function logout(){
        if(confirm('Desideri uscire da <%=Utility.nome_software%>?')){            
            $.ajax({
                type: "POST",
                url: "<%=Utility.url%>/__logout.jsp",
                data: "",
                dataType: "html",
                success: function(page){
                    location.href="<%=Utility.url%>";
                },
                error: function(){
                    alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE logout");
                }
            });		
        }
    }
     function mostra_popup(arg,full_screen){     
        mostra_loader("Caricamento in corso...");   
        if(full_screen!==undefined){
            $("#popup").css("width","calc(100% - 60px)");
        }else{
            $("#popup").css("width","1000px");
        }
        $("#popup #popup_contenuto").load(arg,function(){nascondi_loader();});
        $("#popup_container").show();        
        popup_visibile=true;
    }
</script>

