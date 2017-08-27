<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, height=device-width, initial-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css?ver=3" /> --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Codenator :: 페이지를 찾을 수 없습니다</title>
</head>
<style>
  h4, h5 {
  	color: #5d5d5d !important; 
  }
  .desc_error{
    text-align:center;
  }
  .hide{
    display:none;
  }
</style>
<body>
  <div class="errorContainer" style="margin: 103px auto 0; width: 600px;">
    <div class="well" style="height: 600px; background-color: #fff;">
      <div class="errorHead" style="position: relative;">
       <h4><b><a href="${pageContext.request.contextPath}/index.jsp" style="color:#5d5d5d; letter-spacing:3px;">Codenator</a></b></h4>
      </div>
      <hr style="border-top: solid 2px #5d5d5d;">
      <div class="errorBody">
        <h3 class="oops" style="text-align: center; color: #5d5d5d;"><b>이런!</b> 원하는 페이지를 찾을 수 없습니다!</h3>
        <img class="img-responsive" src="${pageContext.request.contextPath}/images/error_doge.png" 
        alt="Oops! I'm doge!" style="width:70%; margin:0 auto;"/>
        <hr style="border-top:#fff;"> 
        <p class="desc_error">찾고자 하는 페이지가 없거나, 수정 혹은 변경되어 찾을 수 없습니다.<br></p>
        <p class="desc_error">입력된 주소가 정확한지 다시 한번 확인해주시기 바랍니다.</p>
      </div>
      <hr style="border-top: solid 1px #5d5d5d;">
      <div class="errorFooter" style="text-align:center;"><h5>Codenator GJL 2017</h5></div>
    </div>
  </div>
</body>
</html>