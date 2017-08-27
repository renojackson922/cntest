<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="codenator.notice.*"%>
<jsp:useBean id="ndao" class="codenator.notice.NoticeDAO" />
<%
  if (session.getAttribute("id") == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
  }

    /* request.setAttribute("inverse", true); */
%>

<%
  int prof_id_brief = Integer.parseInt(request.getParameter("prof_id"));
  String cid = (String) request.getParameter("cid");
  String subject = (String)request.getParameter("subject");
%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Notice Test</title>
</head>
<body>
  <div class="container">
    <form action="prof_notice_pro.jsp" method="get">
      <h2 style="margin-bottom:20px;">공지 작성하기</h2>
      <div class="form-group">
        <b>과목:</b> <%=subject%>
        <input type="hidden" id="subject" name="subject" value="<%=subject%>">
        <input type="hidden" id="cid" name="cid" value="<%=cid %>">
      </div>
      <div class="form-group">
        <label for="writer">작성자:</label> <input type="text" class="form-control" id="writer" name="writer">
        <input type="hidden" id="prof_id" name="prof_id" value="<%=prof_id_brief %>">
      </div>
      <div class="form-group">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group">
        <label for="detail">상세 내용:</label>
        <textarea class="form-control" rows="5" id="detail" name="detail"></textarea>
      </div>
      <button type="submit" class="btn btn-primary">공지작성</button>
    </form>
  </div>
</body>
</html>