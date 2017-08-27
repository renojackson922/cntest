<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  if (session.getAttribute("id") == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
  }

    /* request.setAttribute("inverse", true); */
%>

<%
  int prof_id=Integer.parseInt(request.getParameter("prof_id"));
%>
<html>
<head>
<title>과목추가 :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css" />
</head>
<body>
  <div class="container">
    <h2>과목추가</h2>
    <p>과목을 추가할 수 있습니다.</p>
    <form action="prof_create_pro.jsp" method="post">
      <div class="form-group">
        <input type="hidden" name="prof_id" value="<%=prof_id%>">
        <label>과목이름:</label> <input type="text" class="form-control" name="cname" placeholder="최대 30자 입력가능">
      </div>
      <div class="form-group">
        <label>과목 인원 제한 수:</label> <input type="text" class="form-control" name="maxAttend">
      </div>
      <div class="form-group">
        <label>과목 설명:</label> <textarea class="form-control" name="cintro"></textarea>
      </div>
      <div class="form-group">
        <label for="ccreate">과목 생성일:</label> <input type="text" class="form-control" id="ccreate" placeholder="ex) 19920829">
      </div>
      <div class="form-group">
        <label for="cvalid">과목 만료일:</label> <input type="text" class="form-control" id="cvalid" placeholder="ex) 19920829">
      </div>
      <button type="submit" class="btn btn-primary">생성</button>
    </form>
  </div>
  <!-- footer.jsp를 불러온다 -->
  <%-- <%@ include file="/page/layout/footer.jsp"%> --%>
</body>
</html>