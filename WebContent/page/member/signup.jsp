<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 중요! 이미 로그인된 사람은 접속할 수 없도록 만들어야함!!!!!!!!!!!!!!!!! -->

<%@ page import="codenator.member.*"%>

<%
	if (session.getAttribute("id") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>Signup :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css" /></head>
<style>
label {
	font-size: 12px;
	font-family: inherit;
}

form-control {
	aria-required: true;
	margin-bottom: 5px;
	width: 100%;
	height: 40px;
}

.container-narrow {
	align: left;
}
</style>
<body>
  <!-- Navbar -->
  <%@ include file="/page/layout/navbar.jsp"%>

  <!-- First Container -->
  <div class="container text-center"></div>
  <!-- Second Container -->
  <div class="container-fluid bg-3 text-center" style="margin-top: 10px; max-width: 500px; padding-bottom: 40px; min-height:1100px;">
    <h1 class="margin" style="color: LightSlateGray; letter-spacing: 5px; text-shadow: 0 0 5px #FF8C00;">Codenator</h1>
    <div class="panel panel-warning" style="height: 860px; border: 1px solid #dadada;">
      <form name="join" action="signup_pro.jsp" method="get" style="padding-left: 20px; padding-right: 20px; margin-top: 20px; margin-bottom: 20px">
        <div class="btn-group" data-toggle="buttons" style="margin-bottom: 10px">
          <label class="btn btn-default"> <input type="radio" name="power" value="stu"> 학생/수강자로 가입하기
          </label> <label class="btn btn-default"> <input type="radio" name="power" value="prof"> 교사/강의자로 가입하기
          </label>
        </div>
        <div class="alert alert-info" style="font-size: 12px">해당되는 항목을 반드시 선택해주세요.</div>
        <div class="form-group container-narrow" align="left">
          <label for="name">이름:</label> <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="id">이메일 주소:</label> <input type="email" class="form-control" name="id" id="id">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="pw">비밀번호:</label> <input type="password" class="form-control" name="pw" id="pw">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="pw2">비밀번호 재확인:</label> <input type="password" class="form-control" id="pw2">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="name">소속:</label> <input type="text" class="form-control" name="belong" id="belong" placeholder="ex) 디지털정보공학과">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="name">자기소개:</label> <textarea class="form-control" name="intro" id="intro" placeholder="자기소개를 입력해주세요."></textarea>
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="tel">휴대폰 번호:</label> <input type="text" class="form-control" name="tel" id="tel" placeholder="ex) 010-1234-5678">
        </div>
        <div class="form-group container-narrow" align="left">
          <label for="birth">생년월일:</label> <input type="text" class="form-control" name="birth" id="birth" placeholder="'-' 를 빼고 입력하세요. ex) 19920829" style="margin-bottom: 35px">
        </div>
        <button type="submit" class="btn btn-primary" style="max-width: 428px; height: 40px; color: white; background-color: rgb(247, 143, 36); border: 0px solid rgb(247, 143, 36); opacity: 0.8;">가입</button>
      </form>
    </div>
  </div>
  <!-- footer.jsp를 불러온다 -->
  <%@ include file="/page/layout/footer.jsp"%>
</body>
<script>

</script>
</html>
