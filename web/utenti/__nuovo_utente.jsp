<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_utente=Utility.getIstanza().query_insert("INSERT INTO utenti(stato) VALUES('1')");
    out.println(id_utente);
%>