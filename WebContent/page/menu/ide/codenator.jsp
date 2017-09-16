<%@ page import="com.codenator.publicString.PublicString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="codenator.cclass.*,codenator.notice.*,codenator.assign.*"%>

<jsp:useBean id="cdao" class="codenator.cclass.CclassDAO" />
<jsp:useBean id="ndao" class="codenator.notice.NoticeDAO" />
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="app">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
  
  <!-- Codemirror -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/codemirror.css">
  <script src="${pageContext.request.contextPath}/js/codemirror.js"></script>
  <!-- Create a simple CodeMirror instance -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/theme/monokai.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/display/fullscreen.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/hint/show-hint.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/fold/foldgutter.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/lint/lint.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/dialog/dialog.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/search/matchesonscrollbar.css">
  <!-- hint area -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/hint/show-hint.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/hint/javascript-hint.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/hint/anyword-hint.js"></script>
  <!-- code folding -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/fold/foldcode.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/fold/foldgutter.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/fold/brace-fold.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/fold/xml-fold.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/fold/comment-fold.js"></script>
  <!-- Mode Selection -->
  <script src="${pageContext.request.contextPath}/whatamess/mode/xml/xml.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/mode/javascript/javascript.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/mode/clike/clike.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/mode/python/python.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/mode/markdown/markdown.js"></script>
  <!-- Lint -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/lint/lint.js"></script>
  <!-- full-screen -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/display/fullscreen.js"></script>
  <!-- search -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/dialog/dialog.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/search/searchcursor.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/search/search.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/scroll/annotatescrollbar.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/search/matchesonscrollbar.js"></script>
  <script src="${pageContext.request.contextPath}/whatamess/addon/search/jump-to-line.js"></script>
  <!-- Xterm.js -->
  <script src="${pageContext.request.contextPath}/js/xterm.js"></script>
  <script src="${pageContext.request.contextPath}/js/addon/attach.js"></script>
  <script src="${pageContext.request.contextPath}/js/addon/fit.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xterm.css">
  <!-- Custom Scrollbar -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/scroll/simplescrollbars.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/scroll/simplescrollbars.css">

  <title>Codenator :: IDE</title>
  <style>
    .button_area{
      background-color: #fff;
      padding:15px;
      min-height:50px;
    }  
    .left_area_wrapper{
      background-color: #fff;
      padding:10px;
      max-height:900px;
    }
    .coding_area{
      min-height:653px;
    }  
    .prompt_area{
      background-color: #000;
    }
    .CodeMirror-wrap{
      font-family:consolas;
    }
    .right_area_wrapper{
      /*border no need */
      padding:0px;
    }
    #terminal-container .terminal {
      background-color: #111;
      color: #fafafa;
      padding: 2px;
    }
/*
 *  STYLE 1
 */
 .customScrollBar::-webkit-scrollbar-track
 {
  /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
  /*border-radius: 10px;*/
  border-radius: 2px;
  background-color: #eee;
}

.customScrollBar::-webkit-scrollbar
{
  width: 12px;
  background-color: #eee;
}

.customScrollBar::-webkit-scrollbar-thumb
{
  /*border-radius: 10px;*/
  border-radius: 2px;
  /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);*/
  background-color: #555
}

