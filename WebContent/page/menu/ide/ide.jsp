<%@ page import="com.codenator.publicString.PublicString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="codenator.cclass.*,codenator.notice.*,codenator.assign.*"%>

<jsp:useBean id="cdao" class="codenator.cclass.CclassDAO" />
<jsp:useBean id="ndao" class="codenator.notice.NoticeDAO" />
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />

<%
  int no_ide = Integer.parseInt(request.getParameter("no"));
  String cid_ide = (String)request.getParameter("cid");
  AssignDTO adto = adao.get(no_ide);
  %>
  
  <%
  if (session.getAttribute("id") == null) {
  response.sendRedirect(request.getContextPath() + "/index.jsp");
  }
%>

<html ng-app="app">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-sanitize.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.8/angular-touch.js"></script>

  <!-- Codemirror -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/codemirror.css?ver=1">
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
  <!-- Autosize addon -->
  <%-- <script src="${pageContext.request.contextPath}/js/autosize.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/js/simplescrollbars.js"></script>
<script src="${pageContext.request.contextPath}/css/simplescrollbars.css"></script> --%>

<!-- Xterm.js -->
<script src="${pageContext.request.contextPath}/js/xterm.js"></script>
<script src="${pageContext.request.contextPath}/js/addon/attach.js"></script>
<script src="${pageContext.request.contextPath}/js/require.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/xterm.css">

<!-- Custom Scrollbar -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customScrollbar.css">

<title><%=adto.getTitle()%> :: <%=adto.getCname()%> :: Codenator</title>
</head>
<style>
  .left-content {
  	margin-top: 10px;
  	margin-bottom: 10px;
  	border-top: solid 2px;
  	padding-top: 10px;
  	padding-bottom: 10px;
  }

  .ioexample {
  	width: 100%;
    background: #000;
    color: #fff;
    resize: vertical;
    margin-bottom:10px;
    font-family: sans-serif !important;
  }

  .codemirror-wrap{
    font-family: sans-serif !important;
  }
</style>
<style>
  .CodeMirror-sizer{
    margin-left:45px !important;
  }
</style>
<script>
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

/*    $scope.editor = CodeMirror.fromTextArea(document.getElementById("code"), {
    mode : "text/x-csrc", // can change mode by editing this option
    theme : "monokai",
    lineNumbers : true,
    lineWrapping : true,
    matchBrackets : true,
    lint : true,
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
    }

    foldGutter : {
      rangeFinder : new CodeMirror.fold.combine(CodeMirror.fold.brace,
        CodeMirror.fold.comment)
    },
    gutters : [ "CodeMirror-linenumbers", "CodeMirror-foldgutter",
    "CodeMirror-lint-markers" ],
  });

    $scope.editor.display.wrapper.style.fontSize = "14px";
    $scope.editor.display.wrapper.style.height = "700px";
    $scope.editor.refresh();*/

    $scope.selectLanguage = function() {
      $scope.lang = $("#selectLanguage").val();
      if (lang == "C/C++") {
       editor.setOption("mode", "text/x-c");
       editor.setValue(hint);
     } else if (lang == "Java") {
       editor.setOption("mode", "text/x-java");
       editor.setValue("/*name of java public class must be Codenator*/");
     } else if (lang == "Python") {
       editor.setOption("mode", "python");
       editor.setValue("");
     }
   }

   $scope.showBsModal = function(){
    $(function () { $('#io').on('show.bs.modal', function () {
      $('#output').val('Compiling...\n');
      $('#input').val('');
    });
  });
  };


  $(function () { $('#io').on('hide.bs.modal', function () {
   $.post("${pageContext.request.contextPath}/index.action",
     {},
     function (data, status) {});
 })
}); 
  /* ================================================================================================================= */

  $('#input').bind('keypress',function(event){
    if(event.keyCode == "13") {
      $('#input_submit').click();
    }
  });

  /*var webSocket = new WebSocket('<%=PublicString.WEBSOCKET_ADDRESS%>'); 

  //<%=PublicString.WEBSOCKET_ADDRESS%>
  webSocket.onerror = function(event) {
    //onError(event)
    alert("an error occurred");
  };
  webSocket.onopen = function(event) {
    //onOpen(event)
    webSocket.send(sessionid);
  };
  webSocket.onmessage = function(event) {
    //onMessage(event)
    document.getElementById("output").value += event.data;
  };
  function start() {
    webSocket.send(sessionid);
    return false;
  }

  $(document).ready(function() {
    $("#code_submit").click(function() {
     start();
     $.post("${pageContext.request.contextPath}/run.action", {
      code : editor.getValue(),
      language : $("#selectLanguage").val()
    }, function(data, status) {

    });
   });

    $("#input_submit").click(function() {
     $('#output').val($('#output').val() + $("#input").val() + '\n');
     $.post("${pageContext.request.contextPath}/input.action", {
      input : $("#input").val()
    }, function(data, status) {

    });
     $("#input").val("");
   });
  });
  //==== 채점 =====

  $(document).ready(function(){
    $("#grading").click(function() {
      //start();
      $.post("${pageContext.request.contextPath}/run2.action", {
        code : editor.getValue(),
        language : $("#selectLanguage").val(),
        answer_input1: $("#ioexample1").val(),
        answer_output1: $("#ioexample2").val(),
        answer_input2: $("#ioexample3").val(),
        answer_output2: $("#ioexample4").val(),
      }, function(data, status) {

      });

    });
  });*/

  });// End of AngularJS script
