<%@page import="beans.Utente"%>
<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    Utente utente=(Utente)session.getAttribute("utente");
    String id_richiesta=GestioneRichieste.getIstanza().nuova_richiesta(utente);
    out.print(id_richiesta);
    
%>