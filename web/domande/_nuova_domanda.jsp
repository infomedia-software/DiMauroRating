<%@page import="utility.Utility"%>
<%@page import="gestioneDB.GestioneSezioni"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.Sezione"%>
<% ArrayList<Sezione> sezioni=GestioneSezioni.getIstanza().ricerca(""); %>
<% String id_questionario=Utility.elimina_null(request.getParameter("id_questionario")); %>
<form id="form_nuova_domanda">
    <input type="hidden" value="<%=id_questionario%>" name="id_questionario">
    <div class="etichetta">Sezione</div>
    <div class="valore">
    <select id="id_sezione" name="id_sezione">
        <% for(Sezione s:sezioni){%>
            <option value="<%=s.getId()%>"><%=s.getNr()%> <%=s.getTesto_ita()%></option>
        <%}%>
    </select>
    </div>
    <div class="clear"></div>
    <button type="button" class="pulsante float-right" onclick="nuova_domanda();"><img src="<%=Utility.img_add%>">Crea Domanda</button>

</form>