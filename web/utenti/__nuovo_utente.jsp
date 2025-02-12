<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    Utente utente=(Utente)session.getAttribute("utente");
    String cliente_fornitore="";
    if(utente.is_admin_richieste())
        cliente_fornitore="f";
    String id_utente=Utility.getIstanza().query_insert("INSERT INTO utenti(cliente_fornitore,stato) VALUES('"+cliente_fornitore+"','1')");
    out.println(id_utente);
%>