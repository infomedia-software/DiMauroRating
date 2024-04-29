/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import utility.Utility;

/**
 *
 * @author david
 */
public class RichiestaRiga {
   private String id;
   private String id_autore;
   private Richiesta richiesta;
   private Utente soggetto;
   private String email;
   private String oggetto;
   private String testo;
   private String note;
   private String log;
   private String upload_risposta;
   private String data_risposta;
   private String data_creazione;
   private String data_modifica;
   private String data_ultimo_invio;

   
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_autore() {
        return id_autore;
    }

    public void setId_autore(String id_autore) {
        this.id_autore = id_autore;
    }

    

    public String getTesto() {
        return testo;
    }

    public void setTesto(String testo) {
        this.testo = testo;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getData_creazione() {
        return data_creazione;
    }
    
    public String getData_it(){
        return Utility.converti_datetime_it(data_creazione);
    }

    public void setData_creazione(String data_creazione) {
        this.data_creazione = data_creazione;
    }

    public String getData_modifica() {
        return data_modifica;
    }

    public void setData_modifica(String data_modifica) {
        this.data_modifica = data_modifica;
    }

    public Richiesta getRichiesta() {
        return richiesta;
    }

    public void setRichiesta(Richiesta richiesta) {
        this.richiesta = richiesta;
    }

    public Utente getSoggetto() {
        return soggetto;
    }

    public void setSoggetto(Utente soggetto) {
        this.soggetto = soggetto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOggetto() {
        return oggetto;
    }

    public void setOggetto(String oggetto) {
        this.oggetto = oggetto;
    }

    public String getLog() {
        return log;
    }

    public void setLog(String log) {
        this.log = log;
    }

    public String getUpload_risposta() {
        return upload_risposta;
    }

    public void setUpload_risposta(String upload_risposta) {
        this.upload_risposta = upload_risposta;
    }

    public String getData_creazione_it(){
        return Utility.converti_datetime_it(data_creazione);
    }
    
    public String getData_risposta() {
        return data_risposta;
    }

    public void setData_risposta(String data_risposta) {
        this.data_risposta = data_risposta;
    }
    
    public String getData_risposta_it(){
        return Utility.converti_datetime_it(data_risposta);
    }
    
    public String getData_modifica_it(){
        return Utility.converti_datetime_it(data_modifica);
    }

    public String getData_ultimo_invio() {
        return data_ultimo_invio;
    }

    public void setData_ultimo_invio(String data_ultimo_invio) {
        this.data_ultimo_invio = data_ultimo_invio;
    }
    
    public String getData_ultimo_invio_it(){
        return Utility.converti_datetime_it(data_ultimo_invio);
    }
    
    public boolean is_risposto(){
        if(data_risposta!=null) return true;
        else return false;
    }
   
}

