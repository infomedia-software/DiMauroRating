<%@page import="utility.Utility"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="gestioneDB.DBConnection"%>
<%@page import="utility.Config"%>
<%@page import="com.opencsv.CSVReader"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<% 
    String saveFile="";
    String contentType = request.getContentType();
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
            totalBytesRead += byteRead;
        }
        
        String file = new String(dataBytes);            
        saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));

        // Crea la cartella post (se non esiste già)
        String percorso=getServletContext().getRealPath("/")+"allegati/";
        File cartella=new File(percorso);
        cartella.mkdirs();            
        
        if(saveFile.contains(" "))
            saveFile=saveFile.replaceAll(" ", "-");
        String nomeFile=saveFile;
        
        
        saveFile=percorso+"/"+saveFile;
        
        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;            
        

        String nomeFileOriginale=saveFile;
        int indice=1;
        File f = new File(saveFile);                
        while(true){
            if(f.exists()==false)
            {
                break;
            }
            else
            {                                
                String temp=nomeFileOriginale.substring(0,nomeFileOriginale.lastIndexOf("."));
                String estensione=saveFile.substring(saveFile.lastIndexOf("."),saveFile.length());
                saveFile=temp+"_"+indice+estensione;
                nomeFile=saveFile.substring(saveFile.lastIndexOf("/")+1,saveFile.length());
                nomeFile=nomeFile.replaceAll("[^\\p{ASCII}]", "");
                f=new File(saveFile);
                indice++;                
            }                
        }
             
        FileOutputStream fileOut = new FileOutputStream(f);                        
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();            
    }
    // String csvFile = "C:/Users/david/Desktop/test.csv";
    String csvFile = saveFile;
    System.out.println("csv->"+csvFile);

        try (Connection connection = DBConnection.getConnection();
            CSVReader reader = new CSVReader(new FileReader(csvFile), ';')) {
            String[] nextLine;
            reader.readNext();

            while ((nextLine = reader.readNext()) != null) {
                // Assuming codice is in column 0, ragione sociale in column 1, email in column 2
                String codice = nextLine[0];
                String ragioneSociale = nextLine[1];
                String email = nextLine[2];

                String is_presente=Utility.getIstanza().getValoreByCampo("utenti", "id", "codice="+Utility.is_null(codice));
                String cliente_fornitore="f";
                if(!codice.equals("")){
                    if(codice.toLowerCase().startsWith("f"))
                        cliente_fornitore="f";
                    if(codice.toLowerCase().startsWith("c"))
                        cliente_fornitore="c";
                }
                if(is_presente.equals(""))
                    Utility.getIstanza().query_insert("INSERT INTO utenti(codice,cliente_fornitore,ragione_sociale,email,nome_utente,password,stato)"
                            + " VALUES("
                            + " "+Utility.is_null(codice)+","+Utility.is_null(cliente_fornitore)+","+Utility.is_null(ragioneSociale)+","+Utility.is_null(email)+","+Utility.is_null(Utility.crea_password())+","+Utility.is_null(Utility.crea_password())+",'1')");
                else
                    Utility.getIstanza().query("UPDATE utenti SET ragione_sociale="+Utility.is_null(ragioneSociale)+", email="+Utility.is_null(email)+" WHERE codice="+Utility.is_null(codice));
            }
            System.out.println("Data imported successfully.");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
%>