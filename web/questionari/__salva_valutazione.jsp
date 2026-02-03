<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente"));
    String percentuale_valutazione=Utility.elimina_null(request.getParameter("percentuale_valutazione"));
    Utility.getIstanza().query("UPDATE questionari_utenti SET valutazione="+percentuale_valutazione+",data_ora_valutazione=now() WHERE id="+id_questionario_utente);
    //GestioneQuestionari.getIstanza().salva_valutazione(id_questionario_utente);
%>