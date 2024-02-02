<%@page import="utility.Utility"%>
<%
    String idrif=Utility.elimina_null(request.getParameter("idrif"));
    String rif=Utility.elimina_null(request.getParameter("rif"));
    String url=Utility.elimina_null(request.getParameter("url"));
    url=url.replace("\\", "/");    
    String descrizione=Utility.elimina_null(request.getParameter("descrizione"));
    
    Utility.getIstanza().query(" INSERT INTO allegati(idrif,rif,url,descrizione) VALUES(" +
             Utility.is_null(idrif)+","+
             Utility.is_null(rif)+","+
             Utility.is_null(url)+","+
             Utility.is_null(descrizione)+")");
  
    if(rif.equals("PRODOTTO_IMMAGINE")){
        Utility.getIstanza().query("UPDATE prodotti SET immagine="+Utility.is_null(url)+" WHERE id="+idrif);
    }        
%>