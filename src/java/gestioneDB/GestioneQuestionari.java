/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestioneDB;


import beans.Domanda;
import beans.Questionario;
import beans.QuestionarioUtente;
import beans.Risposta;
import beans.Sezione;
import beans.Utente;
import connection.ConnectionPoolException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import utility.GestioneErrori;
import utility.Utility;


public class GestioneQuestionari {

    private static GestioneQuestionari istanza;
    
    public static GestioneQuestionari getIstanza(){
        if(istanza==null)
            istanza=new GestioneQuestionari();
        return istanza;
    }
    
  
    public ArrayList<Questionario> ricerca_questionari(String query_input){
        ArrayList<Questionario> toReturn=new ArrayList<Questionario>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input="1";
        try{            
            String query="SELECT * FROM questionari WHERE "+query_input+" AND stato='1' ";         
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            System.out.println("query->"+query);
            while(rs.next()){
                Questionario q=new Questionario();
                q.setId(rs.getString("id"));
                q.setAnno(rs.getString("anno"));
                q.setNr(rs.getString("nr"));
                q.setAttivo(rs.getString("attivo"));
                q.setTitolo_ita(rs.getString("titolo_ita"));
                q.setTitolo_eng(rs.getString("titolo_eng"));
                q.setData_creazione(rs.getString("data_creazione"));
                q.setNote(rs.getString("note"));
                
                toReturn.add(q);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    public ArrayList<QuestionarioUtente> ricerca_questionari_utenti(Utente utente){
        ArrayList<QuestionarioUtente> toReturn=new ArrayList<QuestionarioUtente>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
            String query="SELECT * FROM questionari "
                    + " LEFT OUTER JOIN questionari_utenti ON questionari.id=questionari_utenti.id_questionario "
                    + " LEFT OUTER JOIN utenti ON questionari_utenti.id_utente=utenti.id WHERE ";
                    if(!utente.is_admin())
                        query=query+"  id_utente="+Utility.is_null(utente.getId())+" ";         
                    else
                        query=query+"  id_utente IS NOT NULL ";         
            System.out.println("query->"+query);
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            while(rs.next()){
                QuestionarioUtente q=new QuestionarioUtente();
                // questionari
                q.setId_questionario(rs.getString("questionari.id"));
                q.setAttivo(rs.getString("questionari.attivo"));
                q.setTitolo_ita(rs.getString("questionari.titolo_ita"));
                q.setTitolo_eng(rs.getString("questionari.titolo_eng"));
                q.setData_creazione(rs.getString("questionari.data_creazione"));
                q.setAnno(rs.getString("questionari.anno"));
                q.setNr(rs.getString("questionari.nr"));
                
                // questionari utenti
                q.setId(rs.getString("questionari_utenti.id"));
                q.setData(rs.getString("questionari_utenti.data"));
                q.setValutazione(rs.getDouble("questionari_utenti.valutazione"));
                q.setValutazione_s1(rs.getDouble("questionari_utenti.valutazione_s1"));
                q.setValutazione_s2(rs.getDouble("questionari_utenti.valutazione_s2"));
                q.setValutazione_s3(rs.getDouble("questionari_utenti.valutazione_s3"));
                q.setValutazione_s4(rs.getDouble("questionari_utenti.valutazione_s4"));
                q.setValutazione_s5(rs.getDouble("questionari_utenti.valutazione_s5"));
                q.setData_ora_invio(rs.getString("questionari_utenti.data_ora_invio"));
                q.setData_ora_valutazione(rs.getString("questionari_utenti.data_ora_valutazione"));
                q.setNote(rs.getString("questionari_utenti.note"));
                q.setStato(rs.getString("questionari_utenti.stato"));
                
                // utente
                Utente u=new Utente();
                u.setId(rs.getString("utenti.id"));
                u.setRagione_sociale(rs.getString("utenti.ragione_sociale"));
                u.setLingua(rs.getString("utenti.lingua"));
                q.setUtente(u);
                
                toReturn.add(q);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
     
    public ArrayList<QuestionarioUtente> ricerca_questionari_utenti_id_questionario(String id_questionario){
        ArrayList<QuestionarioUtente> toReturn=new ArrayList<QuestionarioUtente>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
            String query="SELECT * FROM questionari "
                    + " LEFT OUTER JOIN questionari_utenti ON questionari.id=questionari_utenti.id_questionario "
                    + " LEFT OUTER JOIN utenti ON questionari_utenti.id_utente=utenti.id WHERE id_questionario="+id_questionario;
            
            
            System.out.println("query->"+query);
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            while(rs.next()){
                QuestionarioUtente q=new QuestionarioUtente();
                // questionari
                q.setId_questionario(rs.getString("questionari.id"));
                q.setAttivo(rs.getString("questionari.attivo"));
                q.setTitolo_ita(rs.getString("questionari.titolo_ita"));
                q.setTitolo_eng(rs.getString("questionari.titolo_eng"));
                q.setData_creazione(rs.getString("questionari.data_creazione"));
                q.setAnno(rs.getString("questionari.anno"));
                q.setNr(rs.getString("questionari.nr"));
                
                // questionari utenti
                q.setId(rs.getString("questionari_utenti.id"));
                q.setData(rs.getString("questionari_utenti.data"));
                q.setValutazione(rs.getDouble("questionari_utenti.valutazione"));
                q.setValutazione_s1(rs.getDouble("questionari_utenti.valutazione_s1"));
                q.setValutazione_s2(rs.getDouble("questionari_utenti.valutazione_s2"));
                q.setValutazione_s3(rs.getDouble("questionari_utenti.valutazione_s3"));
                q.setValutazione_s4(rs.getDouble("questionari_utenti.valutazione_s4"));
                q.setValutazione_s5(rs.getDouble("questionari_utenti.valutazione_s5"));
                q.setData_ora_invio(rs.getString("questionari_utenti.data_ora_invio"));
                q.setData_ora_valutazione(rs.getString("questionari_utenti.data_ora_valutazione"));
                q.setNote(rs.getString("questionari_utenti.note"));
                q.setStato(rs.getString("questionari_utenti.stato"));
                
                // utente
                Utente u=new Utente();
                u.setId(rs.getString("utenti.id"));
                u.setRagione_sociale(rs.getString("utenti.ragione_sociale"));
                u.setLingua(rs.getString("utenti.lingua"));
                q.setUtente(u);
                
                toReturn.add(q);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti_id_questionario", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti_id_questionario", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    
     public ArrayList<Domanda> ricerca_domande(String query_input){
        ArrayList<Domanda> toReturn=new ArrayList<Domanda>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input="1";
        try{            
            String query="SELECT * FROM domande"
                    + " LEFT OUTER JOIN sezioni ON domande.id_sezione=sezioni.id "
                    + " WHERE "+query_input+" AND domande.stato='1' ORDER BY sezioni.nr ASC, domande.nr ASC ";    
            System.out.println("query->"+query);
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);

            while(rs.next()){
                Domanda d=new Domanda();
                d.setId(rs.getString("domande.id"));
                d.setId_questionario(rs.getString("domande.id_questionario"));
                d.setNr(rs.getInt("domande.nr"));
                d.setTesto_ita(rs.getString("domande.testo_ita"));
                d.setTesto_eng(rs.getString("domande.testo_eng"));
                d.setPeso(rs.getDouble("peso"));
                d.setVisibile_condizione(rs.getString("visibile_condizione"));
                d.setVisibile_id(rs.getString("visibile_id"));
                d.setTipo(rs.getString("tipo"));
                d.setValori(rs.getString("valori"));
                d.setNote(rs.getString("domande.note"));
                Sezione sezione=new Sezione();
                    sezione.setId(Utility.elimina_null(rs.getString("sezioni.id")));
                    sezione.setNr(rs.getInt("sezioni.nr"));
                    sezione.setTesto_ita(rs.getString("sezioni.testo_ita"));
                    sezione.setTesto_eng(rs.getString("sezioni.testo_eng"));
                    sezione.setNote(rs.getString("sezioni.note"));
                    d.setSezione(sezione);
                toReturn.add(d);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_domande", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_domande", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
     
    public ArrayList<Risposta> ricerca_risposte(String query_input){
        ArrayList<Risposta> toReturn=new ArrayList<Risposta>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input="1";
        try{            
            String query="SELECT * FROM risposte "
                    + " LEFT OUTER JOIN domande ON risposte.id_domanda=domande.id "
                    + " LEFT OUTER JOIN sezioni ON domande.id_sezione=sezioni.id "
                    + " WHERE "+query_input+" "
                    + " AND risposte.stato='1' ORDER BY sezioni.nr ASC,domande.nr ASC ";  
            System.out.println("query->"+query);
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);

            while(rs.next()){
                Risposta r=new Risposta();
                r.setId(rs.getString("risposte.id"));
                r.setId_questionario_utente(rs.getString("id_questionario_utente"));
                
                String id_domanda=rs.getString("id_domanda");
                Domanda d=new Domanda();
                if(!id_domanda.equals("")){
                    d.setId(id_domanda);
                    d.setNr(rs.getInt("nr"));
                    d.setTesto_ita(rs.getString("testo_ita"));
                    d.setTesto_eng(rs.getString("testo_eng"));
                    d.setPeso(rs.getDouble("peso"));
                    d.setTipo(rs.getString("tipo"));
                    d.setValori(rs.getString("valori"));
                    d.setVisibile_condizione(rs.getString("visibile_condizione"));
                    d.setVisibile_id(rs.getString("visibile_id"));
                    
                    Sezione sezione=new Sezione();
                        sezione.setId(rs.getString("sezioni.id"));
                        sezione.setNr(rs.getInt("sezioni.nr"));
                        sezione.setTesto_ita(rs.getString("sezioni.testo_ita"));
                        sezione.setTesto_eng(rs.getString("sezioni.testo_eng"));
                        sezione.setNote(rs.getString("sezioni.note"));
                        d.setSezione(sezione);
                }
                r.setDomanda(d);
                r.setRisposta(rs.getString("risposta"));
                r.setAllegato1(rs.getString("allegato1"));
                r.setAllegato2(rs.getString("allegato2"));
                r.setAllegato3(rs.getString("allegato3"));
                r.setAllegato4(rs.getString("allegato4"));
                r.setAllegato5(rs.getString("allegato5"));
                r.setValutazione(rs.getDouble("valutazione"));
                r.setNote(rs.getString("risposte.note"));
                toReturn.add(r);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_risposte", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_risposte", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    public String nuovo_questionario_utente(String id_questionario,String id_utente){
        String id_questionario_utente=Utility.getIstanza().query_insert("INSERT INTO questionari_utenti (id_utente,id_questionario,data,stato) "
            + " VALUES ("+Utility.is_null(id_utente)+","+Utility.is_null(id_questionario)+",DATE(NOW()),'b')");
        ArrayList<Domanda> domande=ricerca_domande(" domande.id_questionario="+id_questionario);
        if(domande.size()>0){
            String query_risposte="INSERT INTO risposte(id_questionario_utente,id_domanda,stato) VALUES ";
            for(Domanda d:domande){
                query_risposte=query_risposte+"("+Utility.is_null(id_questionario_utente)+","+Utility.is_null(d.getId())+",'1'),";
            }
            query_risposte=Utility.rimuovi_ultima_occorrenza(query_risposte, ",");
            Utility.getIstanza().query_insert(query_risposte);
        }
        return id_questionario_utente;
    }
    
    public Questionario get_questionario(String id_questionario){
        return ricerca_questionari(" questionari.id="+id_questionario).get(0);
    }
    public QuestionarioUtente get_questionario_utente(String id_questionario_utente){
        QuestionarioUtente q=new QuestionarioUtente();
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
            String query="SELECT * FROM questionari "
                    + " LEFT OUTER JOIN questionari_utenti ON questionari.id=questionari_utenti.id_questionario "
                    + " LEFT OUTER JOIN utenti ON questionari_utenti.id_utente=utenti.id WHERE "
                    + " questionari_utenti.id="+id_questionario_utente;         
            System.out.println("query->"+query);
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            while(rs.next()){
                
                // questionari
                q.setId_questionario(rs.getString("questionari.id"));
                q.setAttivo(rs.getString("questionari.attivo"));
                q.setTitolo_ita(rs.getString("questionari.titolo_ita"));
                q.setTitolo_eng(rs.getString("questionari.titolo_eng"));
                q.setData_creazione(rs.getString("questionari.data_creazione"));
                q.setAnno(rs.getString("questionari.anno"));
                q.setNr(rs.getString("questionari.nr"));
                
                // questionari utenti
                q.setId(rs.getString("questionari_utenti.id"));
                q.setData(rs.getString("questionari_utenti.data"));
                q.setValutazione(rs.getDouble("questionari_utenti.valutazione"));
                q.setValutazione_s1(rs.getDouble("questionari_utenti.valutazione_s1"));
                q.setValutazione_s2(rs.getDouble("questionari_utenti.valutazione_s2"));
                q.setValutazione_s3(rs.getDouble("questionari_utenti.valutazione_s3"));
                q.setValutazione_s4(rs.getDouble("questionari_utenti.valutazione_s4"));
                q.setValutazione_s5(rs.getDouble("questionari_utenti.valutazione_s5"));
                q.setData_ora_invio(rs.getString("questionari_utenti.data_ora_invio"));
                q.setData_ora_valutazione(rs.getString("questionari_utenti.data_ora_valutazione"));
                q.setNote(rs.getString("questionari_utenti.note"));
                q.setStato(rs.getString("questionari_utenti.stato"));
                
                 // utente
                Utente utente=new Utente();
                utente.setId(rs.getString("utenti.id"));
                utente.setRagione_sociale(rs.getString("utenti.ragione_sociale"));
                utente.setLingua(rs.getString("utenti.lingua"));
                q.setUtente(utente);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca_questionari_utenti", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return q;
    }
    
    public ArrayList<Risposta> get_risposte_questionario_utente(String id_questionario_utente){
        return ricerca_risposte(" id_questionario_utente="+id_questionario_utente);
    }
    
    public String nuovo_questionario(){
        return Utility.getIstanza().query_insert("INSERT INTO questionari(anno,stato)VALUES(YEAR(NOW()),'1')");
    }
    
    public String modifica_questionario(String id_questionario,String campo_da_modificare, String new_valore){
        return Utility.getIstanza().query("UPDATE questionari SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_questionario);
    }
    
    public String nuova_domanda(String id_questionario,String id_sezione,String visibile_id){
        double nr=0;
        if(!visibile_id.equals(""))
            nr=Utility.getIstanza().getValoreByCampoDouble("domande", "nr", "id="+visibile_id)+0.01;
        else
            nr=Utility.getIstanza().query_select_double("SELECT MAX(FLOOR(nr))+1 as nr FROM domande WHERE id_sezione='"+id_sezione+"' AND id_questionario='"+id_questionario+"' AND stato='1'", "nr");
        if(nr==0)
            nr=1;
        return Utility.getIstanza().query_insert("INSERT INTO domande(id_questionario,id_sezione,visibile_id,nr,tipo,stato) "
                + "VALUES "
                + "("+Utility.is_null(id_questionario)+","+Utility.is_null(id_sezione)+","+Utility.is_null(visibile_id)+","+nr+","+Utility.is_null(Domanda.tipo_TESTO)+",'1')");
    }
    
    public String modifica_domanda(String id_domanda,String campo_da_modificare, String new_valore){
        return Utility.getIstanza().query("UPDATE domande SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_domanda);
    }
    
    public String modifica_risposta(String id_risposta,String campo_da_modificare, String new_valore){
        Utility.getIstanza().query("UPDATE risposte SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_risposta);
        if(campo_da_modificare.equals("risposta")){
            String id_domanda=Utility.getIstanza().getValoreByCampo("risposte", "id_domanda", "id="+id_risposta);
            String id_incidenza=Utility.getIstanza().getValoreByCampo("domande", "id", "visibile_id="+id_domanda);
            if(!id_incidenza.equals("")){
                System.out.println("id_incidenza-->"+id_incidenza);
                System.out.println("id_domanda-->"+id_domanda);
                String id_questionario_utente=Utility.getIstanza().getValoreByCampo("risposte", "id_questionario_utente", "id="+id_risposta);
                String visibile_condizione=Utility.getIstanza().getValoreByCampo("domande", "visibile_condizione", "id="+id_incidenza);
                System.out.println("visibile_condizione-->"+visibile_condizione);
                System.out.println("id_questionario_utente-->"+id_questionario_utente);
                Map<String,String> mappa_domande_risposte=mappa_id_domande_risposte(id_questionario_utente);
                System.out.println("mappa:"+mappa_domande_risposte.toString());
                if(mappa_domande_risposte.get(id_domanda)!=null){
                if(!mappa_domande_risposte.get(id_domanda).equals(visibile_condizione))
                    Utility.getIstanza().query("UPDATE risposte SET risposta='' WHERE id_domanda="+id_incidenza+" and id_questionario_utente="+id_questionario_utente);
                }else{
                    System.out.println("mappa è null");
                }
            }
        }
        return "";
    }
    
    public Map<String,String> mappa_id_domande_risposte(String id_questionario_utente){
        Map<String,String> toReturn=new HashMap<String,String>();
        for(Risposta r:ricerca_risposte(" risposte.id_questionario_utente="+id_questionario_utente)){
            toReturn.put(r.getDomanda().getId(),r.getRisposta());
        }
        return toReturn;
    }
      
    public String modifica_questionario_utente(String id_questionario_utente,String campo_da_modificare, String new_valore){
        Utility.getIstanza().query("UPDATE questionari_utenti SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_questionario_utente);
        if(campo_da_modificare.equals("stato") && new_valore.equals("1"))
            Utility.getIstanza().query("UPDATE questionari_utenti SET data_ora_invio=NOW() WHERE id="+id_questionario_utente);
        if(campo_da_modificare.equals("stato") && new_valore.equals("b"))
            Utility.getIstanza().query("UPDATE questionari_utenti SET data_ora_invio=null WHERE id="+id_questionario_utente);
        if(campo_da_modificare.equals("valutazione") && new_valore.equals("0"))
            Utility.getIstanza().query("UPDATE questionari_utenti SET data_ora_valutazione=null WHERE id="+id_questionario_utente);
        return "";
    }
    
    
    public String salva_valutazione(String id_questionario_utente){
        Utility.getIstanza().query("UPDATE questionari_utenti SET data_ora_valutazione=NOW() WHERE id="+id_questionario_utente);
        // aggiorna valutazione totale del questionario utente
        String query="UPDATE questionari_utenti SET valutazione = ( "
                + " SELECT SUM(risposte.valutazione * domande.peso) AS tot "
                + " FROM risposte LEFT OUTER JOIN domande ON risposte.id_domanda = domande.id "
                + " WHERE risposte.id_questionario_utente = "+id_questionario_utente+" ) WHERE id = "+id_questionario_utente;
        Utility.getIstanza().query(query);
        return "";
    }
    
    public Map<String,Double> mappa_valutazioni_sezioni(String id_questionario_utente){
        Map<String,Double> toReturn=new HashMap<String,Double>();
        String query=" SELECT id_sezione,SUM(valutazione*peso) AS tot_sez FROM  risposte LEFT OUTER JOIN domande ON risposte.id_domanda=domande.id WHERE id_questionario_utente="+Utility.is_null(id_questionario_utente)+" GROUP BY domande.id_sezione";
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
        
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            System.out.println("query->"+query);
            while(rs.next()){
                toReturn.put(rs.getString("id_sezione"), rs.getDouble("tot_sez"));
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_sezioni", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_sezioni", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    public Map<String,Double> mappa_valutazioni_massime_sezioni(String id_questionario_utente){
        Map<String,Double> toReturn=new HashMap<String,Double>();
        String query=" SELECT id_sezione,SUM(10*peso) AS tot_sez FROM  risposte LEFT OUTER JOIN domande ON risposte.id_domanda=domande.id WHERE id_questionario_utente="+Utility.is_null(id_questionario_utente)+" GROUP BY domande.id_sezione";
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
        
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            System.out.println("query->"+query);
            while(rs.next()){
                toReturn.put(rs.getString("id_sezione"), rs.getDouble("tot_sez"));
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_massime_sezioni", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_massime_sezioni", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
      public Map<String,Double> mappa_valutazioni_massime_questionari_utenti(String id_questionario){
        Map<String,Double> toReturn=new HashMap<String,Double>();
        String query=" SELECT id_utente, SUM(10*peso) AS valutazione_massima " +
                "FROM risposte " +
                "LEFT OUTER " +
                "JOIN domande ON risposte.id_domanda=domande.id " +
                "LEFT OUTER " +
                "JOIN questionari_utenti ON risposte.id_questionario_utente=questionari_utenti.id " +
                "WHERE questionari_utenti.id_questionario='"+id_questionario+"' GROUP BY questionari_utenti.id_utente";
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
        
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            System.out.println("query->"+query);
            while(rs.next()){
                toReturn.put(rs.getString("id_utente"), rs.getDouble("valutazione_massima"));
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_massime_questionari_utenti", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "mappa_valutazioni_massime_questionari_utenti", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
}