</script>
<body ng-controller="ctrl">
  <%@ include file="/page/layout/navbar.jsp"%>
<div class="button-group" style="margin-bottom:20px;">
    <input type="hidden" id="selectLanguage" value="C/C++">
    <button type="button" class="btn btn-default" style="float:right; margin-right:10px;">초기화</button>
    <button type="button" class="btn btn-default" id="grading" style="float:right; margin-right:10px;">제출</button>
    <button type="button" class="btn btn-default" data-toggle="modal" data-target="#io" id="code_submit" style="float:right; margin-right:10px;">테스트</button>
  </div>

  <div style="margin-left:20px; margin-right:20px;">
  <!-- 왼쪽 레이아웃 -->
  <div class="left col-md-3" style=" margin:0 auto; padding:15px; background-color: #e7e7e7;">
<input type="hidden" id="cid" name="cid" value="<%=adto.getCid()%>" >
<% if(adto.getTitle() == null || adto.getCname() == null){ //cid 확인과정 수정필요
    response.sendRedirect(request.getContextPath() + "/page/error/404.jsp");
  }else{}
  %>
  <!-- 과제 이름 -->
  <span style="font-size:24px; font-weight: bold;"><%=adto.getTitle()%></span>
  <!-- 과목 이름 -->
  <span style="margin-bottom:60px; font-weight:bold;"><%=adto.getCname()%></span>
  <!-- 목표 -->
  <div class="left-1">
    <label>목표</label>
    <div><%=adto.getPurpose()%></div>
  </div>
  <!-- 실습내용 -->
  <div class="left-1">
    <label>실습내용</label>
    <div><%=adto.getDetail()%></div>
  </div>
  <!-- 입출력예시 -->
  <div class="left-1">
    <label>입/출력예시</label><br> 
    <label>입력 1</label>
    <textarea class="ioexample" id="ioexample1" readonly="readonly" onload="textAreaAdjust(this)" style="overflow:hidden"><%=adto.getAnswer_input1()%>
    </textarea>
    <label>출력 1</label>
    <textarea class="ioexample" id="ioexample2" readonly="readonly" onload="textAreaAdjust(this)" style="overflow:hidden"><%=adto.getAnswer_output1()%>
    </textarea>
    <label>입력 2</label>
    <textarea class="ioexample" id="ioexample3" readonly="readonly" onload="textAreaAdjust(this)" style="overflow:hidden"><%=adto.getAnswer_input2()%>
    </textarea>
    <label>출력 2</label>
    <textarea class="ioexample" id="ioexample4" readonly="readonly" onload="textAreaAdjust(this)" style="overflow:hidden"><%=adto.getAnswer_output2()%>
    </textarea>
  </div>
</div>
<!-- 오른쪽 레이아웃 -->
<div class="right col-md-9" style="border: solid 1px; background-color: #272822; margin:0 auto; padding:15px; display:none">
  <textarea id="code"><%=adto.getMaincode()%></textarea>
  <textarea id="hiddenValue" style="visibility:hidden;"><%=adto.getMaincode()%></textarea>
</div>
<div class="right col-md-9" style="background-color: #3d3d3d;"></div>


</div>

<div class="" style="background-color: #6d6d6d">


</div>

<!-- Modal -->
<div class="modal fade" id="io" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background:#333;">
        <button type="button" class="close" onclick="" data-dismiss="modal" aria-hidden="true" style="color:#fff;">&times;</button> <!--  disconnect() -->
        <h4 class="modal-title" id="myModalLabel" style="color:#fff;">출력</h4>
      </div>
      <textarea readonly="readonly" class="form-control" cols="25" rows="23" id="output"></textarea>
      <div class="modal-footer">
        <div class="col-xs-10">
          <input rows="1" id="input" class="form-control"></input>
        </div>
        <button type="button" class="btn btn-primary" id="input_submit" data-toggle="tooltip" title="input_button">입력</button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal -->
</div>


</body>
</html>