</style>
<script>
  //underscore.js URL parsing code
  var _GET = _.object(_.compact(_.map(location.search.slice(1).split('&'), function(item) {  if (item) item = item.split('='); if (item[1]) item[1] = decodeURIComponent(item[1]); return item; })));
  
  var app = angular.module('app', []);
  
  // 다른 도메인의 소스 불러오기 필터
  app.filter('trustUrl', function($sce){
    return function(url){
      return $sce.trustAsResourceUrl(url);
    }
  });
  
  app.controller('ctrl', function($scope, $http, $interval, $timeout) {

    $scope.doHide = false;

    $scope.loadQuestion = function(){
      $http({
        url: 'data.json',
        method: 'GET'
      }).then(function(response){
        $scope.quizList = response.data;
        console.log($scope.quizList);
        $scope.quizInput1 = $scope.quizList[1].input1;
        $scope.quizOutput1 = $scope.quizList[1].output1;
        $scope.quizInput2 = $scope.quizList[1].input2;
        $scope.quizOutput2 = $scope.quizList[1].output2;
        $scope.quizCode = $scope.quizList[1].code;
      });
    }

    $scope.loadQuestion();

    $scope.nowSaving = function(){
      $scope.doHide = true;
      $timeout(function(){
        $scope.doHide = false;
      },1000);
    }
    
    $scope.sessionId = '<%=session.getId()%>';
    $scope.webSocket = new WebSocket('<%=PublicString.WEBSOCKET_ADDRESS%>');
    //console.log($scope.webSocket);

    $scope.termOutput = document.getElementById('terminal-output');
    $scope.webSocket.onerror = function(event){
      $scope.termOutput.value += 'An error has occured.\n';
      //term.write('An error has occurred');
    }   
    $scope.webSocket.onopen = function(event){
      $scope.webSocket.send($scope.sessionId);
      $scope.termOutput.value += 'WebSocket opened.\n';
      //term.write('webSocket opened.\n' );
    }
    $scope.webSocket.onmessage = function(event) {
      //document.getElementById("output").value += event.data;
      $scope.termOutput.value += event.data + '\n';
      //term.write(event.data);
    }
    $scope.webSocket.onclose = function(event){
      $scope.termOutput.value += 'WebSocket Closed.\n';
      //term.write('webSocket closed');
    }
    $scope.start = function(){
      $scope.webSocket.send($scope.sessionId);
      return false;
    }

    $scope.language = 'C/C++';

    $scope.close = function(){
      $scope.webSocket.close();
    }

    $('#code-close').click(function(){
      $scope.close();
    })

/*    $scope.codeSubmit = function(callback){
      $('#code-submit').click(function(){
        $scope.start();
        $http({
          method: 'POST',
          url: '${pageContext.request.contextPath}/run.action',
          data: {
            //code: editor.getValue(),
            'language': $scope.language,
          },
        }).then(function(data,status){
          console.log('I dunno know what to do here');
          if(callback){
            callback();
          }
        });
      });
    }

    $scope.codeSubmit();*/

// 왜 위에는 안되는데 아래는 되냐고
  $(document).ready(function() {
    $("#code-submit").click(function() {
     $scope.start();
     $.post("${pageContext.request.contextPath}/run.action", {
      code : editor.getValue(),
      language : $scope.language
    }, function(data, status) {

    });
   });
    });

    $('#input-submit').click(function(){
      $('#output').val($('#output').val + $('#input').val() + '\n');
      $http({
        url: '${pageContext.request.contextPath}/input.action',
        input: $('#input').val()
      }).then(function(data,status){
        console.log('I dunno know what to do here');
      });
    });

  });  //End of Angular	  
</script>
</head>
<%

