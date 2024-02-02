package beans;

import utility.Utility;


public class Domanda {
    private String id;
    private String id_questionario;
    private Sezione sezione;
    private int nr;
    private String testo_ita;
    private String testo_eng;
    private double peso;
    private String tipo;
    private String valori;
    private String visibile_condizione;
    private String visibile_id;
    private String note;
    
    public static String tipo_TESTO="text";
    public static String tipo_NUMERO="numero";
    public static String tipo_SELECT="select";
    public static String tipo_CHECKBOX="checkbox";
    public static String tipo_ALLEGATO="allegato";
    
    public boolean is_testo(){return tipo.equals(tipo_TESTO);}
    public boolean is_numero(){return tipo.equals(tipo_NUMERO);}
    public boolean is_select(){return tipo.equals(tipo_SELECT);}
    public boolean is_checkbox(){return tipo.equals(tipo_CHECKBOX);}
    public boolean is_allegato(){return tipo.equals(tipo_ALLEGATO);}
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_questionario() {
        return id_questionario;
    }

    public void setId_questionario(String id_questionario) {
        this.id_questionario = id_questionario;
    }

    public Sezione getSezione() {
        return sezione;
    }

    public void setSezione(Sezione sezione) {
        this.sezione = sezione;
    }

    public int getNr() {
        return nr;
    }

    public void setNr(int nr) {
        this.nr = nr;
    }

    

    public String getTesto_ita() {
        return testo_ita;
    }

    public void setTesto_ita(String testo_ita) {
        this.testo_ita = testo_ita;
    }

    public String getTesto_eng() {
        return testo_eng;
    }

    public void setTesto_eng(String testo_eng) {
        this.testo_eng = testo_eng;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getVisibile_condizione() {
        return visibile_condizione;
    }

    public void setVisibile_condizione(String visibile_condizione) {
        this.visibile_condizione = visibile_condizione;
    }

    public String getVisibile_id() {
        return visibile_id;
    }

    public void setVisibile_id(String visibile_id) {
        this.visibile_id = visibile_id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getValori() {
        return valori;
    }

    public void setValori(String valori) {
        this.valori = valori;
    }
    
    
            
}
