/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gestioneDB;


import beans.Sezione;
import connection.ConnectionPoolException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import utility.GestioneErrori;
import utility.Utility;


public class GestioneSezioni {

    private static GestioneSezioni istanza;
    
    public static GestioneSezioni getIstanza(){
        if(istanza==null)
            istanza=new GestioneSezioni();
        return istanza;
    }
    
 
    
    public ArrayList<Sezione> ricerca(String query_input){
        ArrayList<Sezione> toReturn=new ArrayList<Sezione>();
        
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        if(query_input.equals("")) query_input=" stato='1' ";
        try{            
            String query="SELECT * FROM sezioni WHERE "+query_input+" AND stato='1' ";         
            conn=DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);

            while(rs.next()){
                Sezione s=new Sezione();
                s.setId(rs.getString("id"));
                s.setNr(rs.getInt("nr"));
                s.setTesto_ita(rs.getString("testo_ita"));
                s.setTesto_eng(rs.getString("testo_eng"));
                s.setNote(rs.getString("note"));
                toReturn.add(s);
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
    
    public String nuova_sezione(){
        return Utility.getIstanza().query_insert("INSERT INTO sezioni(stato)VALUES('1')");
    }
    
    public String modifica_sezione(String id_sezione,String campo_da_modificare, String new_valore){
        return Utility.getIstanza().query("UPDATE sezioni SET "+campo_da_modificare+"="+Utility.is_null(new_valore)+" WHERE id="+id_sezione);
    }
    
}
