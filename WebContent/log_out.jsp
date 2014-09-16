<%

RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
session.removeAttribute("name");
session.removeAttribute("employeeId");
session.removeAttribute("password");
session.invalidate();
rd.forward(request, response);



%>