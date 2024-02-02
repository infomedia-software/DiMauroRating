<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_domanda=Utility.elimina_null(request.getParameter("id_domanda"));
    String campo_da_modificare=Utility.elimina_null(request.getParameter("campo_da_modificare"));
    String new_valore=Utility.elimina_null(request.getParameter("new_valore"));
    GestioneQuestionari.getIstanza().modifica_domanda(id_domanda, campo_da_modificare, new_valore);
%>