<%@page import="gestioneDB.GestioneRichieste"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="utility.Utility"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    String id_richiesta=Utility.elimina_null(request.getParameter("id_richiesta"));
    String id_soggetto=Utility.elimina_null(request.getParameter("id_soggetto"));
    String nome_file=Utility.elimina_null(request.getParameter("nome_file"));
    Utility.getIstanza().query("UPDATE richieste_righe SET upload_risposta="+Utility.is_null(nome_file)+",data_risposta=NOW() WHERE id_richiesta="+id_richiesta+" AND id_soggetto="+id_soggetto);
%>