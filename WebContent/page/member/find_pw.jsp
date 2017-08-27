<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>비밀번호 찾기 :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/pw.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/libs/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="pw.js"></script>
<!-- <script type="text/javascript" src="/modules/widgets/log.js"></script> -->
</head>
<body>
  <!-- First Container -->
  <div class="container-fluid-big bg-3 text-center">
    <div id="main_container">
      <div class="top">
        <ul id="info-pw">
          <li>입력된 이메일로 비밀번호 재설정 인증 메일이 전송됩니다.</li>
          <li>전송된 메일로 인증을 하시면 임시 비밀번호가 발급됩니다.</li>
          <li>전송된 메일의 유효 기간은 24시간 입니다.</li>
        </ul>
        <div id="input_email_box" class="form-group">
          <input type="text" name="email" value="" pattern="true" class="input_box form-control" placeholder="사용자 이메일을 입력해주세요.">
        </div>
        <div class="toolbar">
          <div id="warn-email" class="alert alert-danger alert_msg" role="alert" style="display: none">
            <i class="fa fa-exclamation-triangle" style="margin-right: 10px;"></i>이메일 주소를 입력해주세요.
          </div>
          <div id="warn-email-valid" class="alert alert-danger alert_msg" role="alert" style="display: none">
            <i class="fa fa-exclamation-triangle" style="margin-right: 10px;"></i>이메일 주소가 형식에 맞지 않습니다.
          </div>
          <div id="find_pw_wrong" class="alert alert-danger alert_msg" role="alert" style="display: none">
            <i class="fa fa-exclamation-triangle" style="margin-right: 10px;"></i>입력하신 정보를 찾을 수 없습니다.
          </div>
          <div id="find_pw_fail" class="alert alert-danger alert_msg" role="alert" style="display: none">
            <i class="fa fa-exclamation-triangle" style="margin-right: 10px;"></i>비밀번호 재설정에 실패하였습니다.
          </div>
          <div id="find_pw_done" class="alert alert-info alert_msg" role="alert" style="display: none">
            <i class="fa fa-spinner fa-spin" style="margin-right: 10px;"></i>인증 메일 전송중입니다. 조금만 기다려 주십시오.
          </div>
          <div id="findpw_complete" class="alert_msg" style="display: none;">
            <p>사용자의 메일로 인증 메일이 발송되었습니다!</p>
            <p>메일을 인증하신 후, 임시 비밀번호를 발급받아 주시기 바랍니다.</p> <br> <a href="/login" class="btn btn-primary center-block"> 구름에듀 로그인 페이지 </a>
          </div>
        </div>
        <div class="bottom">
          <button id="find-pw-btn" type="button" class="btn btn-primary btn-lg">비밀번호 재설정</button>
        </div>
      </div>
    </div>
  </div>
  <!-- footer.jsp를 불러온다 -->
  <%@ include file="/page/layout/footer.jsp"%>
</body>
</html>
