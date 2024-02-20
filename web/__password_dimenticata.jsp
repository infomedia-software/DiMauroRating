<%@page import="utility.Mail"%>
<%@page import="utility.Config"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String email=Utility.elimina_null(request.getParameter("email"));
    
    String id_utente=Utility.getIstanza().getValoreByCampo("utenti", "id", " nome_utente="+Utility.is_null(email));
    
    if(id_utente.equals("")){
        out.print("errore: nessun utente registrato con la seguente email "+email);
    }else{
        String password=Utility.crea_password();
        Utility.getIstanza().query("UPDATE utenti SET password="+Utility.is_null(password)+" WHERE id="+id_utente);
        ArrayList<String> destinatari=new ArrayList<String>();
        ArrayList<String> allegati=new ArrayList<String>();
        destinatari.add(email);
        String testo_email="Gentile fornitore,<br>Di seguito la nuova password di accesso: "+password+".<br>NB: la password potrà essere modificata nella sezione profilo in qualsiasi momento.<br>Saluti<br>Di Mauro Flexible Packaging.";
        Mail.invia_mail_allegati(Config.mittente_email, destinatari, "Recupero Password Portale Rating Fornitori - Di Mauro Flexible Packaging", testo_email,allegati);
    }
    
%>