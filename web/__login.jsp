<%@page import="java.util.ArrayList"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String nome_utente=Utility.elimina_null(request.getParameter("nome_utente"));
    String password=Utility.elimina_null(request.getParameter("password"));
    
    Utente utente=GestioneUtenti.getIstanza().login(nome_utente, password);
    
    if(utente!=null){
        session.setAttribute("utente", utente);
    }else{
        out.print("no");
    }
    
%>