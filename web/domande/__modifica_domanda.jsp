<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_domanda=Utility.elimina_null(request.getParameter("id_domanda"));
    String campo_da_modificare=Utility.elimina_null(request.getParameter("campo_da_modificare"));
    String new_valore=Utility.elimina_null(request.getParameter("new_valore"));
    if(!campo_da_modificare.equals("nr") && !campo_da_modificare.equals("stato")){
        GestioneQuestionari.getIstanza().modifica_domanda(id_domanda, campo_da_modificare, new_valore);
    }
    if(campo_da_modificare.equals("nr")){           // ordinamento
        int old_valore=(int)Utility.getIstanza().getValoreByCampoDouble("domande", "nr", "id="+id_domanda);
        int new_valore_int=Utility.converti_string_int(new_valore);
        if(new_valore_int<old_valore){
            System.out.println("CASO A "+new_valore+"<"+old_valore);
            Utility.getIstanza().query("UPDATE domande SET nr=nr+1 WHERE FLOOR(nr)>="+new_valore+" AND FLOOR(nr)<="+old_valore+" AND id!="+id_domanda+" AND visibile_id!="+id_domanda);
        }
        if(new_valore_int>old_valore){
            System.out.println("CASO B "+new_valore+">"+old_valore);
            Utility.getIstanza().query("UPDATE domande SET nr=nr-1 WHERE FLOOR(nr)<="+new_valore+" AND FLOOR(nr)>="+old_valore+" AND id!="+id_domanda+" AND visibile_id!="+id_domanda);
        }
        Utility.getIstanza().query("UPDATE domande SET nr = REPLACE(CONCAT(nr), "+Utility.is_null(old_valore+".")+", "+Utility.is_null(new_valore+".")+") WHERE  id="+id_domanda+" OR visibile_id="+id_domanda);
    }
    if(campo_da_modificare.equals("stato") && new_valore.equals("-1")){     // cancellazione
        String visibile_id=Utility.getIstanza().getValoreByCampo("domande", "visibile_id", "id="+id_domanda);
        if(visibile_id.equals(""))   {   // solo se è una domanda principale
            Utility.getIstanza().query("UPDATE domande SET stato="+Utility.is_null(new_valore)+" WHERE id="+id_domanda+" OR visibile_id="+id_domanda);
            double old_valore=Utility.getIstanza().getValoreByCampoDouble("domande", "nr", "id="+id_domanda);
            Utility.getIstanza().query("UPDATE domande SET nr=nr-1 WHERE FLOOR(nr)>"+old_valore);
        }else{
            Utility.getIstanza().query("UPDATE domande SET stato="+Utility.is_null(new_valore)+" WHERE id="+id_domanda);
        }
        
    }
%>