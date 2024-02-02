package beans;

import utility.Utility;

public class QuestionarioUtente extends Questionario{
    private Utente utente;
    private String id_questionario;
    private double valutazione;
    private double valutazione_s1;
    private double valutazione_s2;
    private double valutazione_s3;
    private double valutazione_s4;
    private double valutazione_s5;
    private String data;
    private String data_ora_invio;
    private String data_ora_valutazione;
    private String stato;

    public static String stato_BOZZA="b";
    
    public Utente getUtente() {
        return utente;
    }

    public void setUtente(Utente utente) {
        this.utente = utente;
    }

    public double getValutazione() {
        return valutazione;
    }

    public void setValutazione(double valutazione) {
        this.valutazione = valutazione;
    }

    public double getValutazione_s1() {
        return valutazione_s1;
    }

    public void setValutazione_s1(double valutazione_s1) {
        this.valutazione_s1 = valutazione_s1;
    }

    public double getValutazione_s2() {
        return valutazione_s2;
    }

    public void setValutazione_s2(double valutazione_s2) {
        this.valutazione_s2 = valutazione_s2;
    }

    public double getValutazione_s3() {
        return valutazione_s3;
    }

    public void setValutazione_s3(double valutazione_s3) {
        this.valutazione_s3 = valutazione_s3;
    }

    public double getValutazione_s4() {
        return valutazione_s4;
    }

    public void setValutazione_s4(double valutazione_s4) {
        this.valutazione_s4 = valutazione_s4;
    }

    public double getValutazione_s5() {
        return valutazione_s5;
    }

    public void setValutazione_s5(double valutazione_s5) {
        this.valutazione_s5 = valutazione_s5;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getData_ora_invio() {
        return data_ora_invio;
    }

    public void setData_ora_invio(String data_ora_invio) {
        this.data_ora_invio = data_ora_invio;
    }

    public String getStato() {
        return stato;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }
    
    public boolean is_bozza(){
        return stato.equals(stato_BOZZA);
    }
    
    public String getData_it(){
        return Utility.converti_data_it(data);
    }
    
    public String getData_ora_invio_it(){
        return Utility.converti_datetime_it(data_ora_invio);
    }

    public String getId_questionario() {
        return id_questionario;
    }

    public void setId_questionario(String id_questionario) {
        this.id_questionario = id_questionario;
    }

    public String getData_ora_valutazione() {
        return data_ora_valutazione;
    }

    public void setData_ora_valutazione(String data_ora_valutazione) {
        this.data_ora_valutazione = data_ora_valutazione;
    }
    
    public String getData_ora_valutazione_it(){
        return Utility.converti_datetime_it(data_ora_valutazione);
    }

}
