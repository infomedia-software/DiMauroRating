package beans;


public class Utente {


    private String id;
    private String referente;
    private String email;
    private String nome_utente;
    private String password;
    private String ruolo;
    private String lingua;
    private String ragione_sociale;
    private String piva;
    private String indirizzo;
    private String comune;
    private String provincia;
    private String admin;
    private String note;

    public Utente() {
        this.id = id;
        this.referente = referente;
        this.email = email;
        this.nome_utente = nome_utente;
        this.password = password;
        this.ruolo = ruolo;
        this.lingua = lingua;
        
    }
    
    public static String LINGUA_IT="it";
    public static String LINGUA_EN="en";
    
    public boolean is_italiano(){
        return lingua.equals(LINGUA_IT);
    }
    public boolean is_inglese(){
        return lingua.equals(LINGUA_EN);
    }
    
    public boolean is_admin(){
        return admin.equals("si");
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPiva() {
        return piva;
    }

    public void setPiva(String piva) {
        this.piva = piva;
    }

  

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNome_utente() {
        return nome_utente;
    }

    public void setNome_utente(String nome_utente) {
        this.nome_utente = nome_utente;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRuolo() {
        return ruolo;
    }

    public void setRuolo(String ruolo) {
        this.ruolo = ruolo;
    }

    public String getReferente() {
        return referente;
    }

    public void setReferente(String referente) {
        this.referente = referente;
    }

    public String getLingua() {
        return lingua;
    }

    public void setLingua(String lingua) {
        this.lingua = lingua;
    }

    public String getRagione_sociale() {
        return ragione_sociale;
    }

    public void setRagione_sociale(String ragione_sociale) {
        this.ragione_sociale = ragione_sociale;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getComune() {
        return comune;
    }

    public void setComune(String comune) {
        this.comune = comune;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
    
    
}
