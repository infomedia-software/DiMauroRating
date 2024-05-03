/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utility;

import java.util.ArrayList;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 *
 * @author david
 */
public class Mail {
     public static int invia_mail(String mitt,ArrayList<String> destinatari,String oggetto,String testoEmail){
        int toReturn=-1;
        System.out.println("Mail.invia_mail:\n"
                + "Mittente: "+mitt+"\n"
                + "Destinatari: "+destinatari.toString()+"\n"
                + "Oggetto: "+oggetto+"\n"
                + "Testo: "+testoEmail+"\n");
        try {
                       
            Properties props = new Properties();
            props.put("mail.smtp.port", Utility.smtp_porta);  
            props.put("mail.smtp.host", Utility.smtp_url);     
            props.put("mail.smtp.auth", "true");            
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");     
            
     
            Session session = Session.getDefaultInstance(props,  
            new javax.mail.Authenticator() {  
            protected PasswordAuthentication getPasswordAuthentication() {  
                String email=Utility.smtp_nome_utente;                
                String password=Utility.mittente_password;
                return new PasswordAuthentication(email,password);  
               }  
             });  
            
            MimeMessage message = new MimeMessage(session);
            
            message.setSubject(oggetto);            
            String testo="";
            testo=testo+"<br>"+testoEmail;
            message.setContent(testo, "text/html; charset=utf-8");    // Invia la mail come una pagina html

            
            InternetAddress fromAddress = new InternetAddress(mitt);
            message.setFrom(fromAddress);
              
            for(String dest:destinatari){
                InternetAddress toAddress = new InternetAddress(dest);
                message.addRecipient(Message.RecipientType.TO, toAddress);
            }
            
            Transport.send(message);
            toReturn=0;
        }
        catch (MessagingException ex) {
            GestioneErrori.errore("Mail", "Errore > invioMail "+mitt+" "+destinatari.toString()+" "+oggetto+" "+testoEmail, ex);            
            return toReturn;
        }
        return toReturn;
    }
     
      
    public static  String invia_mail_allegati(String mitt,ArrayList<String> destinatari,String oggetto_mail,String testo_mail,ArrayList<String> allegati){
       
        System.out.println("invia_mail_allegati\n"
                + "mittentente =>"+mitt+"\n"
                + "destinatari =>"+destinatari.toString()+"\n"
                + "oggetto =>"+oggetto_mail+"\n"
                + "testo_mail =>"+testo_mail+"\n"
                + "allegati =>"+allegati.toString()+"\n");
        
            String errori="";
            String msg="";
            /*
            final String email="info@gestendo.it";
            final String password="Rob.Dav.1986";
            String smtp="smtps.aruba.it";
            */
            final String email=Utility.smtp_nome_utente;
            final String password=Utility.mittente_password;
            String smtp=Utility.smtp_url;
            String porta=Utility.smtp_porta;
        try {
            Properties props = new Properties();
            String ssl="si";
            props.put("mail.smtp.host", smtp);     
            props.put("mail.smtp.port", porta);            
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.debug", "true");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
            
            
            Session session2 = Session.getInstance(props,new javax.mail.Authenticator() {  
            protected PasswordAuthentication getPasswordAuthentication() {  
                
                
                return new PasswordAuthentication(email,password);  
               }  
             });  
             
            if(smtp.equals("") || email.equals("") || password.equals(""))
                errori=errori+"La configurazione dell'indirizzo email per l'invio del PDF non è corretta (Setting -> Documenti)\n";
           
            MimeMessage message = new MimeMessage(session2);
            message.setSubject(oggetto_mail);                        
            InternetAddress fromAddress = new InternetAddress(mitt);
            message.setFrom(fromAddress);
           
            // Aggiunge il testo            
            BodyPart messageBodyPart_testo = new MimeBodyPart();            
                        
            messageBodyPart_testo.setContent(testo_mail,"text/html; charset=utf-8");
            
            // Allega il file
            Multipart multipart = new MimeMultipart();  
            multipart.addBodyPart(messageBodyPart_testo);  
            if(allegati.size()>0){
                
                for(String filename:allegati){
                    DataSource source = new FileDataSource(filename);
                    MimeBodyPart messageBodyPart_allegato  = new MimeBodyPart(); 
                    messageBodyPart_allegato.setDataHandler(new DataHandler(source));
                    
                    String nome_file=filename.substring(filename.lastIndexOf("/")+1);
                    nome_file=nome_file.substring(nome_file.lastIndexOf("\\")+1);
                    messageBodyPart_allegato.setFileName(nome_file);
                    
                    
                    multipart.addBodyPart(messageBodyPart_allegato);  
                }                 
            }
            message.setContent(multipart ); 
                        
            msg="Email inviata correttamente a:\n";
    
            for(String dest:destinatari){
                InternetAddress toAddress = new InternetAddress(dest);
                message.addRecipient(Message.RecipientType.TO, toAddress);
                msg=msg+dest+"; ";
            }           
            if(errori.equals("")){                                
                Transport.send(message);                
            }else{
                msg="Impossibile inviare le e-mail! Si sono verificati i seguenti errori:\n"+errori;       
            }                        
            
        }
        catch (MessagingException ex) {
            msg=ex.toString();
            if(msg.contains("535"))
                msg=errori+"Verifica i dati di accesso (autenticazione fallita) dell'email per l'invio del PDF (Setting -> Documenti)\n";
        }  
        return msg;    
    }
     
}
