<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
  <div class="container">
    <h2>프로그래밍 문제를 수정합니다.</h2>
    <hr>
    <div class="container">
      <h5><b>문제 유형 선택</b></h5>
      <!-- <p>The .btn-group class creates a button group:</p> -->
      <div class="btn-group">
        <button type="button" class="btn btn-default">채점모드</button>
        <button type="button" class="btn btn-default">제출모드</button>
        <button type="button" class="btn btn-default">실행모드</button>
      </div>
    </div>
    <hr>
    <div class="container">
      <h5><b>문제 공개 여부</b></h5>
      <!-- <p>The .btn-group class creates a button group:</p> -->
      <div class="btn-group">
        <button type="button" class="btn btn-default">비공개</button>
        <button type="button" class="btn btn-default">채널 공개</button>
        <button type="button" class="btn btn-default">전체 공개</button>
      </div>
    </div>
    <hr>
    <div class="container assign_info">
      <h5><b>문제 정보</b></h5>
      <div class="form-group col-sm-4">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group col-sm-4">
        <label for="title">출처:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group col-sm-4">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group col-sm-4">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group col-sm-4">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
      <div class="form-group col-sm-4">
        <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
      </div>
    </div>
    <hr>
    <div class="container assign_info_detail">
      <div class="form-group col-md-6">
        <label for="comment">내용:</label>
        <textarea class="form-control" rows="5" id="comment"></textarea>
      </div>
      <div class="form-group col-md-6">
        <label for="comment">출제 의도:</label>
        <textarea class="form-control" rows="5" id="comment"></textarea>
      </div>
    </div>
  </div>
  <hr>
  <div class="container assign_body">
    <h5><b>문제 해결 언어</b></h5>
  </div>
  <hr>
  <div class="container assign_answer">
    <h5><b>채점 답안</b></h5>
  </div>
  <hr>
  <div class="container assign_answer">
    <h5><b>채점 옵션</b></h5>
  </div>
  <hr>
  <div class="container">
    <button type="button" class="btn btn-default" style="align: center">돌아가기</button>
    <button type="button" class="btn btn-default" style="align: center">수정하기</button>
  </div>
</body>
</html>