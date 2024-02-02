
package beans;

public class Risposta {
    private String id;
    private String id_questionario_utente;
    private Domanda domanda;
    private String risposta;
    private String allegato1;
    private String allegato2;
    private String allegato3;
    private String allegato4;
    private String allegato5;
    private double valutazione;
    private String note;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_questionario_utente() {
        return id_questionario_utente;
    }

    public void setId_questionario_utente(String id_questionario_utente) {
        this.id_questionario_utente = id_questionario_utente;
    }

    
    public String getRisposta() {
        return risposta;
    }

    public void setRisposta(String risposta) {
        this.risposta = risposta;
    }

    public String getAllegato1() {
        return allegato1;
    }

    public void setAllegato1(String allegato1) {
        this.allegato1 = allegato1;
    }

    public String getAllegato2() {
        return allegato2;
    }

    public void setAllegato2(String allegato2) {
        this.allegato2 = allegato2;
    }

    public String getAllegato3() {
        return allegato3;
    }

    public void setAllegato3(String allegato3) {
        this.allegato3 = allegato3;
    }

    public String getAllegato4() {
        return allegato4;
    }

    public void setAllegato4(String allegato4) {
        this.allegato4 = allegato4;
    }

    public String getAllegato5() {
        return allegato5;
    }

    public void setAllegato5(String allegato5) {
        this.allegato5 = allegato5;
    }

    public double getValutazione() {
        return valutazione;
    }

    public void setValutazione(double valutazione) {
        this.valutazione = valutazione;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Domanda getDomanda() {
        return domanda;
    }

    public void setDomanda(Domanda domanda) {
        this.domanda = domanda;
    }
    
}
