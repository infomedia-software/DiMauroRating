<%@page import="utility.Config"%>
<%@page import="utility.Mail"%>
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
    String password=Utility.crea_password();
    
    String is_presente=Utility.getIstanza().getValoreByCampo("utenti","id","piva="+Utility.is_null(piva)+" AND stato='1'");
    if(!is_presente.equals("")){
        out.print("errore: Impossibile procedere, p.iva / cf già presente.");
        return;
    }
    
    String query="INSERT INTO utenti (email,nome_utente,password,ragione_sociale,piva,referente,ruolo,indirizzo,comune,provincia,lingua,stato) VALUES ("
            + " "+Utility.is_null(email)+","+Utility.is_null(email)+","+Utility.is_null(password)+","+Utility.is_null(ragione_sociale)+", "+Utility.is_null(piva)+","
            + " "+Utility.is_null(referente)+","+Utility.is_null(ruolo)+", "+Utility.is_null(indirizzo)+","
            + " "+Utility.is_null(comune)+","+Utility.is_null(provincia)+", "+Utility.is_null(lingua)+",'1')";
    String id_utente=Utility.getIstanza().query_insert(query);
    ArrayList<String> destinatari=new ArrayList<String>();
    ArrayList<String> allegati=new ArrayList<String>();
    destinatari.add(email);
    String testo_email="Gentile "+referente+",<br>grazie per esserti registrato al portale Rating Fornitori Di Mauro Flexible Packaging.<br>Di seguito la password di accesso: "+password+".<br>NB: la password potrà essere modificata nella sezione profilo in qualsiasi momento.<br>Saluti<br>Di Mauro Flexible Packaging.";
    if(lingua.equals(Utente.LINGUA_EN)){
        testo_email="Dear "+referente+"<br>,Thank you for registering on the Di Mauro Flexible Packaging Supplier Rating portal.<br>Below is the login password: "+password+".<br>NB: the password can be changed in the profile section at any time.<br>Greetings<br>By Mauro Flexible Packaging.";
    }
    Mail.invia_mail_allegati(Config.mittente_email, destinatari, "Registrazione Portale Rating Fornitori - Di Mauro Flexible Packaging", testo_email,allegati);
%>