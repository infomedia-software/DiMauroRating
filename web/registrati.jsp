<%@page import="utility.Utility"%>
<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Utente utente=(Utente)session.getAttribute("utente"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="_importazioni.jsp"></jsp:include>
        
    <script type="text/javascript">
        function login(){                
            var nome_utente=$("#nome_utente").val();
            var password=$("#password").val();  

            if(nome_utente!=="" && password!==""){
                mostra_loader("Accesso in corso");
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/__login.jsp",
                    data: "nome_utente="+nome_utente+"&password="+password,
                    dataType: "html",
                    success: function(msg){                                                        
                        if(msg==="no"){
                            alert("Nessun utente trovato con i dati inseriti");
                        }
                        location.reload();
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE login");
                    }
                });
            }		
        }
        function registrati(){                
            var ragione_sociale=$("#ragione_sociale").val();
            var piva=$("#piva").val();
            var email=$("#email").val();
            var referente=$("#referent").val();
            var ruolo=$("#ruolo").val();
            var indirizzo=$("#indirizzo").val();
            var comune=$("#comune").val();
            var provincia=$("#provincia").val();
            var errore="";
            if(ragione_sociale=="") errore=errore+"- ragione sociale\n";
            if(piva=="") errore=errore+"- p.iva / c.f.\n";
            if(email=="") errore=errore+"- email\n";
            if(referente=="") errore=errore+"- referente\n";
            if(ruolo=="") errore=errore+"- ruolo\n";
            if(indirizzo=="") errore=errore+"- indirizzo\n";
            if(comune=="") errore=errore+"- comune\n";
            if(provincia=="") errore=errore+"- provincia\n";
            if(errore!=""){
                alert("Verifica di aver compilato i seguenti campi:\n"+errore);
                return;
            }
                mostra_loader("Operazione in corso");
                $.ajax({
                    type: "POST",
                    url: "<%=Utility.url%>/__registrati.jsp",
                    data: $("#form_registrati").serialize(),
                    dataType: "html",
                    success: function(msg){ 
                        if(msg.includes("errore")){
                            alert(msg);
                            nascondi_loader();
                            return;
                        }else{
                            alert("Registrazione completata.\nRiceverai la password di accesso al seguente indirizzo email: "+email+"");
                            location.reload();
                        }
                    },
                    error: function(){
                        alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE login");
                    }
                });
           
        }



      


        $(function(){
            $("#nome_utente").focus();
            $("#form_login").keypress(function(e) {
                if($("#registrati").is(':visible')){
                    if(e.which === 13) {
                        registrati();
                    }
                }
                
            });
        });
    </script>

    <body>

        <jsp:include page="_menu.jsp"></jsp:include>
        <div id='container'>

            <div class="box">
                <div id="div_login">

                    <form id="form_registrati">
                        
                        <div class='etichetta'>Ragione Sociale - Company Name</div>
                        <div class='valore'>
                            <input type='text' id='ragione_sociale' name='ragione_sociale' >
                            <div class="height-10"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>P.Iva o C.F. / VAT number</div>
                            <div class='valore'>
                                <input type='text' id='piva' name='piva' >
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Indrizzo Email / Mail address</div>
                            <div class='valore'>
                                <input type='text' id='email' name='email' >
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Referente / Referent</div>
                            <div class='valore'>
                                <input type='text' id='referente' name='referente' >
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Ruolo / Role</div>
                            <div class='valore'>
                                <input type='text' id='ruolo' name='ruolo' >
                            </div>
                        </div>
                        <div class="width-50 float-left">
                            <div class='etichetta'>Indirizzo / Address</div>
                            <div class='valore'>
                                <input type='text' id='indirizzo' name='indirizzo' >
                            </div>
                        </div>
                        <div class="width-25 float-left">
                            <div class='etichetta'>Comune / City</div>
                            <div class='valore'>
                                <input type='text' id='comune' name='comune' >
                            </div>
                        </div>
                        <div class="width-25 float-left">
                            <div class='etichetta'>Provincia / State</div>
                            <div class='valore'>
                                <input type='text' id='provincia' name='provincia'>
                            </div>
                        </div>
                        <div class="etichetta">Lingua / Language</div>
                        <div class="valore">
                            <select name="lingua">
                                <option value="<%=Utente.LINGUA_IT%>">Italiano</option>
                                <option value="<%=Utente.LINGUA_EN%>">English</option>
                            </select>
                        </div>
                        <div class="height-10"></div>
                        <button class="pulsante float-right" type="button" onclick="registrati()">Registrati / Sign in </button>
                    </form>
                </div>
                <div class="clear"></div>
            </div>

            <div class="clear"></div>
        </div>
</body>
</html>
        