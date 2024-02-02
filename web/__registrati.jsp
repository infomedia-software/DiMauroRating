<%@page import="java.util.ArrayList"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String email=Utility.elimina_null(request.getParameter("email"));
    String ragione_sociale=Utility.elimina_null(request.getParameter("ragione_sociale"));
    String piva=Utility.elimina_null(request.getParameter("piva"));
    String referente=Utility.elimina_null(request.getParameter("referente"));
    String ruolo=Utility.elimina_null(request.getParameter("ruolo"));
    String indirizzo=Utility.elimina_null(request.getParameter("indirizzo"));
    String comune=Utility.elimina_null(request.getParameter("comune"));
    String provincia=Utility.elimina_null(request.getParameter("provincia"));
    String lingua=Utility.elimina_null(request.getParameter("lingua"));
    String password="demo";
    String query="INSERT INTO utenti (email,nome_utente,password,ragione_sociale,piva,referente,ruolo,indirizzo,comune,provincia,lingua,stato) VALUES ("
            + " "+Utility.is_null(email)+","+Utility.is_null(email)+","+Utility.is_null(password)+","+Utility.is_null(ragione_sociale)+", "+Utility.is_null(piva)+","
            + " "+Utility.is_null(referente)+","+Utility.is_null(ruolo)+", "+Utility.is_null(indirizzo)+","
            + " "+Utility.is_null(comune)+","+Utility.is_null(provincia)+", "+Utility.is_null(lingua)+",'1')";
    String id_utente=Utility.getIstanza().query_insert(query);
%>