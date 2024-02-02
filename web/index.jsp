<%@page import="utility.Config"%>
<%@page import="beans.Utente"%>
<%@page import="utility.Utility"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Utente utente=(Utente)session.getAttribute("utente"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=Utility.nome_software%></title>
        <jsp:include page="_importazioni.jsp"></jsp:include>
        <script type="text/javascript">
            
        </script>
    </head>
    <body>
    
        <jsp:include page="_menu.jsp"></jsp:include>
        <div id='container'>
        <% if(utente==null){%>
            <jsp:include page="_login.jsp"></jsp:include>
        <%}else{%>
            
                <jsp:include page="_index.jsp"></jsp:include>
            
        <%}%>

</div>
    <jsp:include page="_footer.jsp"></jsp:include>
    </body>
</html>
