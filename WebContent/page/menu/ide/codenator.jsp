<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!--   <script src="${pageContext.request.contextPath}/js/xterm.js"></script>
  <script src="${pageContext.request.contextPath}/js/addon/attach.js"></script>
  <script src="${pageContext.request.contextPath}/js/require.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/xterm.css"> -->
  <!-- Custom Scrollbar -->
  <script src="${pageContext.request.contextPath}/whatamess/addon/scroll/simplescrollbars.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/whatamess/addon/scroll/simplescrollbars.css">
<!--   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customScrollbar.css"> -->

  <title>Codenator :: IDE</title>
  <style>
  .button_area{
    border:1px dashed #5d5d5d;
    background-color: #fff;
    margin:0 auto;
    padding:15px;
    min-height:50px;
  }  
  .assign_area{
   border:1px dashed #5d5d5d;

   border-top:0px;

   background-color: #fff;
   margin:0 auto;
   padding:10px;
   min-height:500px;
 }
 .coding_area{
   border:1px dashed #5d5d5d;

   border-top:0px;
   border-left:0px;

   margin:0 auto;
   /*padding:5px;*/
   min-height:500px;
   padding:0px;
 }  
 .prompt_area{
  border:1px dashed #5d5d5d;

  border-top:0px;

  margin:0 auto;
  padding:5px;
  min-height:300px;
}
.CodeMirror-wrap{
  padding:5px;
  /*height:500px !important;*/
}

/*
 *  STYLE 1
 */
.customScrollBar::-webkit-scrollbar-track
{
  /*-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);*/
  /*border-radius: 10px;*/
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
    var sessionid = "<%=session.getId()%>";

    $scope.doHide = false;

    $scope.nowSaving = function(){
      $scope.doHide = true;
      $timeout(function(){
          $scope.doHide = false;
       },1000);
    }
  });  //End of Angular	  
</script>
</head>
<%

%>
<body ng-controller="ctrl">
<!--   <div id="hide" class="container" ng-hide="doHide" style="padding-top:250px; text-align:center;">
    <img src="${pageContext.request.contextPath}/images/loading.gif" style="margin-bottom:20px;"><br>
    <span style="font-size:36px; line-height: 60px;"><strong>잠시만 기다려주세요...</strong></span>
  </div> -->
  <div id="now_saving" ng-show="doHide" style="background-color: #3d3d3d; opacity:0.9; height:200%; width:100%; position: absolute; z-index:999; padding-top:250px; text-align:center; overflow:hidden">
    <img src="${pageContext.request.contextPath}/images/spinner.svg" style="height:300px; width:100%; margin-bottom:-30px;"><br>
    <span style="font-size:36px; line-height:60px;color:#fff;"><strong>저장 중 입니다...</strong></span>
  </div>
  <div id="show">
    <%@ include file="/page/layout/navbar.jsp"%>
    <div class="button_area_wrapper" style="min-height:50px;">
      <div class="button_area" style="vertical-align:middle;">
        <span style="font-size:18px; position:absolute;line-height:40px;"><strong>알고리즘 및 실습</strong></span><br>
        <span style="font-size:12px; position:absolute;line-height:40px;color:#5d5d5d;">신찬수 교수님, 구자룡 조교님</span>
        <div class="actual_button_area" style="text-align:right;">
          <select style="height:33px; border-radius:4px; margin-right:10px;">
              <option value="cLang">C/C++</option>
              <option value="javaLang">JAVA</option>
              <option value="pythonLang2">Python2</option>
              <option value="pythonLang3">Python3</option>
          </select>
          <button class="btn btn-default" ng-click="nowSaving()">저장</button>
          <button class="btn btn-default">초기화</button>
          <button class="btn btn-default">제출</button>
          <button class="btn btn-default">테스트</button>
        </div>
      </div>
    </div>
    <div class="coding_area_wrapper" style="height:500px;overflow-y:hidden;">
      <div class="col-md-3 assign_area" style="overflow-y:hidden;">
        <div class="assign_area_title" style="margin-top:5px; margin-bottom:5px;">
          <span style="font-size:18px;"><strong>자료구조 및 실습 (01)</strong></span>
        </div>
        <div class="assign_area_detail" style="border-top:1px solid #5d5d5d; padding-top:10px; padding-bottom:10px;">
          <span style="font-size:12px;">RADIX SORT 실습을 진행해보도록 한다. RADIX SORT 실습을 진행해보도록 한다. RADIX SORT 실습을 진행해보도록 한다.</span>
        </div>
        <% 
        int num;
        for(num=0; num<2; num++){ 
        %>
        <div class="assign_area_example"> <!-- foreach -->
          <div class="assign_area_input" style="margin-top:5px; margin-bottom:5px;">
            <span><strong>입력&nbsp<%=num + 1%></strong></span>
            <div class="customScrollBar" style="height:50px !important; background-color:#000; color:#eee; padding:5px; margin-bottom:10px;overflow-y:scroll;">
              <p>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br>asss<br></p>
            </div>
          </div>
          <div class="assign_area_output">
            <span><strong>출력&nbsp<%=num + 1%></strong></span>
            <div class="customScrollBar" style="background-color:#000; color:#eee; padding:5px; margin-bottom:10px;overflow-y:scroll;">
             <p>asss</p>
           </div>
         </div>
       </div>  <!-- foreach ends -->
       <% }  %>
     </div>
     <div class="col-md-9 coding_area">
      <textarea id="code"></textarea>
    </div>
  </div>
  <div class="prompt_area_wrapper">
    <div class="prompt_area" style="position:relative;">
      <span>TEST</span>
    </div>
  </div>
</div>
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
 editor.display.wrapper.style.height = "500px";
 editor.refresh();

</script>