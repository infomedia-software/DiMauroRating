package utility;

import connection.ConnectionPoolException;
import gestioneDB.DBConnection;
import gestioneDB.DBUtility;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Utility {
    
    private static Utility istanza;
    
    public static String mittente_email=Config.mittente_email;
    public static String mittente_password=Config.mittente_password;
    public static String smtp_porta=Config.smtp_porta;
    public static String smtp_url=Config.smtp_url;
    
    
    public static Utility getIstanza(){
        if(istanza==null){
            istanza=new Utility();
            province=new ArrayList<String>();
            // Aggiunta delle sigle delle province italiane all'ArrayList
            province.add("AG"); // Agrigento
            province.add("AL"); // Alessandria
            province.add("AN"); // Ancona
            province.add("AO"); // Aosta
            province.add("AR"); // Arezzo
            province.add("AP"); // Ascoli Piceno
            province.add("AT"); // Asti
            province.add("AV"); // Avellino
            province.add("BA"); // Bari
            province.add("BT"); // Barletta-Andria-Trani
            province.add("BL"); // Belluno
            province.add("BN"); // Benevento
            province.add("BG"); // Bergamo
            province.add("BI"); // Biella
            province.add("BO"); // Bologna
            province.add("BZ"); // Bolzano
            province.add("BS"); // Brescia
            province.add("BR"); // Brindisi
            province.add("CA"); // Cagliari
            province.add("CL"); // Caltanissetta
            province.add("CB"); // Campobasso
            province.add("CI"); // Carbonia-Iglesias
            province.add("CE"); // Caserta
            province.add("CT"); // Catania
            province.add("CZ"); // Catanzaro
            province.add("CH"); // Chieti
            province.add("CO"); // Como
            province.add("CS"); // Cosenza
            province.add("CR"); // Cremona
            province.add("KR"); // Crotone
            province.add("CN"); // Cuneo
            province.add("EN"); // Enna
            province.add("FM"); // Fermo
            province.add("FE"); // Ferrara
            province.add("FI"); // Firenze
            province.add("FG"); // Foggia
            province.add("FC"); // Forlì-Cesena
            province.add("FR"); // Frosinone
            province.add("GE"); // Genova
            province.add("GO"); // Gorizia
            province.add("GR"); // Grosseto
            province.add("IM"); // Imperia
            province.add("IS"); // Isernia
            province.add("SP"); // La Spezia
            province.add("AQ"); // L'Aquila
            province.add("LT"); // Latina
            province.add("LE"); // Lecce
            province.add("LC"); // Lecco
            province.add("LI"); // Livorno
            province.add("LO"); // Lodi
            province.add("LU"); // Lucca
            province.add("MC"); // Macerata
            province.add("MN"); // Mantova
            province.add("MS"); // Massa-Carrara
            province.add("MT"); // Matera
            province.add("ME"); // Messina
            province.add("MI"); // Milano
            province.add("MO"); // Modena
            province.add("MB"); // Monza e della Brianza
            province.add("NA"); // Napoli
            province.add("NO"); // Novara
            province.add("NU"); // Nuoro
            province.add("OG"); // Ogliastra
            province.add("OT"); // Olbia-Tempio
            province.add("OR"); // Oristano
            province.add("PD"); // Padova
            province.add("PA"); // Palermo
            province.add("PR"); // Parma
            province.add("PV"); // Pavia
            province.add("PG"); // Perugia
            province.add("PU"); // Pesaro e Urbino
            province.add("PE"); // Pescara
            province.add("PC"); // Piacenza
            province.add("PI"); // Pisa
            province.add("PT"); // Pistoia
            province.add("PN"); // Pordenone
            province.add("PZ"); // Potenza
            province.add("PO"); // Prato
            province.add("RG"); // Ragusa
            province.add("RA"); // Ravenna
            province.add("RC"); // Reggio Calabria
            province.add("RE"); // Reggio Emilia
            province.add("RI"); // Rieti
            province.add("RN"); // Rimini
            province.add("RM"); // Roma
            province.add("RO"); // Rovigo
            province.add("SA"); // Salerno
            province.add("VS"); // Medio Campidano
            province.add("SS"); // Sassari
            province.add("SV"); // Savona
            province.add("SI"); // Siena
            province.add("SR"); // Siracusa
            province.add("SO"); // Sondrio
            province.add("TA"); // Taranto
            province.add("TE"); // Teramo
            province.add("TR"); // Terni
            province.add("TO"); // Torino
            province.add("TP"); // Trapani
            province.add("TN"); // Trneto
            province.add("TV"); // Treviso
            province.add("TS"); // Trieste
            province.add("UD"); // Udine
            province.add("VA"); // Varese
            province.add("VE"); // Venezia
            province.add("VB"); // Verbano
            province.add("VC"); // Vercelli
            province.add("VR"); // Verona
            province.add("VV"); // Vibo Valentia
            province.add("VI"); // Vicenza
            province.add("VT"); // Viterbo
        }
        return istanza;
    }
    
    private ArrayList<String> orari;
    
    public static String nome_software="Di Mauro";
    
    
    public static String url=Config.url;
    
    
    public static String movimento_carico="carico";
    public static String movimento_scarico="scarico";
    public static String movimento_prenotazione="prenotazione";
    public static String movimento_richiesta="richiesta";
    
    public static String img_edit=url+"/images/edit.png";
    public static String img_link=url+"/images/link.png";
    public static String img_delete=url+"/images/delete.png";
    public static String img_add=url+"/images/add.png";
    public static String img_anticipa=url+"/images/anticipa.png";
    public static String img_precedenza=url+"/images/precedenza.png";
    public static String img_lock=url+"/images/lock.png";
    public static String img_back=url+"/images/back.png";
    public static String img_up=url+"/images/up.png";
    public static String img_down=url+"/images/down.png";
    public static String img_prev=url+"/images/prev.png";
    public static String img_print=url+"/images/print.png";
    public static String img_sincro=url+"/images/sincro.png";
    public static String img_copy=url+"/images/copy.png";
    public static String img_man=url+"/images/man.png";
    public static String img_search=url+"/images/search.png";
    public static String img_search_2=url+"/images/search_2.png";
    public static String img_v=url+"/images/v.png";
    public static String img_v2=url+"/images/v2.png";
    public static String img_alert=url+"/images/alert.png";
    public static String img_man_add=url+"/images/man_add.png";
    public static String img_man_remove=url+"/images/man_remove.png";
    public static String img_logout=url+"/images/logout.png";
    public static String img_risorsa_white=url+"/images/risorsa_white.png";
    public static String img_risorsa_black=url+"/images/risorsa_black.png";
    public static String img_monitor=url+"/images/monitor.png";
    public static String img_home=url+"/images/home.png";
    public static String img_wait=url+"/images/wait.png";
    public static String img_xls=url+"/images/xls.png";
    public static String img_stop=url+"/images/stop.png";
    public static String img_start=url+"/images/start.png";
    public static String img_stack=url+"/images/stack.png";
    
    public static String img_avanti=url+"/images/avanti.png";    
    public static String img_avanti2=url+"/images/avanti2.png";    
    public static String img_indietro=url+"/images/indietro.png";    
    public static String img_indietro2=url+"/images/indietro2.png";    
    
    
    public static String privilegi_lettura="lettura";
    public static String privilegi_scrittura="scrittura";
    
    public static int numero_righe_pagine=50;
    
    public static int campi_commessa=80;
    public static int campi_prodotto=10;
    public static int campi_ubicazione=10;
    
    public static String da_definire="3001-01-01 00:00:00";
    public static ArrayList<String> province = new ArrayList<>();
    
    public static String stringa_random(){
        String lower = "abcdefghijklmnopqrstuvwxyz";
        String upper = lower.toUpperCase();
        String numeri = "0123456789";
        String perRandom = upper + lower + numeri;
        int lunghezzaRandom = 8;

        SecureRandom sr = new SecureRandom();
        StringBuilder sb = new StringBuilder(lunghezzaRandom);
        for (int i = 0; i < lunghezzaRandom; i++) {
            int randomInt = sr.nextInt(perRandom.length());
            char randomChar = perRandom.charAt(randomInt);
            sb.append(randomChar);
        }
        return sb.toString();
    }
    
    
    
    public static String verifica_privilegi(boolean privilegi){
        String toReturn="";
        if(privilegi==false)
            toReturn=" pointer-events-none";            
        return toReturn;
    }
    
    public static int ora_corrente(){
        Calendar now = Calendar.getInstance();       
        int hour = now.get(Calendar.HOUR_OF_DAY);            
        return hour;         
    }
    
     public static int minuti_corrente(){
        Calendar now = Calendar.getInstance();       
        int minuti = now.get(Calendar.MINUTE);            
        return minuti;         
    }
    
    public static int anno_corrente(){
        Calendar now = Calendar.getInstance();       
        int year = now.get(Calendar.YEAR);            
        return year;         
    }
    
    public static String genera_colore(){
        Random random = new Random();
        int nextInt = random.nextInt(0xffffff + 1);       
        String colorCode = String.format("#%06x", nextInt);
        return colorCode;
    }
    
    
    public synchronized String getValoreByCampo(String tabella,String campo,String condizione){        
        String toReturn="";
        String query="SELECT "+campo+" FROM "+tabella+" WHERE "+condizione;
        System.out.println(query);
        try{
            Connection  conn=DBConnection.getConnection();
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(query);    
            while(rs.next()){
                toReturn=rs.getString(tabella+"."+campo);
            }
            stmt.close();
            rs.close();
            DBConnection.releaseConnection(conn);
        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("Utility", "getValoreByCampo", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("Utility", "getValoreByCampo", ex);
        }       
        //System.out.println("->"+toReturn+"<-");
        return toReturn;        
    }
    
    public synchronized double getValoreByCampoDouble(String tabella,String campo,String condizione){        
        double toReturn=0;
        String query="SELECT "+campo+" FROM "+tabella+" WHERE "+condizione;
        try{
            Connection  conn=DBConnection.getConnection();
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(query);    
            while(rs.next()){
                toReturn=rs.getDouble(tabella+"."+campo);
            }
            stmt.close();
            rs.close();
            DBConnection.releaseConnection(conn);
        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("Utility", "getValoreByCampoDouble", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("Utility", "getValoreByCampoDouble", ex);
        }       
        return toReturn;
        
    }
    
    
     public synchronized String getValoreByCampo(Connection conn,String tabella,String campo,String condizione){        
        String toReturn="";
        String query="SELECT "+campo+" FROM "+tabella+" WHERE "+condizione;
        System.out.println(query);
        Statement stmt=null;
        ResultSet rs=null;
        try{            
            stmt=conn.createStatement();
            rs=stmt.executeQuery(query);    
            while(rs.next()){
                toReturn=rs.getString(tabella+"."+campo);
            }
            
        }catch (SQLException ex) {
            GestioneErrori.errore("Utility", "getValoreByCampo", ex);
        }finally{
            try {
                stmt.close();            
                rs.close();
            } catch (SQLException ex) {
                GestioneErrori.errore("Utility", "getValoreByCampo", ex);
            }
        }               
        //System.out.println("->"+toReturn+"<-");
        return toReturn;        
    }
    
    
      
    public synchronized String query(Connection conn,String query){
        String toReturn="";    
        try {                
            System.out.println("QUERY: >"+query+"<");
            DBUtility.executeOperation(conn, query);                             
        } catch (SQLException ex ) {
            GestioneErrori.errore("Utility", "query", ex);
        }
        return toReturn;
    }
    
    
    public synchronized String query(String query){
        String toReturn="";    
        try {    
            Connection conn=DBConnection.getConnection();
            System.out.println("QUERY: >"+query+"<");
            DBUtility.executeOperation(conn, query);
            DBConnection.releaseConnection(conn);                        
        } catch (ConnectionPoolException | SQLException ex ) {
            GestioneErrori.errore("Utility", "query", ex);
        }
        return toReturn;
    }
          
    public static String is_null(String pStr) {
        String tTmp;
        if (pStr == null) 
        {
                tTmp = "'null'";        
        }
        else 
        {                 
                pStr = ReplaceAllStrings(pStr, "\'", "\\'");                
                pStr = ReplaceAllStrings(pStr, "\"", "\\" + "\"");
                pStr = pStr.replaceAll("(\r\n|\n)", "<br>");
                tTmp = "'" + pStr + "'";
        }
        return tTmp;
    }
    
     public static String is_null_like(String pStr) {
        String tTmp;
        if (pStr == null) 
        {
                tTmp = "'null'";        
        }
        else 
        {                 
                pStr = ReplaceAllStrings(pStr, "\'", "\\'");                
                pStr = ReplaceAllStrings(pStr, "\"", "\\" + "\"");
                pStr = pStr.replaceAll("(\r\n|\n)", "<br>");
                tTmp="'%"+pStr+"%'";
        }
        return tTmp;
    }
    
    private static String ReplaceAllStrings(String sourceStr, String searchFor, String replaceWith) {
        StringBuffer searchBuffer = new StringBuffer(sourceStr);
        StringBuffer newStringBuffer = new StringBuffer("");

        while (searchBuffer.toString().toUpperCase().indexOf(searchFor.toUpperCase()) >= 0) {
                int newIndex = searchBuffer.toString().toUpperCase().indexOf(searchFor.toUpperCase());
                newStringBuffer.append(searchBuffer.substring(0, newIndex));
                newStringBuffer.append(replaceWith);
                searchBuffer = new StringBuffer(searchBuffer.substring(newIndex+ searchFor.length(), searchBuffer.length()));
        }
        newStringBuffer.append(searchBuffer);
        return newStringBuffer.toString();
    }
    
     
    public static String elimina_null(String stringa){
        if(stringa==null)
            return"";
        else
            return stringa;
    }
    
    
      
    public static double elimina_null_double(String stringa){
        if(stringa==null)
            return 0;
        else
            return converti_string_double(stringa);
    }
    
    public static String data_orario_corrente(){
        return oggi() +" "+orario_corrente();
    }
     
    public static String oggi(){                
        String toReturn="";
        Date data=new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
        toReturn=sdf.format(data);    
        return toReturn;        
    }
    
    public static String orario_corrente(){
        String toReturn="";
        Calendar now = Calendar.getInstance();       
        int hour = now.get(Calendar.HOUR_OF_DAY);
        int minute = now.get(Calendar.MINUTE);
        int second = now.get(Calendar.SECOND);
        if(hour>=10)
            toReturn=hour+"";
        else
            toReturn="0"+hour;        
        if(minute>=10)
            toReturn=toReturn+":"+minute+"";
        else
            toReturn=toReturn+":"+"0"+minute;
        
         if(second>=10)
            toReturn=toReturn+":"+second+"";
        else
            toReturn=toReturn+":"+"0"+second;
        return toReturn;         
    }
    
    // Arrotonda l'orario corrente per il planning 
    public static String orario_corrente_planning(){
        String toReturn="";
        
        Calendar now = Calendar.getInstance();       
        int hour = now.get(Calendar.HOUR_OF_DAY);
        int minute = now.get(Calendar.MINUTE);
                
        if(minute<30)
            minute=0;
        else
            minute=30;
        
        if(hour>=10)
            toReturn=hour+"";
        else
            toReturn="0"+hour;        
        if(minute>=10)
            toReturn=toReturn+":"+minute+"";
        else
            toReturn=toReturn+":"+"0"+minute;
                 
        return toReturn;         
    }
    
    public static String data_orario_linea_temporale(){
        String data=oggi();
        String orario=orario_corrente();
        return data_orario_planning(data+" "+orario);
    }
    
    public static String data_orario_planning(String data_orario){
        String[] temp=data_orario.split(" ");
        String data=temp[0];
        String orario=temp[1];
        String[] orario_temp=orario.split(":");
        
        String ora=orario_temp[0];
         
        String minuti=orario_temp[1];
        int minuti_int=Utility.converti_string_int(minuti);
        if(minuti_int>=0 && minuti_int<30){
            minuti="00";
        }else{
            minuti="30";
        }
            
        String toReturn=data+" "+ora+":"+minuti+":00";
        return toReturn;
    }
    
    
    public static String data_futura(String data,int days){              
        String toReturn="";
        Calendar calendar = Calendar.getInstance();
        String[] temp=data.split("-");
        calendar.set(converti_string_int(temp[0]), converti_string_int(temp[1])-1, converti_string_int(temp[2]));                
        calendar.add(Calendar.DAY_OF_YEAR, days);       
        Date tomorrow = calendar.getTime();                
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
        toReturn=sdf.format(tomorrow);       
        return toReturn;
    }    
    
    public static String data_futura_minuti(String data_ora,int minuti){              
        String toReturn="";
        Calendar calendar = Calendar.getInstance();
        String[] temp=data_ora.split(" ");
        String[] data=temp[0].split("-");
        String[] orario=temp[1].split(":");
        calendar.set(converti_string_int(data[0]), converti_string_int(data[1])-1, converti_string_int(data[2]),
                converti_string_int(orario[0]),converti_string_int(orario[1]),converti_string_int(orario[2]));                
        calendar.add(Calendar.MINUTE, minuti);       
        Date tomorrow = calendar.getTime();                
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
        toReturn=sdf.format(tomorrow);       
        return toReturn;
    }    
    
    public synchronized ArrayList<String> lista_orari(){
       if(orari==null){
            orari=new ArrayList<String>();
            orari.add("00:00");orari.add("00:30");
            orari.add("01:00");orari.add("01:30");
            orari.add("02:00");orari.add("02:30");
            orari.add("03:00");orari.add("03:30");
            orari.add("04:00");orari.add("04:30");
            orari.add("05:00");orari.add("05:30");
            orari.add("06:00");orari.add("06:30");
            orari.add("07:00");orari.add("07:30");
            orari.add("08:00");orari.add("08:30");
            orari.add("09:00");orari.add("09:30");
            orari.add("10:00");orari.add("10:30");
            orari.add("11:00");orari.add("11:30");
            orari.add("12:00");orari.add("12:30");
            orari.add("13:00");orari.add("13:30");
            orari.add("14:00");orari.add("14:30");
            orari.add("15:00");orari.add("15:30");
            orari.add("16:00");orari.add("16:30");
            orari.add("17:00");orari.add("17:30");
            orari.add("18:00");orari.add("18:30");
            orari.add("19:00");orari.add("19:30");
            orari.add("20:00");orari.add("20:30");
            orari.add("21:00");orari.add("21:30");
            orari.add("22:00");orari.add("22:30");
            orari.add("23:00");orari.add("23:30");
        }
        return orari;       
   }
    
       
    public static String elimina_zero(double durata){
        String toReturn=durata+"";
        if(toReturn.endsWith(".0"))
            toReturn=(int)durata+"";
        return toReturn;
    }
    
    public static String converti_data_it(String data){        
        if(data==null)
            return "";
        if(data.equals(""))
            return "";
        if(data.equals("3001-01-01"))
            return "";
        String toReturn="";        
        String year = "";
        String month = "";
        String day = "";
        
        String[] temp=data.split("-"); 
        int temp_day=converti_string_int(temp[2]);
        int temp_month=converti_string_int(temp[1]);
        int temp_year = converti_string_int(temp[0]);
        day = temp_day<10 ? ("0"+temp_day):(""+temp_day);
        month = temp_month<10 ? ("0"+temp_month):(""+temp_month);
        year = temp_year+"";
        toReturn=day+"/"+month+"/"+year;            
        return toReturn;
    }
    
    public static String converti_datetime_it(String datetime){        
        if(datetime==null)
            return "";
        if(datetime.equals(""))
            return "";
        if(datetime.startsWith("3001-01-01"))
            return "";
        String toReturn="";
        String[] temp=datetime.split(" ");
        String parte1=converti_data_it(temp[0]);
        toReturn=parte1+" "+temp[1].substring(0,8);
        return toReturn;
    }
    
    
    public static int converti_string_int(String daConvertire){
        int toReturn=0;
        if(daConvertire==null)
            return toReturn;
        try{
            toReturn=Integer.parseInt(daConvertire);
            return toReturn;
        }catch(NumberFormatException ex){            
            return toReturn;
        }
    }
    
    public static double converti_string_double(String daConvertire){
        double toReturn=0;
        if(daConvertire==null)
            return toReturn;
        try{
            toReturn=Double.parseDouble(daConvertire);
            return toReturn;
        }catch(NumberFormatException ex){            
            return toReturn;
        }
    }
    
    public static int calcola_indice_cella(String orario){        
        String[] orario_temp=orario.split(":");
        int ora=Utility.converti_string_int(orario_temp[0]);
        int minuti=Utility.converti_string_int(orario_temp[1]);                
        int indice_orario_inizio=0;
        indice_orario_inizio=ora*2;
        if(minuti>0)
            indice_orario_inizio++;
        if(minuti>30)
            indice_orario_inizio++;
        indice_orario_inizio=indice_orario_inizio;
        return indice_orario_inizio;
    }
    
    
    public static int calcola_indice_cella_piu_giorni(String data_iniziale,String da_controllare){
        //System.out.print("calcola_indice_cella_piu_giorni "+data_iniziale + "   "+da_controllare);
        int toReturn=0;
        String[] da_controllare_temp=da_controllare.split(" ");
        
        String data_da_controllare=da_controllare_temp[0];
        int differenza_giorni=Utility.differenza_giorni_timestamp(data_da_controllare+" 00:00:00",data_iniziale+" 00:00:00");
        //System.out.println(" differenza giorni ===>>> "+differenza_giorni);
        
        toReturn=calcola_indice_cella(da_controllare_temp[1]);
        
        if(differenza_giorni>0)
            toReturn=(48*differenza_giorni)+toReturn;
        return toReturn;
    }
    
    /**
     * @param currentTime_string
     * @param oldTime_string
     * @return 
     */
    public static int differenza_minuti_timestamp(String currentTime_string, String oldTime_string){
        java.sql.Timestamp oldTime=Utility.converti_string_timestamp(oldTime_string);
        java.sql.Timestamp currentTime=Utility.converti_string_timestamp(currentTime_string);
        long milliseconds1 = oldTime.getTime();
        long milliseconds2 = currentTime.getTime();

        long diff = milliseconds2 - milliseconds1;
        //long diffSeconds = diff / 1000;
        long diffMinutes = diff / (60 * 1000);
        //long diffHours = diff / (60 * 60 * 1000);
        //long diffDays = diff / (24 * 60 * 60 * 1000);
        return (int)diffMinutes;
    }
    
    
    /**
     * @param currentTime_string
     * @param oldTime_string
     * @return 
     */
    public static int differenza_secondi_timestamp(String currentTime_string, String oldTime_string){
        int toReturn=0;
        if(currentTime_string!=null && oldTime_string!=null){
            if(!currentTime_string.equals("") && !oldTime_string.equals("")){                
                java.sql.Timestamp oldTime=Utility.converti_string_timestamp(oldTime_string);
                java.sql.Timestamp currentTime=Utility.converti_string_timestamp(currentTime_string);
                long milliseconds1 = oldTime.getTime();
                long milliseconds2 = currentTime.getTime();

                long diff = milliseconds2 - milliseconds1;
                toReturn =(int) (diff / 1000);                
            }
        }
        return toReturn;
    }
    
    
    public static boolean viene_prima(String data_ora_0,String data_ora_1){
        boolean toReturn=false;
        //System.out.println("data0==>"+data_ora_0);
        //System.out.println("data1==>"+data_ora_1);
        java.sql.Timestamp oldTime=Utility.converti_string_timestamp(data_ora_0);
        java.sql.Timestamp currentTime=Utility.converti_string_timestamp(data_ora_1);
        long milliseconds1 = oldTime.getTime();
        long milliseconds2 = currentTime.getTime();
        long diff = milliseconds2 - milliseconds1;        
        if(diff>=0)
            toReturn=true;
        return toReturn;
    } 
       
    /**
     * @param currentTime_string
     * @param oldTime_string
     * @return 
     */
    public static int differenza_giorni_timestamp(String currentTime_string, String oldTime_string){
        //System.out.println("currentTime_string"+ currentTime_string);
        //System.out.println("oldTime_string"+  oldTime_string);
        java.sql.Timestamp oldTime=Utility.converti_string_timestamp(oldTime_string);
        java.sql.Timestamp currentTime=Utility.converti_string_timestamp(currentTime_string);
        long milliseconds1 = oldTime.getTime();
        long milliseconds2 = currentTime.getTime();
        long diff = milliseconds2 - milliseconds1;        
        long diffDays = diff / (24 * 60 * 60 * 1000);
        return (int)diffDays;
    }
    
    
    public static Timestamp converti_string_timestamp(String yourString){
        Timestamp toReturn=null;
        if(yourString.length()<16)
            yourString=yourString+":000";
        try {   
            toReturn=Timestamp.valueOf(yourString) ;
        } catch(Exception e) { 
            GestioneErrori.errore("Utility", "converti_string_timestamp", e);
        }
        return toReturn;
    }
    
    public synchronized String query_insert(Connection conn,String query){
        String toReturn="";
	Statement stmt=null;
	ResultSet keys=null;     
        System.out.println(query);
	try{             
            stmt = conn.createStatement();                        
            stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
            keys = stmt.getGeneratedKeys();    
            keys.next();  
            toReturn = ""+keys.getInt(1);            
            keys.close();
            stmt.close();   		
            DBConnection.releaseConnection(conn);

	} catch (SQLException ex) {
            GestioneErrori.errore("Utility", "query_insert", ex);
	}finally{
            try {
                keys.close();
                stmt.close();                
            } catch (SQLException ex) {                
                GestioneErrori.errore("Utility", "query_insert", ex);
            }
        }
	return toReturn;           
    }
    
    
    public synchronized String query_insert(String query){
        String toReturn="";
	Connection conn=null;
	Statement stmt=null;
	ResultSet keys=null;     
        System.out.println(query);
	try 
	{                                             
            conn=DBConnection.getConnection();
            stmt = conn.createStatement();                        
            stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);
            keys = stmt.getGeneratedKeys();    
            keys.next();  
            toReturn = ""+keys.getInt(1);            
            keys.close();
            stmt.close();   		
            DBConnection.releaseConnection(conn);

	} catch (SQLException ex) {
            GestioneErrori.errore("Utility", "query_insert", ex);
	} catch (ConnectionPoolException ex) {
            GestioneErrori.errore("Utility", "query_insert", ex);
	}        
	return toReturn;           
    }
    
    public synchronized double query_select_double(String query,String campo){            
        double toReturn=0;
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        try{                      
            conn=gestioneDB.DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);            
            while(rs.next()){                
                toReturn=rs.getDouble(campo);
            }                              
        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("Utility", "query_select_double", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("Utility", "query_select_double", ex);
        } finally {
            DBUtility.closeQuietly(rs);
            DBUtility.closeQuietly(stmt);
            DBConnection.releaseConnection(conn);
        }                    
        return toReturn;        
    }
    
    
    public synchronized String query_select(String query,String campo){            
        String toReturn="";
        Connection conn=null;
        PreparedStatement stmt=null;
        ResultSet rs=null;
        try{                   
            System.out.println(">"+query+"<");
            conn=gestioneDB.DBConnection.getConnection();            
            stmt=conn.prepareStatement(query);
            rs=stmt.executeQuery(query);            
            while(rs.next()){                
                toReturn=rs.getString(campo);
            }                              
        } catch (ConnectionPoolException ex) {
            GestioneErrori.errore("Utility", "query_select", ex);
        } catch (SQLException ex) {
            GestioneErrori.errore("Utility", "query_select", ex);
        } finally {
            DBUtility.closeQuietly(rs);
            DBUtility.closeQuietly(stmt);
            DBConnection.releaseConnection(conn);
        }                    
        return toReturn;        
    }
    


    public static synchronized String rimuovi_ultima_occorrenza(String stringa,String caratteri){
        String toReturn=stringa;
        if(stringa.contains(caratteri))
            toReturn=stringa.substring(0,stringa.lastIndexOf(caratteri));
        return toReturn;
    }
    
    public static synchronized String standardizza_textarea(String valore_campo){
        if(valore_campo==null)
            return "";
        String temp=valore_campo.replace("\\'","'");
        temp=temp.replace("€","");
        temp=temp.replace("//","/");
        return temp.replaceAll("<br>", "\n");
    }
    
            
     public static String giorno_settimana(String yourDate){
        String toReturn="";
        SimpleDateFormat format1=new SimpleDateFormat("yyyy-MM-dd");
        int dayOfWeek=-1;        
        try {
            Date dt1= format1.parse(yourDate);                    
            Calendar c = Calendar.getInstance();
            c.setTime(dt1);
            dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            if(dayOfWeek==1)
                toReturn="dom";
            if(dayOfWeek==2)
                toReturn="lun";
            if(dayOfWeek==3)
                toReturn="mar";
            if(dayOfWeek==4)
                toReturn="mer";
            if(dayOfWeek==5)
                toReturn="gio";
            if(dayOfWeek==6)
                toReturn="ven";
            if(dayOfWeek==7)
                toReturn="sab";            
        } catch (ParseException ex) {
            GestioneErrori.errore("Utility", "giorno_settimana", ex);
        }
        return toReturn;
    }
    
    public static double arrotonda_double(double numero,int nCifreDecimali){
        return Math.round( numero * Math.pow( 10, nCifreDecimali ) )/Math.pow( 10, nCifreDecimali );
    }
     
    public static String formatta_prezzo(double prezzo){    
        double prezzo_arrotondato=Utility.arrotonda_double(prezzo, 2);
        DecimalFormat df = new DecimalFormat("#,##0.00");
        df.setDecimalFormatSymbols(new DecimalFormatSymbols(Locale.ITALY));
        return df.format(prezzo_arrotondato);
    }

    
     /**
     * Metodo che prende in input i minuti e ritorna il valore hh:mm:ss
     * @param takttime durata da convertire
     * @return 
     *     durata in formato hh:mm:ss
     */
    public static String formatta_minuti(double minuti){
        minuti=minuti/60;
        String toReturn="";
        int hours = (int) minuti;
        int minutes = (int) (minuti * 60) % 60;
        int seconds = (int) (minuti * (60*60)) % 60;
        String h=""+hours;
        String m=""+minutes;
        String s=""+seconds;
        if(hours<10)
            h="0"+h;
        if(minutes<10)
            m="0"+m;
        if(seconds<10)
            s="0"+s;        
        toReturn=String.format("%s:%s:%s", h, m, s);
        return toReturn;
    }
    
    
     /**
     * Metodo che prende in input i minuti e ritorna il valore hh:mm:ss
     * @param takttime durata da convertire
     * @return 
     *     durata in formato hh:mm:ss
     */
    public static String formatta_secondi(double minuti){
        minuti=minuti/3600;
        String toReturn="";
        int hours = (int) minuti;
        int minutes = (int) (minuti * 60) % 60;
        int seconds = (int) (minuti * (60*60)) % 60;
        String h=""+hours;
        String m=""+minutes;
        String s=""+seconds;
        if(hours<10)
            h="0"+h;
        if(minutes<10)
            m="0"+m;
        if(seconds<10)
            s="0"+s;        
        toReturn=String.format("%s:%s:%s", h, m, s);
        return toReturn;
    }
    
    
    /**
     * Metodo che ritorna l'orario 
     * @param data_ora_inizio_task
     * @return 
     */
    public static String calcola_inizio_attivita_da_task(String data_ora_inizio_task){
        String toReturn="";
        
        String[] temp=data_ora_inizio_task.split(" ");
        String[] temp2=temp[1].split(":");
        
        String hh=temp2[0];
        int hh_int=Utility.converti_string_int(hh);
        String hh_string=hh_int+"";
        if(hh_int<10)
            hh_string="0"+hh_string;
        
        String mm=temp2[1];
        String mm_string="";
        int mm_int=Utility.converti_string_int(mm);
        if(mm_int>=0 && mm_int<30){
            mm_string="00";            
        }
        if(mm_int>=30){
            mm_string="30";            
        }
        
        
        toReturn=temp[0]+" "+hh_string+":"+mm_string+":00";
        
        
        return toReturn;        
    }
    
    public static double trasforma_secondi_ore(double secondi){
        double toReturn=0;
        double temp=secondi/3600;
        int parte_intera=(int)temp;
        double parte_decimale=temp-parte_intera;
        if(parte_decimale==0)
            toReturn=parte_intera;        
        if(parte_decimale>0 && parte_decimale<=0.5){
            toReturn=parte_intera+0.5;
        }
        if(parte_decimale>0.5){
            toReturn=parte_intera+1;
        }
        
        
        return toReturn;
        
    }
    
    public static String movimento_carico_scarico(String input){
        String toReturn="";
        if(input.equals("ddt"))
            toReturn="scarico";
        if(input.equals("ddt_fornitore"))
            toReturn="carico";   
        return toReturn;        
    }
    
    
    public static double calcola_totale(double qta,double prezzo,double aliquota,double sconto1,double sconto2,double sconto3){
        double toReturn=qta*prezzo*(100+aliquota)/100*(100-sconto1)/100*(100-sconto2)/100*(100-sconto3)/100;            
        return toReturn;
    }
    

}