%>
<body ng-controller="ctrl">
  <div id="now_saving" ng-show="doHide" style="background-color: #3d3d3d; opacity:0.9; height:200%; width:100%; position: absolute; z-index:999; padding-top:250px; text-align:center; overflow:hidden">
    <img src="${pageContext.request.contextPath}/images/spinner.svg" style="height:300px; width:100%; margin-bottom:-30px;"><br>
    <span style="font-size:36px; line-height:60px;color:#fff;"><strong>저장 중 입니다...</strong></span>
  </div>
  <div id="show">
    <%@ include file="/page/layout/navbar.jsp"%>
    <!-- <div style="border:2px dashed #5d5d5d;"> -->
    <div class="button_area_wrapper" style="min-height:50px;">
      <div class="button_area" style="vertical-align:middle;">
        <span style="font-size:18px; position:absolute;line-height:40px;"><strong>알고리즘 및 실습</strong></span><br>
        <span style="font-size:12px; position:absolute;line-height:40px;color:#5d5d5d;">신찬수 교수님, 구자룡 조교님</span>
        <div class="actual_button_area" style="text-align:right;">
          <select style="width:76px; height:33px; border-radius:4px; margin-right:10px;">
            <option value="80">&nbsp80%</option>
            <option value="90">&nbsp90%</option>
            <option value="100" selected>&nbsp100%</option>
            <option value="110">&nbsp110%</option>
            <option value="120">&nbsp120%</option>
          </select>
          <select style="height:33px; border-radius:4px; margin-right:10px;">
            <option value="cLang">&nbspC/C++</option>
            <option value="javaLang">&nbspJAVA</option>
            <option value="pythonLang2">&nbspPython2</option>
            <option value="pythonLang3">&nbspPython3</option>
          </select>
          <button id="save_hotkey" class="btn btn-default" ng-click="nowSaving()">저장</button>
          <button class="btn btn-default">초기화</button>
          <button class="btn btn-default">제출</button>
          <button id="code-submit" class="btn btn-default">테스트</button>
          <button id="code-close" class="btn btn-default">소켓 닫기</button>
        </div>
      </div>
    </div>
    <!-- 문제 나오는 DIV --> 
    <div class="left_area_wrapper col-md-3" style="overflow-y:auto;">
      <div class="assign_area_title" style="margin-top:5px; margin-bottom:5px;">
        <span style="font-size:18px;"><strong>자료구조 및 실습 (01)</strong></span>
      </div>
      <div class="assign_area_detail" style="border-top:1px solid #5d5d5d; padding-top:10px; padding-bottom:10px;">
        <span style="font-size:12px;">RADIX SORT 실습을 진행해보도록 한다. RADIX SORT 실습을 진행해보도록 한다. RADIX SORT 실습을 진행해보도록 한다.</span>
      </div>
      <% 
      int num;
      for(num=1; num<=4; num++){ 
      %>
      <div class="assign_area_example" style=""> <!-- foreach -->
        <div class="assign_area_input" style="margin-top:5px; margin-bottom:5px;">
          <span style="font-size:12px;"><strong>입력&nbsp<%=num%></strong></span>
          <div class="" style="font-family:consolas; font-size:12px; max-height:auto !important; background-color:#272822; color:#eee; padding:5px; margin-bottom:10px; width:90%"> <!-- overflow-y:scroll; -->
            {{quizInput1}}
          </div>
        </div>
        <div class="assign_area_output">
          <span style="font-size:12px;"><strong>출력&nbsp<%=num%></strong></span>
          <div class="" style="font-family:consolas; font-size:12px; max-height:auto !important; background-color:#272822; color:#eee; padding:5px; margin-bottom:10px; width:90%">
            {{quizOutput1}}
          </div>
        </div>
      </div>  <!-- foreach ends -->
      <% }  %>
    </div><!-- 문제 DIV 끝 -->

    <!-- 코딩창과 프롬프트 나오는 DIV -->
    <div class="right_area_wrapper col-md-9 ">
      <div class="coding_area">
        <textarea id="code"></textarea>
      </div>
      <div class="prompt_area" style="padding:0px !important; height:247px !important; background-color: #5d5d5d;">
        <!-- <div id="terminal-container" style="height:500px;"></div> -->
        <textarea id="terminal-output" rows="10" readonly style="width:900px;"></textarea><br>
        <textarea id="terminal-input" rows="1" style="width:820px;"></textarea>
        <button class="btn btn-default" style="">send</button>
      </div>
    </div><!-- 코딩창 DIV 끝-->

  </div> <!-- ng-show/hide DIV 끝 -->
</body>
</html>
<script>

 var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
      mode : "text/x-csrc", //can change mode
      theme : "monokai",
      lineNumbers : true,
      lineWrapping : true,
      matchBrackets : true,
      lint : true,
      scrollbarStyle: "simple",
      extraKeys : {
        "F11" : function(cm) {
          cm.setOption("fullScreen", !cm.getOption("fullScreen"));
        },
        "Esc" : function(cm) {
          if (cm.getOption("fullScreen"))
            cm.setOption("fullScreen", false);
        },
        "Ctrl-Space" : "autocomplete",
        "Alt-F" : "findPersistent"
      },
      foldGutter : {
        rangeFinder : new CodeMirror.fold.combine(CodeMirror.fold.brace,
          CodeMirror.fold.comment)
      },
      gutters : [ "CodeMirror-linenumbers", "CodeMirror-foldgutter",
      "CodeMirror-lint-markers" ],
    });
 editor.display.wrapper.style.fontSize = "14px";
 editor.display.wrapper.style.height = "653px";
 editor.refresh();

/*var term = new Terminal({
  cursorBlink: true,  // Do not blink the terminal's cursor
  cols: 980,  // Set the terminal's width to 120 columns
  rows: 500  // Set the terminal's height to 80 rows
});

 term.open(document.getElementById('terminal-container'));
term.write('Hello from \033[1;3;31mxterm.js\033[0m $ \n');
 term.fit();*/
 


</script>
