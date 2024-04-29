<%@page import="java.util.Map"%>
<%@page import="beans.RichiestaRiga"%>
<%@page import="beans.Allegato"%>
<%@page import="gestioneDB.GestioneAllegati"%>
<%@page import="java.util.Arrays"%>
<%@page import="utility.Config"%>
<%@page import="utility.Mail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gestioneDB.GestioneUtenti"%>
<%@page import="beans.Utente"%>
<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    Utente utente=(Utente)session.getAttribute("utente");
    String id_richiesta=Utility.elimina_null(request.getParameter("id_richiesta"));
    String oggetto=Utility.elimina_null(request.getParameter("oggetto"));
    String testo=Utility.elimina_null(request.getParameter("testo"));
    String modulo=Utility.elimina_null(request.getParameter("modulo"));
    String id_soggetti=Utility.elimina_null(request.getParameter("id_soggetti"));
    
    Map<String,RichiestaRiga> mappa_soggetto_richieste=GestioneRichieste.getIstanza().mappa_soggetto_richieste(id_richiesta);
    ArrayList<Utente> soggetti=GestioneUtenti.getIstanza().ricerca(" utenti.id IN ("+id_soggetti+") ");
    ArrayList<String> allegati_email=new ArrayList<String>();
    
    String query_allegati=" (allegati.rif='RICHIESTA_ALLEGATI') AND allegati.idrif="+Utility.is_null(id_richiesta)+" AND stato='1' ";
    ArrayList<Allegato> allegati_obj=GestioneAllegati.getIstanza().ricercaAllegati(query_allegati);
    
    String percorso_tomcat="C:/Users/david/Documents/NetbeansProjects/DiMauroRating/build/web/allegati/"+id_richiesta+"/";      //locale
    //percorso_tomcat="C:/Program Files (x86)/Apache Software Foundation/Tomcat 8.5/webapps/DiMauroRating/allegati/"+id_richiesta+"/";
    for(Allegato a:allegati_obj){
        String path=percorso_tomcat+a.getUrl();
        allegati_email.add(path);
    }
    allegati_email.add(percorso_tomcat+modulo);
    String allegati_file=allegati_email.toString().replaceAll(percorso_tomcat, "");
    
    for(Utente s:soggetti){
        String log=Utility.converti_datetime_it(Utility.data_orario_corrente())+"<div class='box'><br>- Destinatari: "+s.getEmail()+"<br>- Oggetto: "+oggetto+"<br>- Testo: "+testo+"<br>- Allegati: "+allegati_file+"<br>- Modulo: "+modulo+"</div>";
        // richiesta mai inviata al soggetto
        if(mappa_soggetto_richieste.get(s.getId())==null){
            String query_insert="INSERT INTO richieste_righe(id_autore,id_richiesta,oggetto,testo,email,id_soggetto,log,data_ultimo_invio,stato) VALUES ";
            query_insert=query_insert+"("+Utility.is_null(utente.getId())+","+Utility.is_null(id_richiesta)+","+Utility.is_null(oggetto)+","+Utility.is_null(testo)+","+Utility.is_null(s.getEmail())+","+Utility.is_null(s.getId())+","+Utility.is_null(log)+",NOW(),'1') ";
            Utility.getIstanza().query_insert(query_insert);
        }else{
            Utility.getIstanza().query("UPDATE richieste_righe SET log=CONCAT(log,'<br>',"+Utility.is_null(log)+"),data_ultimo_invio=NOW() WHERE id="+mappa_soggetto_richieste.get(s.getId()).getId());
        }
        
        testo=testo+"<br><br>Per allegare il file controfirmato <a href='"+Utility.url+"/richieste/allega_risposta.jsp?id_richiesta="+id_richiesta+"&n="+s.getNome_utente()+"&p="+s.getPassword()+"'>Clicca Qui</a>";
        
        ArrayList<String> destinatari=new ArrayList<String>(Arrays.asList(s.getEmail().split(",")));
        Mail.invia_mail_allegati(Config.mittente_email, destinatari, oggetto, testo, allegati_email);
    }
    
    

%>