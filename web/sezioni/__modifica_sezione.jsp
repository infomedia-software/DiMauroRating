<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_sezione=Utility.elimina_null(request.getParameter("id_sezione"));
    String campo_da_modificare=Utility.elimina_null(request.getParameter("campo_da_modificare"));
    String new_valore=Utility.elimina_null(request.getParameter("new_valore"));
    GestioneSezioni.getIstanza().modifica_sezione(id_sezione, campo_da_modificare, new_valore);
%>