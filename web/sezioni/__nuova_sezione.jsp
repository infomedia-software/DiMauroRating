<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    String id_sezione=GestioneSezioni.getIstanza().nuova_sezione(id_questionario);
%>