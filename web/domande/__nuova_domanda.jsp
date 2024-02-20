<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    String id_sezione=Utility.elimina_null(request.getParameter("id_sezione"));
    String id_domanda_principale=Utility.elimina_null(request.getParameter("id_domanda_principale"));
    System.out.println("id_domanda_principale->"+id_domanda_principale);
    String id_domanda=GestioneQuestionari.getIstanza().nuova_domanda(id_questionario,id_sezione,id_domanda_principale);
    
%>