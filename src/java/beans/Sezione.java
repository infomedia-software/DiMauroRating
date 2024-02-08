package beans;

public class Sezione {
    private String id;
    private int nr;
    private String id_questionario;
    private String testo_ita;
    private String testo_eng;
    private String note;

    public Sezione() {
        this.id = "";
        this.nr = 0;
        this.testo_ita = "";
        this.testo_eng = "";
        this.note = "";
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getId_questionario() {
        return id_questionario;
    }

    public void setId_questionario(String id_questionario) {
        this.id_questionario = id_questionario;
    }
    
    
    
}
