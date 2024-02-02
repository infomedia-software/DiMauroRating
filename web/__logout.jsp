
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<% Utente utente=(Utente)session.getAttribute("utente"); %>
<%
    session.removeAttribute("utente");    
%>