<%@page import="utility.Utility"%>
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
        var nome_utente=$("#nome_utente").val();
        var password=$("#password_registrati").val();  
        if(password.length<6){
            alert("Scegliere una password di almeno 6 caratteri.");
            return;
        }
        if(nome_utente!=="" && password!==""){
            mostra_loader("Accesso in corso");
            $.ajax({
                type: "POST",
                url: "<%=Utility.url%>/__registrati.jsp",
                data: "nome_utente="+nome_utente+"&password="+password,
                dataType: "html",
                success: function(msg){                                                        
                    location.reload();
                },
                error: function(){
                    alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE login");
                }
            });
        }		
    }
    
     
    
    function verifica_utente(){                
        var nome_utente=$("#nome_utente").val();
        $(".campi").hide();
        mostra_loader("Verifica nome utente in corso...");
        $.ajax({
            type: "POST",
            url: "<%=Utility.url%>/__verifica_utente.jsp",
            data: "nome_utente="+nome_utente,
            dataType: "html",
            success: function(msg){
                $("#"+msg).show();
                $("#password_"+msg).focus();
                nascondi_loader();
            },
            error: function(){
                alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE verifica_utente");
            }
        });
    }
    
    function password_dimenticata(){
        var email=prompt("Inserisci l'indirizzo email per il quale recuperare la password.");
        if(email!="" && email!=null){
             mostra_loader("Operazione in corso...");
            $.ajax({
                type: "POST",
                url: "<%=Utility.url%>/__password_dimenticata.jsp",
                data: "email="+email,
                dataType: "html",
                success: function(msg){
                    if(msg.includes("errore")){
                        alert(msg);
                    }else{
                        alert("La nuova password è stata inviata a "+email);
                    }
                    location.reload();
                },
                error: function(){
                    alert("IMPOSSIBILE EFFETTUARE L'OPERAZIONE verifica_utente");
                }
            });
            
        }
    
    }
    
    $(function(){
	$("#nome_utente").focus();
        $("#form_login").keypress(function(e) {
            if($("#registrati").is(':visible')){
                if(e.which === 13) {
                    registrati();
                }
            }
            if($("#accedi").is(':visible')){
                if(e.which === 13) {
                    login();
                }
            }
	});
    });
</script>

       
<div class="box">
    <div id="div_login">

        <form id="form_login">
            <div class='etichetta'>Nome Utente / Username</div>
            <div class='valore'>
                <input type='text' id='nome_utente' name='nome_utente' placeholder="Inserisci il nome utente..." >
                <div class="height-10"></div>
            </div>
            <div id="accedi" class="campi">
                <div class='etichetta'>Password</div>
                <div class='valore'>
                    <input type='password' id='password' name='password'>
                </div>
                <button type="button" class="pulsante margin-auto" onclick="login()">Login</button>
            </div>
            <div class="height-10"></div>
            <div id="registrati" style="text-align: center;">
                <button type="button" class="pulsante color_evasa margin-auto" onclick="location.href='registrati.jsp'">Registrati / Sign in</button>
                <br/>
                <a href="#" onclick="password_dimenticata()">Password Dimenticata? Forgot Password?</a>
            </div>
            <div id="no" class="campi" style="display: none;">
                <div class='errore'>Nessun utente presente nel sistema con il nome utente inserito</div>
            </div>
        </form>
    </div>
</div>

<div class="clear"></div>
        