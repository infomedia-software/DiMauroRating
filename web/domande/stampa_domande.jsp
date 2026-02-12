<%@page import="java.util.ArrayList"%>
<%@page import="beans.Domanda"%>
<%@page import="beans.Questionario"%>
<%@page import="gestioneDB.GestioneQuestionari"%>
<%@page import="beans.Sezione"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Utente utente=(Utente)session.getAttribute("utente"); 
    String id_questionario=Utility.elimina_null(request.getParameter("id_questionario"));
    Questionario questionario=GestioneQuestionari.getIstanza().get_questionario(id_questionario);
    ArrayList<Sezione> sezioni=GestioneSezioni.getIstanza().ricerca("");
    ArrayList<Domanda> domande=GestioneQuestionari.getIstanza().ricerca_domande(" domande.id_questionario="+id_questionario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="../_importazioni.jsp"></jsp:include>
        <script type="text/javascript">
            
           window.print();
        </script>
        <style>
            .box{
                background: white;
                
            }
            .box{
                line-height: 14px;
                font-size: 12px;
                padding:2px;
                margin:2px;
                border:0.5px solid gray;                
                page-break-inside: avoid;
                break-inside: avoid;
                -webkit-column-break-inside: avoid;
            }
            h5{
                border:0.5px solid gray;
                padding: 5px;
                text-align: center;
                font-size: 13px;
            }
            h2{
                text-align: center;
            }
            h3{
                text-align: center;
            }
            th,td{
                text-align: justify;
                padding:2.5px;
                vertical-align: top;
            }
        </style>
    </head>
    <body>
    
        <div id='container'>
            <div class="box">
            <h2>Domande del questionario <%=questionario.getNr()%>/<%=questionario.getAnno()%> - <%=questionario.getTitolo_ita()%></h2>
                <% //int max_ordinamento=1; 
                String id_sezione_corrente="";
                int i=0;
                for(Domanda d:domande){
                    if(!d.getSezione().getId().equals(id_sezione_corrente) || id_sezione_corrente.equals("")){
                        i++;
                        id_sezione_corrente=d.getSezione().getId();
                        if(i>1){%>
                        <div style="page-break-after: always;"></div>
                        <%}%>
                    <h3>Sezione <%=d.getSezione().getTesto_ita()%></h3>
                <%}%>
                
                <table style="width: 100%;">
                    <tr>
                    <% if(d.getVisibile_id().equals("")){%>
                        <td colspan="4"><h5>Domanda <%=d.getSezione().getTesto_ita()%> <%=d.getSezione().getNr()%>.<%=d.getNr()%></h5></td>
                    <%}%>
                    </tr>
                    <tr>
                        <th style="width: 15%;">Domanda in italiano</th>
                        <td style="width: 35%;">
                            <%=Utility.standardizza_textarea(d.getTesto_ita())%>
                        </td>
                    
                        <th style="width: 15%;">Domanda in inglese</th>
                        <td style="width: 35%;">
                            <%=Utility.standardizza_textarea(d.getTesto_eng())%>
                        </td>
                    </tr>
                    <tr>
                        <th>Tipologia</th>
                        <td>
                            <% if(d.is_si_no()){%>Si/No<%}%>
                            <% if(d.is_testo()){%>Testuale<%}%>
                            <% if(d.is_numero()){%>Numerica<%}%>
                            <% if(d.is_select()){%>Scelta Esclusiva<%}%>
                            <% if(d.is_checkbox()){%>Scelta Multipla<%}%>
                            <% if(d.is_allegato()){%>File Allegato<%}%>
                        </td>
                        <% if(d.is_select() || d.is_checkbox()){%>
                            <th>Valori della scelta (separati da virgola)</th>
                            <td>
                                <%=Utility.standardizza_textarea(d.getValori())%>
                            </td>
                        <%}else{%>
                            <td></td>
                            <td></td>
                        <%}%>
                    </tr>
                    <tr>
                        <th>Peso</th>
                        <td>
                            <%=Utility.elimina_zero(d.getPeso())%>
                        </td>
                        <% if(!d.getVisibile_id().equals("")){%>
                            <th>Visibile se la domanda</th>
                            <td>
                                <% if(d.getVisibile_id().equals("")){%>Sempre<%}%>
                                <% for(Domanda dd:domande){%>
                                    <% if(d.getVisibile_id().equals(dd.getId())){%><%=dd.getSezione().getNr()%>.<%=dd.getNr()%><%}%>
                                <%}%>
                                è uguale a  <%=d.getVisibile_condizione()%>
                                
                            </td>
                        <%}else{%>
                            <td></td>
                            <td></td>
                        <%}%>
                    </tr>
                </table>    
            <%}%>   
        </div>
        </div>
    </body>
</html>