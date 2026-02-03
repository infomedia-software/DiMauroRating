<%@page import="beans.Domanda"%>
<%@page import="java.util.ArrayList"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente"));
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    //Utility.getIstanza().query("DELETE FROM risposte WHERE id_questionario_utente="+id_questionario_utente);
    ArrayList<Domanda> domande=GestioneQuestionari.getIstanza().ricerca_domande(" domande.id_questionario="+id_questionario);
    if(domande.size()>0){
        String query_risposte="INSERT INTO risposte(id_questionario_utente,id_domanda,stato) VALUES ";
        for(Domanda d:domande){
            query_risposte=query_risposte+"("+Utility.is_null(id_questionario_utente)+","+Utility.is_null(d.getId())+",'1'),";
        }
        query_risposte=Utility.rimuovi_ultima_occorrenza(query_risposte, ",");
        Utility.getIstanza().query_insert(query_risposte);
    }
    
%>