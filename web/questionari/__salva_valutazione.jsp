<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente"));
    GestioneQuestionari.getIstanza().salva_valutazione(id_questionario_utente);
%>