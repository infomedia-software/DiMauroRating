/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestioneDB;


import beans.Utente;
import connection.ConnectionPoolException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utility.GestioneErrori;
import utility.Utility;


public class GestioneUtenti {

    private static GestioneUtenti istanza;
    
    public static GestioneUtenti getIstanza(){
        if(istanza==null)
            istanza=new GestioneUtenti();
        return istanza;
    }
    
    public Utente login(String nome_utente,String password){
        Utente utente=null;
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        try{            
            String query="SELECT * FROM utenti WHERE nome_utente="+Utility.is_null(nome_utente)+" AND password="+Utility.is_null(password)+" AND stato='1' ";         
            
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);
            while(rs.next()){
                utente=new Utente();
                utente.setId(rs.getString("id"));
                utente.setReferente(rs.getString("referente"));
                utente.setEmail(rs.getString("email"));
                utente.setId(rs.getString("id"));
                utente.setNome_utente(rs.getString("nome_utente"));
                utente.setPassword(rs.getString("password"));
                utente.setRuolo(rs.getString("ruolo"));
                utente.setNote(rs.getString("note"));
                utente.setLingua(rs.getString("lingua"));
                utente.setPiva(rs.getString("piva"));
                utente.setRagione_sociale(rs.getString("ragione_sociale"));
                utente.setIndirizzo(rs.getString("indirizzo"));
                utente.setComune(rs.getString("comune"));
                utente.setProvincia(rs.getString("provincia"));
                utente.setAdmin(rs.getString("admin"));
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "login", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "login", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return utente;
    }
    
    public ArrayList<Utente> ricerca(String query_input){
        ArrayList<Utente> toReturn=new ArrayList<Utente>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input="1";
        try{            
            String query="SELECT * FROM utenti WHERE "+query_input+" AND stato='1' ";         
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);

            while(rs.next()){
                Utente utente=new Utente();
                utente.setId(rs.getString("id"));
                utente.setReferente(rs.getString("referente"));
                utente.setEmail(rs.getString("email"));
                utente.setId(rs.getString("id"));
                utente.setNome_utente(rs.getString("nome_utente"));
                utente.setPassword(rs.getString("password"));
                utente.setRuolo(rs.getString("ruolo"));
                utente.setNote(rs.getString("note"));
                utente.setLingua(rs.getString("lingua"));
                utente.setPiva(rs.getString("piva"));
                utente.setRagione_sociale(rs.getString("ragione_sociale"));
                utente.setIndirizzo(rs.getString("indirizzo"));
                utente.setComune(rs.getString("comune"));
                utente.setProvincia(rs.getString("provincia"));
                utente.setAdmin(rs.getString("admin"));
                toReturn.add(utente);
            }                   

        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("GestioneUtenti", "ricerca", ex);
        } finally {
                DBUtility.closeQuietly(rs);
                DBUtility.closeQuietly(stmt);
                DBConnection.releaseConnection(conn);   
        }                    
        
        
        return toReturn;
    }
    
    public Utente get_utente(String id_utente){
        return ricerca(" utenti.id="+id_utente).get(0);
    }
}
