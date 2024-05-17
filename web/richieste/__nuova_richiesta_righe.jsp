<%@page import="java.util.HashMap"%>
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
    String id_soggetti_selezionati=Utility.elimina_null(request.getParameter("id_soggetti"));
    String altre_mail=Utility.elimina_null(request.getParameter("altre_mail"));
    Map<String,String> mappa_soggetto_mail=new HashMap<String,String>();
    Map<String, ArrayList<String>> mappa_utenti_lista_mail=GestioneUtenti.getIstanza().mappa_utenti_lista_email();
    
    String id_soggetti=id_soggetti_selezionati;
    String[] temp=altre_mail.split(",");
    for(String t:temp){
        int indice_email=-1;
        String[] temp2=t.split("_");
        if(temp2.length>0){
            String id_soggetto=temp2[0];
            if(!id_soggetto.equals(""))
                id_soggetti=id_soggetto+","+id_soggetti;
            if(temp.length>1)
                indice_email=Utility.converti_string_int(temp2[1]);
            if(indice_email!=-1){
                if(mappa_soggetto_mail.get(id_soggetto)==null)
                    mappa_soggetto_mail.put(id_soggetto, mappa_utenti_lista_mail.get(id_soggetto).get(indice_email));
                else
                    mappa_soggetto_mail.put(id_soggetto, mappa_soggetto_mail.get(id_soggetto)+","+mappa_utenti_lista_mail.get(id_soggetto).get(indice_email));
            }
            
        }   
    }
    
    id_soggetti=Utility.rimuovi_ultima_occorrenza(id_soggetti, ",");
    System.out.println("mappa soggetto mail->"+mappa_soggetto_mail.toString());
    System.out.println("id_soggetti->"+id_soggetti);
    Map<String,RichiestaRiga> mappa_soggetto_richieste=GestioneRichieste.getIstanza().mappa_soggetto_richieste(id_richiesta);
    ArrayList<Utente> soggetti=GestioneUtenti.getIstanza().ricerca(" utenti.id IN ("+id_soggetti+") ");
    ArrayList<String> allegati_email=new ArrayList<String>();
    
    String query_allegati=" (allegati.rif='RICHIESTA_ALLEGATI') AND allegati.idrif="+Utility.is_null(id_richiesta)+" AND stato='1' ";
    ArrayList<Allegato> allegati_obj=GestioneAllegati.getIstanza().ricercaAllegati(query_allegati);
    
    String percorso_tomcat="C:/Users/david/Documents/NetbeansProjects/DiMauroRating/build/web/allegati/"+id_richiesta+"/";      //locale
    if(!Utility.url.contains("localhost"))
        percorso_tomcat="C:/Program Files (x86)/Apache Software Foundation/Tomcat 8.5/webapps/DiMauroRating/allegati/"+id_richiesta+"/";
    for(Allegato a:allegati_obj){
        String path=percorso_tomcat+a.getUrl();
        allegati_email.add(path);
    }
    if(!modulo.equals(""))
        allegati_email.add(percorso_tomcat+modulo);
    String allegati_file=allegati_email.toString().replaceAll(percorso_tomcat, "");
    id_soggetti_selezionati="_"+id_soggetti_selezionati.replaceAll(",", "__")+"_";
    
    for(Utente s:soggetti){
        String email_testo=testo;
        String email_invio="";
        if(id_soggetti_selezionati.contains("_"+s.getId()+"_")){
            email_invio=s.getEmail_principale();
        }
        if(mappa_soggetto_mail.get(s.getId())!=null){
            email_invio=mappa_soggetto_mail.get(s.getId())+","+email_invio;
        }
        email_invio=Utility.rimuovi_ultima_occorrenza(email_invio, ",");
        email_testo=email_testo+"<br><br>Per allegare il file controfirmato <a href='"+Utility.url+"/richieste/allega_risposta.jsp?id_richiesta="+id_richiesta+"&n="+s.getNome_utente()+"&p="+s.getPassword()+"'>Clicca Qui</a>";
        String log=Utility.converti_datetime_it(Utility.data_orario_corrente())+"<div class='box'><br>- Destinatari: "+email_invio+"<br>- Oggetto: "+oggetto+"<br>- Testo: "+email_testo+"<br>- Allegati: "+allegati_file+"<br>- Modulo: "+modulo+"</div>";
        // richiesta mai inviata al soggetto
        if(mappa_soggetto_richieste.get(s.getId())==null){
            String query_insert="INSERT INTO richieste_righe(id_autore,id_richiesta,oggetto,testo,email,id_soggetto,log,data_ultimo_invio,stato) VALUES ";
            query_insert=query_insert+"("+Utility.is_null(utente.getId())+","+Utility.is_null(id_richiesta)+","+Utility.is_null(oggetto)+","+Utility.is_null(email_testo)+","+Utility.is_null(s.getEmail())+","+Utility.is_null(s.getId())+","+Utility.is_null(log)+",NOW(),'1') ";
            Utility.getIstanza().query_insert(query_insert);
        }else{
            Utility.getIstanza().query("UPDATE richieste_righe SET log=CONCAT(log,'<br>',"+Utility.is_null(log)+"),data_ultimo_invio=NOW() WHERE id="+mappa_soggetto_richieste.get(s.getId()).getId());
        }
        ArrayList<String> destinatari=new ArrayList<String>(Arrays.asList(email_invio.split(",")));
        //Mail.invia_mail_allegati(Config.mittente_email, destinatari, oggetto, email_testo, allegati_email);
        Mail.invia_mail_allegati("Smtp6.ilger.com","","Dimauroog5392","54LKJ7j3df53fRCFa",false,false,"info@dimauroog.it", destinatari, oggetto, email_testo, allegati_email);		
    }
    
    

%>