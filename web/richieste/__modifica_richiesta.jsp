<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_richiesta=Utility.elimina_null(request.getParameter("id_richiesta"));
    String campo_da_modificare=Utility.elimina_null(request.getParameter("campo_da_modificare"));
    String new_valore=Utility.elimina_null(request.getParameter("new_valore"));
    GestioneRichieste.getIstanza().modifica_richiesta(id_richiesta, campo_da_modificare, new_valore);
%>