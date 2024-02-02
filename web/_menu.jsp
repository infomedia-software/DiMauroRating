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
        <button class="float-left" onclick="location.href='<%=Utility.url%>/index.jsp'" style="pointer-events: auto;">Questionari</button>
        <% if(utente.is_admin()){%>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/questionari/configura_questionari.jsp'" style="pointer-events: auto;">Configura Questionari</button>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/sezioni/sezioni.jsp'" style="pointer-events: auto;">Sezioni</button>
            <button class="float-left" onclick="location.href='<%=Utility.url%>/utenti/utenti.jsp'" style="pointer-events: auto;">Fornitori</button>
        <%}%>
        
        <button class="float-right" onclick="logout()" style="pointer-events: auto;">Esci</button>
        <div id="user">
            <img src="<%=Utility.url%>/images/man.png">
            Benvenuto <%=utente.getReferente()%>
        </div>
        
    </div>
<%}%>