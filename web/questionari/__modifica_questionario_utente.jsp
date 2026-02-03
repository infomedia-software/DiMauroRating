<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_questionario_utente=Utility.elimina_null(request.getParameter("id_questionario_utente"));
    String campo_da_modificare=Utility.elimina_null(request.getParameter("campo_da_modificare"));
    String new_valore=Utility.elimina_null(request.getParameter("new_valore"));
    if(campo_da_modificare.contains("data") && new_valore.equals("null")){
        Utility.getIstanza().query("UPDATE questionari_utenti SET "+campo_da_modificare+"=null where id="+id_questionario_utente);
    }else{
        GestioneQuestionari.getIstanza().modifica_questionario_utente(id_questionario_utente, campo_da_modificare, new_valore);
    }
%>