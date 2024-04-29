<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>

<%
    Utente utente=(Utente)session.getAttribute("utente");
%>

<div id='loader'>
    <div id="loader_loader"></div>
    <div id="loader_testo"></div>
</div>

<a href="<%=Utility.url%>">
    <img src="<%=Utility.url%>/images/di-mauro-flexible.png" id="logo">
</a>

	
<div id="popup_container">
    <div id="popup">                
        <div id="popup_titolo"></div>                    
        <button id="popup_chiudi" onclick="nascondi_popup()">
            <img src='<%=Utility.url%>/images/close.png'>
        </button>

        <div id="popup_contenuto"></div>                    
    </div>
</div>
       
        
<div id="popup2_container">
    <div id="popup2">                
        <div id="popup2_titolo"></div>                    
        <button id="popup2_chiudi" onclick="nascondi_popup2()">
            <img src='<%=Utility.url%>/images/close.png'>
        </button>

        <div id="popup2_contenuto"></div>                    
    </div>
</div>
        

<%if(utente!=null){%>
    <div id="menu">
        <% if(!utente.is_admin_questionari() && !utente.is_admin_richieste()){%>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/index.jsp'" style="pointer-events: auto;">Questionari</button>
        <%}%>
        <% if(utente.is_admin_questionari()){%>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/questionari/configura_questionari.jsp'" style="pointer-events: auto;">Questionari</button>
            <!--button class="float-left" onclick="location.href='<%=Utility.url%>/sezioni/sezioni.jsp'" style="pointer-events: auto;">Sezioni</button-->
            <button class="float-left" onclick="location.href='<%=Utility.url%>/utenti/utenti.jsp'" style="pointer-events: auto;">Fornitori</button>
        <%}%>
        <% if(utente.is_admin_richieste()){%>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/richieste/index.jsp'" style="pointer-events: auto;">Email</button>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/utenti/utenti.jsp'" style="pointer-events: auto;">Clienti / Fornitori</button>
        <%}%>
        
        <button class="float-right" onclick="logout()" style="pointer-events: auto;">Esci</button>
        <div id="user" style="cursor: pointer;" onclick="location.href='<%=Utility.url%>/utenti/utente.jsp?id_utente=<%=utente.getId()%>'">
            <img src="<%=Utility.url%>/images/man.png">
            Benvenuto <%=utente.getReferente()%>
        </div>
        
    </div>
<%}%>