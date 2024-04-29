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
public class Richiesta {
   private String id;
   private String id_autore;
   private int numero;
   private String oggetto;
   private String testo;
   private String note;
   private String log;
   private String file_risposta;
   private String data_creazione;
   private String data_modifica;

   
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

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
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

    public String getFile_risposta() {
        return file_risposta;
    }

    public void setFile_risposta(String file_risposta) {
        this.file_risposta = file_risposta;
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
   
}

