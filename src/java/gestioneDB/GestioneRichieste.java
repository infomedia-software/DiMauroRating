package gestioneDB;

import beans.Richiesta;
import beans.RichiestaRiga;
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


public class GestioneRichieste {

    private static GestioneRichieste istanza;
    
    public static GestioneRichieste getIstanza(){
        if(istanza==null)
            istanza=new GestioneRichieste();
        return istanza;
    }
    
  
    public ArrayList<Richiesta> ricerca_richieste(String query_input){
        ArrayList<Richiesta> toReturn=new ArrayList<Richiesta>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input="1";
        try{            
            String query="SELECT * FROM richieste WHERE "+query_input+" AND stato='1' ";         
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            System.out.println("query->"+query);
            while(rs.next()){
                Richiesta r=new Richiesta();
                r.setId(rs.getString("id"));
                r.setId_autore(rs.getString("id_autore"));
                r.setNumero(rs.getInt("numero"));
                r.setOggetto(rs.getString("oggetto"));
                r.setTesto(Utility.elimina_null(rs.getString("testo")));
                r.setNote(rs.getString("note"));
                r.setLog(rs.getString("log"));
                r.setFile_risposta(rs.getString("file_risposta"));
                r.setData_creazione(rs.getString("data_creazione"));
                r.setNote(rs.getString("note"));
                toReturn.add(r);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneRichieste", "ricerca_richieste", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneRichieste", "ricerca_richieste", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    public ArrayList<RichiestaRiga> ricerca_richieste_righe(String query_input){
        ArrayList<RichiestaRiga> toReturn=new ArrayList<RichiestaRiga>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        
        try{            
            String query="SELECT * FROM richieste_righe "
                    + " LEFT OUTER JOIN richieste ON richieste_righe.id_richiesta=richieste.id "
                    + " LEFT OUTER JOIN utenti ON richieste_righe.id_soggetto=utenti.id "
                    + " WHERE richieste_righe.stato='1' ";
            if(!query_input.equals(""))
                query=query+" and "+query_input;         

            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            while(rs.next()){
                RichiestaRiga r=new RichiestaRiga();
                r.setId(rs.getString("richieste_righe.id"));
                r.setId_autore(rs.getString("richieste_righe.id_autore"));
                r.setEmail(rs.getString("richieste_righe.email"));
                r.setOggetto(rs.getString("richieste_righe.oggetto"));
                r.setTesto(Utility.elimina_null(rs.getString("richieste_righe.testo")));
                r.setNote(rs.getString("richieste_righe.note"));
                r.setLog(rs.getString("richieste_righe.log"));
                r.setData_creazione(rs.getString("richieste_righe.data_creazione"));
                r.setData_modifica(rs.getString("richieste_righe.data_modifica"));
                r.setData_ultimo_invio(rs.getString("data_ultimo_invio"));
                r.setUpload_risposta(rs.getString("upload_risposta"));
                r.setData_risposta(rs.getString("richieste_righe.data_risposta"));
                
                Richiesta richiesta=new Richiesta();
                richiesta.setId(rs.getString("richieste.id"));
                richiesta.setNumero(rs.getInt("richieste.numero"));
                richiesta.setOggetto(rs.getString("richieste.oggetto"));
                richiesta.setTesto(rs.getString("richieste.testo"));
                richiesta.setFile_risposta(rs.getString("richieste.file_risposta"));
                r.setRichiesta(richiesta);
                
                Utente soggetto=new Utente();
                soggetto.setId(rs.getString("utenti.id"));
                soggetto.setCodice(rs.getString("utenti.codice"));
                soggetto.setEmail(rs.getString("utenti.email"));
                soggetto.setRagione_sociale(rs.getString("utenti.ragione_sociale"));
                soggetto.setCliente_fornitore(rs.getString("utenti.cliente_fornitore"));
                r.setSoggetto(soggetto);
                
                toReturn.add(r);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneRichieste", "ricerca_richieste_righe", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneRichieste", "ricerca_richieste_righe", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
   
    public Richiesta get_richiesta(String id_richiesta){
        return ricerca_richieste(" richieste.id="+id_richiesta).get(0);
    }
    
    
    public String nuova_richiesta(Utente utente){
        int numero=(int)Utility.getIstanza().query_select_double("SELECT MAX(numero)+1 AS n FROM richieste WHERE stato='1'", "n");
        if(numero<=0)
            numero++;
        return Utility.getIstanza().query_insert("INSERT INTO richieste(id_autore,numero,stato)VALUES("+Utility.is_null(utente.getId())+","+numero+",'1')");
    }
    
    public String modifica_richiesta(String id_richiesta,String campo_da_modificare, String new_valore){
        return Utility.getIstanza().query("UPDATE richieste SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_richiesta);
    }
    
   
    public Map<String,RichiestaRiga> mappa_soggetto_richieste(String id_richiesta){
        Map<String,RichiestaRiga> toReturn=new HashMap<String, RichiestaRiga>();
        for(RichiestaRiga rr:ricerca_richieste_righe(" id_richiesta="+Utility.is_null(id_richiesta))){
            toReturn.put(rr.getSoggetto().getId()+"", rr);
        }
        return toReturn;
        
    }
    
    
}
