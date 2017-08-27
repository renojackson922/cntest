<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="codenator.assign.*"%>

<%
	if (session.getAttribute("id") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}

	/* request.setAttribute("inverse", true); */
%>

<%
	int prof_id = Integer.parseInt(request.getParameter("prof_id"));
	String cid = request.getParameter("cid");
	String cname = request.getParameter("cname");
%>
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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

<title>Assign Test</title>
</head>
<body>
  <div class="container" style="max-width: 1500px;">
    <form action="prof_assign_simple_pro.jsp" method="get">
      <div class="col-md-6">
        <div class="form-group  ">
          <h2 style="margin-top:50px;"><b>과제 생성하기</b></h2> <br>
        </div>
        <div class="form-group  ">
          <input type="hidden" id="cname" name="cname" value=<%=cname%> /> 
          <input type="hidden" id="cid" name="cid" value=<%=cid%> /> 
          <input type="hidden" id="prof_id" name="prof_id" value=<%=prof_id%> /> 
          <label for="writer">작성자:</label> 
            <input type="text" class="form-control" id="writer" name="writer">
        </div>
        <div class="form-group  ">
          <label for="visible">공개여부:</label> <input type="text" class="form-control" id="visible" name="visible" placeholder="TRUE">
        </div>
        <div class="form-group  ">
          <label for="title">제목:</label> <input type="text" class="form-control" id="title" name="title">
        </div>
        <!--    <div class="form-group">
      <label for="a_start">시작시간:</label>  rows="5
      <input type="text" class="form-control" id="a_start" name="a_start"></input>
    </div>
    <div class="form-group">
      <label for="a_end">종료시간:</label>
      <input type="text" class="form-control" id="a_end" name="a_end"></input>
    </div> -->
        <div class="form-group  ">
          <label for="detail">내용:</label>
          <textarea class="form-control" rows="5" id="detail" name="detail"></textarea>
        </div>
        <div class="form-group  ">
          <label for="purpose">출제의도:</label>
          <textarea class="form-control" rows="5" id="purpose" name="purpose"></textarea>
        </div>
        <div class="form-group  ">
          <label for="lang">문제 해결 언어</label> <br>
          <select class="form-control" id="selectLanguage" name="lang" onchange="selectLanguage2()">
            <option value="c">C/C++</option>
            <option value="java">Java</option>
            <option value="python">Python</option>
          </select>
        </div>
        <div class="form-group  ">
          <label for="answer_input1">입력1:</label>
          <textarea class="form-control" rows="5" id="answer_input1" name="answer_input1"></textarea>
        </div>
        <div class="form-group  ">
          <label for="answer_output1">출력1:</label>
          <textarea class="form-control" rows="5" id="answer_output1" name="answer_output1"></textarea>
        </div>
        <div class="form-group  ">
          <label for="answer_input2">입력2:</label>
          <textarea class="form-control" rows="5" id="answer_input2" name="answer_input2"></textarea>
        </div>
        <div class="form-group  ">
          <label for="answer_output2">출력2:</label>
          <textarea class="form-control" rows="5" id="answer_output2" name="answer_output2"></textarea>
        </div>
      </div>
      <div class="col-md-6" style="margin-top:125px;">
        <div class="form-group">
         <label for="maincode">기본 코드</label> 
          <textarea id="code" name="maincode"></textarea><br>
        </div>
        <div class="form-group  ">
          <button type="submit" class="btn btn-primary">과제 생성</button>
        </div>
      </div>
    </form>
  </div>
</body>
<script>
	var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
		mode : "text/x-csrc", //can change mode
		theme : "monokai",
		lineNumbers : true,
		lineWrapping : true,
		matchBrackets : true,
		lint : true,
		//value : "one\ntwo\nthree",
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
	editor.display.wrapper.style.height = "1145px";
	editor.setValue("#include <stdio.h>\n int main(){ \n int a = 0; \n scanf(\"%d\",&a);  \n printf(\"Hello!%d\",a); \n  return 0; \n }");
	editor.refresh();
	
    var hint='/*Due to the linux system reason,you should add "fflush(stdout)" after a \n ' +
    'standard output statement(especially printf()).Like this,"printf("Hello world!");fflush(stdout);"\n' +
    'Otherwise,the I/O sequences may not correct.*/\n\n' + '#include <stdio.h>\n' + '\n' + 'void main(){\n' + '\n' + '}'; 
	editor.setValue(hint);
	

	function selectLanguage2() {
		var lang = $("#selectLanguage").val();
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
</script>
</html>