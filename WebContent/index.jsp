<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>Codenator</title>
<!-- <meta name="viewport" content="width=device-width, height=device-width, initial-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css?ver=3" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-touch.js"></script>
<script>
// Parsing using underscore.js
	var _GET = _.object(_.compact(_.map(location.search.slice(1).split('&'), function(item) {  if (item) item = item.split('='); if (item[1]) item[1] = decodeURIComponent(item[1]); return item; })));
</script>
</head>
<body>
  <!-- Navbar -->
  <%@ include file="/page/layout/navbar.jsp"%>

  <!-- First Container -->
  <section>
    <div class="visible-xs visible-sm" style="background: url(images/mighty_back.jpg) center 10% no-repeat; filter: grayscale(5%); height: 200px; background-size: 100%; padding-bottom: 0; margin-botton: -20px; border-bottom: 1px solid #e5e5e5">
      <div class="container" style="position: relative; top: 70; text-align: left; color: white; max-width: 1024px; width: 100%;">
        <h3 class="whiteTextOverride" style="font-weight: 650;"><b>코드네이터</b></h3>
        <h6 class="whiteTextOverride" style="font-weight: 100; margin-top: 10px"><b>이제껏 경험해보지 못했던 간편함</b></h6>
      </div>
    </div>
    <div class="visible-md visible-lg" style="background: url(images/mighty_back.jpg) center 30% no-repeat; filter: grayscale(5%); height: 300px; background-size: 100%; padding-bottom: 0; border-bottom: 1px solid #e5e5e5">
      <div class="container" style="position: relative; top: 180; text-align: left; color: white; max-width: 1024px; width: 100%; padding-left: 50px">
        <h1 class="whiteTextOverride" style="font-weight: 650;"><b>코드네이터</b></h1>
        <h4 class="whiteTextOverride" style="font-weight: 100; margin-top: 10px"><b>이제껏 경험해보지 못했던 간편함</b></h4>
      </div>
    </div>
  </section>
  <!-- Second Container -->
  <div class="container-fluid-bit bg-3 text-center" style="border-bottom: 1px solid #e5e5e5">
    <h1 class="margin"><b>코드네이터가 뭐죠?</b></h1> <img src="images/index_main_01.png" class="img-responsive img-rounded margin" style="display: inline" alt="Codenator">
    <p>비주얼 스튜디오나 이클립스 등의 개발 IDE를 설치하지 않아도 웹 환경에서 자유롭게 코딩이 가능합니다.</p>
    <p>C/C++, JAVA, Python 언어를 지원하며, 이외의 언어는 준비 중입니다.</p>
  </div>
  <!-- Third Container -->
  <div class="container-fluid bg-3 text-center" style="margin-bottom: 50px;">
    <div class="container text-center">
      <h1><b>누가 만들었죠?</b></h1>
      <p>이 웹 어플리케이션의 제작자는...</p>
      <div class="row">
        <div class="col-sm-4">
          <img src="images/profile/profile01.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
          <h4><b>구자룡</b></h4>
          <!-- <h5>남한산성의 불주먹</h5> -->
          <p style="font-size: 70%; margin: 10px 10px 10px 10px"></p>
        </div>
        <div class="col-sm-4">
          <img src="images/profile/profile02.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
          <h4><b>전은표</b></h4>
          <!-- <h5>상하이의 장전된 피스톨</h5> -->
          <p style="font-size: 70%; margin: 10px 10px 10px 10px"></p>
        </div>
        <div class="col-sm-4">
          <img src="images/profile/profile03.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
          <h4><b>이진형</b></h4>
          <!-- <h5>하동의 핏빛 금속빠따</h5> -->
          <p style="font-size: 70%; margin: 10px 10px 10px 10px"></p>
        </div>
      </div>
    </div>
  </div>
  <!-- Fourth Container -->
  <div class="container-fluid-bit bg-3 text-center" style="margin-bottom: 50px; border-top: 1px solid #e5e5e5">
    <h1 class="container-fluid-bit-more"><b>어떤 기술이 사용되었죠?</b></h1>
    <p>이 사이트를 구축하기 위하여 아래와 같은 기술이 사용되었습니다.</p> <br>
    <div class="row">
      <div class="col-sm-3">
        <img src="images/tech1.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
        <p style="font-size: 70%; margin: 10px 10px 10px 10px">코드를 처리하기 위해서 리눅스 서버를 사용하게 됩니다. 처리된 코드의 결과값을 받아옵니다.</p>
      </div>
      <div class="col-sm-3">
        <img src="images/tech2.png?ver=1" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
        <p style="font-size: 70%; margin: 10px 10px 10px 10px">모든 웹페이지의 작동은 JSP언어로 작성되었습니다.</p>
      </div>
      <div class="col-sm-3">
        <!--  style="padding-bottom: 50px" -->
        <img src="images/tech3.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
        <p style="font-size: 70%; margin: 10px 10px 10px 10px">회원정보는 데이터베이스에 저장되어 있습니다. 회원정보를 담기 위해 오라클 서버를 사용하였습니다.</p>
      </div>
      <div class="col-sm-3">
        <img src="images/tech4.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
        <p style="font-size: 70%; margin: 10px 10px 10px 10px">서버 내부에서 개인별 컨테이너를 나누어 보안에 강하고, 제약없이 서버 사용이 가능합니다.</p>
      </div>
    </div>
    <!-- <div class="row">
      <div class="col-sm-3">
        <img src="images/tech5.png" class="img-responsive img-rounded margin" style="display: inline; margin: 10px" width="50%" align="middle" alt="Image">
        <p style="font-size: 70%; margin: 10px 10px 10px 10px">서버 내부에서 개인별 컨테이너를 나누어 보안에 강하고, 제약없이 서버 사용이 가능합니다.</p>
      </div>
      <div class="col-sm-3"></div>
      <div class="col-sm-3"></div>
      <div class="col-sm-3"></div>
    </div> -->

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
