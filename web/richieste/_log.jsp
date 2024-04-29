<%@page import="utility.Utility"%>
<% String id_richiesta_riga=Utility.elimina_null(request.getParameter("id_richiesta_riga")); %>

<h2>LOG</h2>
<div class="box">
    <%=Utility.getIstanza().getValoreByCampo("richieste_righe", "log", "id="+id_richiesta_riga)%>    
</div>