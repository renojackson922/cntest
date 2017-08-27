<%@page import="com.codenator.publicString.PublicString"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Coding Test :: Codenator</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jshint/r07/jshint.js"></script>

<!-- Codemirror -->
<link rel="stylesheet" href="css/codemirror.css">
<script src="js/codemirror.js"></script>

<!-- Create a simple CodeMirror instance -->
<link rel="stylesheet" href="whatamess/theme/monokai.css">
<link rel="stylesheet" href="whatamess/addon/display/fullscreen.css">
<link rel="stylesheet" href="whatamess/addon/hint/show-hint.css">
<link rel="stylesheet" href="whatamess/addon/fold/foldgutter.css" />
<link rel="stylesheet" href="whatamess/addon/lint/lint.css">
<link rel="stylesheet" href="whatamess/addon/dialog/dialog.css">
<link rel="stylesheet" href="whatamess/addon/search/matchesonscrollbar.css">
<!-- hint area -->
<script src="whatamess/addon/hint/show-hint.js"></script>
<script src="whatamess/addon/hint/javascript-hint.js"></script>
<!-- code folding -->
<script src="whatamess/addon/fold/foldcode.js"></script>
<script src="whatamess/addon/fold/foldgutter.js"></script>
<script src="whatamess/addon/fold/brace-fold.js"></script>
<script src="whatamess/addon/fold/xml-fold.js"></script>
<script src="whatamess/addon/fold/comment-fold.js"></script>
<!-- Mode Selection -->
<script src="whatamess/mode/xml/xml.js"></script>
<script src="whatamess/mode/javascript/javascript.js"></script>
<script src="whatamess/mode/clike/clike.js"></script>
<script src="whatamess/mode/markdown/markdown.js"></script>
<!-- Lint -->
<script src="whatamess/addon/lint/lint.js"></script>
<!-- full-screen -->
<script src="whatamess/addon/display/fullscreen.js"></script>
<!-- search -->
<script src="whatamess/addon/dialog/dialog.js"></script>
<script src="whatamess/addon/search/searchcursor.js"></script>
<script src="whatamess/addon/search/search.js"></script>
<script src="whatamess/addon/scroll/annotatescrollbar.js"></script>
<script src="whatamess/addon/search/matchesonscrollbar.js"></script>
<script src="whatamess/addon/search/jump-to-line.js"></script>
<!-- Place for tty.js -->
<script src="js/xterm.js"></script>
<script src="js/addon/fit.js"></script>
<script src="js/addon/attach.js"></script>
<link rel="stylesheet" href="css/xterm.css">

<!-- RequireJS -->
<!-- <script src="js/require.js"></script> -->

<!-- Socket.io -->
<script src="js/socket.io.js"></script>

</head>
<body>
  <%@ include file="coding2_div.jsp"%>
  <!-- Container -->
  <div class="container">
    <div class="row">
      <div class="col-md-2">
        <select class="form-control" id="selectLanguage" onchange="selectLanguage()" style="margin-bottom: 10px">
          <option>C/C++</option>
          <option>Java</option>
          <option>Python</option>
        </select>
      </div>
    </div>
    <textarea id="code" style="margin-bottom: 20px"></textarea>
  </div>
  
  <!-- Button -->
  <div class="container">
    <div style="font-size: 25px;" class="text-center" data-toggle="tooltip" title="Ctrl+F7">
      <span class="glyphicon glyphicon-play" role="button" data-toggle="modal" data-target="#io" id="code_submit"></span>
    </div>
  </div>
  
  <!-- 模态框（Modal） -->
  <div class="modal fade" id="io" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title" id="myModalLabel">Output</h4>
        </div>
        <textarea readonly="readonly" class="form-control" cols="25" rows="23" id="output"></textarea>
        <div class="modal-footer">
          <div class="col-xs-10">
            <input rows="1" id="input" class="form-control"></input>
          </div>
          <button type="button" class="btn btn-primary" id="input_submit" data-toggle="tooltip" title="回车">输入</button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
  </div>
<script>
	var sessionid = "<%=session.getId()%>";
	document.write(sessionid);

	var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
		mode : "text/x-csrc", //can change mode
		theme : "monokai",
		lineNumbers : true,
		lineWrapping : true,
		matchBrackets : true,
		lint : true,
		value : "one\ntwo\nthree",
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
				"CodeMirror-lint-markers" ]
	});

	/* editor.display.wrapper.style.height = "auto"; */

	editor.display.wrapper.style.fontSize = "14px";
	editor.setValue("#include <stdio.h>\n int main(){ \n int a = 0; \n scanf(\"%d\",&a);  \n printf(\"Hello!%d\",a); \n  return 0; \n }");
	editor.refresh();


	 $(function () { $('#io').on('show.bs.modal', function () {
	        $('#output').val('Compiling...\n');
	        $('#input').val('');
	    })
	    });

	    $(function () { $('#io').on('hide.bs.modal', function () {
	        $.post("./index.action",
	                {

	                },
	                function (data, status) {

	                });
	    })
	    });	
	/* ================================================================================================================= */
	/* doge/demo is the node.js directory */
	var webSocket = new WebSocket('<%=PublicString.WEBSOCKET_ADDRESS%>'); 
	
	<%-- <%=PublicString.WEBSOCKET_ADDRESS%> --%>
	webSocket.onerror = function(event) {
		onError(event)
	};
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	function onMessage(event) {
		document.getElementById("output").value += event.data;
	}
	function onOpen(event) {
		webSocket.send(sessionid);
	}
	function onError(event) {
		alert("an error occurred");
	}
	function start() {
		webSocket.send(sessionid);
		return false;
	}
	$(document).ready(function() {
/* 		$(document).bind('keydown', 'ctrl+f7', function() {$('#code_submit').click();}) */
		$("#code_submit").click(function() {
			start();
			$.post("./run.action", {
				code : editor.getValue(),
				language : $("#selectLanguage").val()
			}, function(data, status) {

			});
		});
		$("#input_submit").click(function() {
			$('#output').val($('#output').val() + $("#input").val() + '\n');
			$.post("./input.action", {
				input : $("#input").val()
			}, function(data, status) {

			});
			$("#input").val("");
		});
	});
</script>
</html>