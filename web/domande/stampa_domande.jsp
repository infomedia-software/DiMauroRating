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
                border-top: none;
                border-bottom: none;
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
        </style>
    </head>
    <body>
    
        <div id='container'>
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
                <div class="box">
                    <% if(d.getVisibile_id().equals("")){%>
                        <h5>Domanda <%=d.getSezione().getTesto_ita()%> <%=d.getSezione().getNr()%>.<%=d.getNr()%></h5>
                    <%}%>
                    <div class="width-50 float-left"></div>
                    
                    <div class="clear"></div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Domanda in italiano</div>
                        <div class="valore">
                            <%=Utility.standardizza_textarea(d.getTesto_ita())%>
                        </div>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Domanda in inglese</div>
                        <div class="valore">
                            <%=Utility.standardizza_textarea(d.getTesto_eng())%>
                        </div>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Tipologia</div>
                        <div class="valore">
                            <% if(d.is_si_no()){%>Si/No<%}%>
                            <% if(d.is_testo()){%>Testuale<%}%>
                            <% if(d.is_numero()){%>Numerica<%}%>
                            <% if(d.is_select()){%>Scelta Esclusiva<%}%>
                            <% if(d.is_checkbox()){%>Scelta Multipla<%}%>
                            <% if(d.is_allegato()){%>File Allegato<%}%>
                        </div>
                        <% if(d.is_select() || d.is_checkbox()){%>
                            <div class="etichetta">Valori della scelta (separati da virgola)</div>
                            <div class="valore">
                                <%=Utility.standardizza_textarea(d.getValori())%>
                            </div>
                        <%}%>
                    </div>
                    <div class="width-50 float-left">
                        <div class="etichetta">Peso</div>
                        <div class="valore">
                            <%=Utility.elimina_zero(d.getPeso())%>
                        </div>
                            <% if(!d.getVisibile_id().equals("")){%>
                            <div class="etichetta">Visibile se la domanda</div>
                            <div class="valore">
                                    <% if(d.getVisibile_id().equals("")){%>Sempre<%}%>
                                    <% for(Domanda dd:domande){%>
                                        <% if(d.getVisibile_id().equals(dd.getId())){%><%=dd.getSezione().getNr()%>.<%=dd.getNr()%><%}%>
                                    <%}%>
                            </div>
                            
                                <div class="etichetta">è uguale a </div>
                                <div class="valore">
                                    <%=d.getVisibile_condizione()%>
                                </div>
                            
                            <%}%>
                    </div>
                    <div class="clear"></div>
                </div>
            <%}%>   
        </div>
    </body>
</html>