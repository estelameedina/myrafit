<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
