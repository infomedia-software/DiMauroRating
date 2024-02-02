package beans;

import utility.Utility;

public class Questionario {
    private String id;
    private String anno;
    private String nr;
    private String titolo_ita;
    private String titolo_eng;
    private String note;
    private String attivo;
    private String data_creazione;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAnno() {
        return anno;
    }

    public void setAnno(String anno) {
        this.anno = anno;
    }

    public String getTitolo_ita() {
        return titolo_ita;
    }

    public void setTitolo_ita(String titolo_ita) {
        this.titolo_ita = titolo_ita;
    }

    public String getTitolo_eng() {
        return titolo_eng;
    }

    public void setTitolo_eng(String titolo_eng) {
        this.titolo_eng = titolo_eng;
    }

    
    public String getData_creazione() {
        return data_creazione;
    }

    public void setData_creazione(String data_creazione) {
        this.data_creazione = data_creazione;
    }
    
    public String getData_creazione_it(){
        return Utility.converti_datetime_it(data_creazione);
    }

    public String getNr() {
        return nr;
    }

    public void setNr(String nr) {
        this.nr = nr;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getAttivo() {
        return attivo;
    }

    public void setAttivo(String attivo) {
        this.attivo = attivo;
    }
    
    public boolean is_attivo(){return attivo.equals("si");}
    
}
