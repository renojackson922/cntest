<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") != null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>
<head>
<title>Login :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css?ver=3" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
label {
	font-size: 12px;
	font-family: inherit;
}
</style>
<body>
  <!-- Navbar -->
  <%@ include file="/page/layout/navbar.jsp"%>
  <!-- First Container -->
  <section>
    <div class="container-fluid bg-3 text-center" style="max-width: 500px; padding-bottom: 20px;">
      <h1 class="margin" style="color: LightSlateGray; letter-spacing: 5px; text-shadow: 0 0 5px #FF8C00;">Codenator</h1>
      <div class="panel panel-warning" style="height: 270px; border: 1px solid #dadada;">
        <form class="form-horizontal" action="login_pro.jsp" method="post" style="padding-left: 20px; padding-right: 20px; margin-top: 40px; margin-bottom: 40px">
          <div class="form-group">
            <label class="control-label" for="email"></label>
            <div class="col-sm-12">
              <!-- IMPORTANT!! -->
              <input type="email" class="form-control" id="id" name="id" remember="true" placeholder="이메일 주소를 입력해주세요." aria-required="true" style="margin-bottom: 5px; width: 100%; height: 40px;">
            </div>
          </div>
          <div class="form-group" style="margin-bottom: 0px">
            <label class="control-label" for="pwd"></label>
            <div class="col-sm-12">
              <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력해주세요." aria-required="true" style="margin-bottom: 5px; width: 100%; height: 40px;">
            </div>
          </div>
          <div class="form-group">
            <div>
              <div class="checkbox">
                <label><input type="checkbox"><b>기억하기</b></label>
              </div>
            </div>
          </div>
          <div class="form-group">
            <div>
              <!-- position:relative; -->
              <input class="button form-control" style="margin: 0 auto; max-width: 428px; height: 40px; color: white; background-color: rgb(247, 143, 36); border: 0px solid rgb(247, 143, 36); opacity: 0.8;" type="submit" value="로그인">
            </div>
          </div>
        </form>
      </div>
    </div>
  </section>
  <!-- Second Container -->
  <div class="container-fluid bg-3 text-center" style="margin-top:-20px; margin-bottom:-20px">
    <h5>비밀번호를 잃어버리셨나요? <a href="find_pw.jsp"><b>비밀번호 찾기</b></a>
    </h5>
    <h5>아직 회원이 아니신가요? <a href="signup.jsp"><b>회원가입</b></a>
    </h5>
  </div>
  <!-- footer.jsp를 불러온다 -->
  <%@ include file="/page/layout/footer.jsp"%>
</body>
</html>
<script>
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
