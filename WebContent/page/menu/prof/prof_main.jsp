<%@ page import="java.util.List,java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="codenator.cclass.*"%>

<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

    /* request.setAttribute("inverse", true); */
%>
<head>
<title>나의 수강정보(교사) :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/prof.css?ver=5" />
</head>
<style>

</style>
<body>
  <%@ include file="/page/layout/navbar.jsp"%>
  <div class="container-fluid text-center" >
    <div class="row content" style="height:80%">
      <%@ include file="./module/prof_sidenav.jsp" %>
      <div class="col-sm-8 text-left" style="margin-bottom:20px;">
      
      </div>
     <%@ include file = "./module/prof_sidenavR.jsp" %>
    </div>
  </div>
  <%@ include file="/page/layout/footer.jsp" %>
</body>
</html>
