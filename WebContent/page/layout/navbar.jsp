<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="codenator.member.*"%>
<jsp:useBean id="mdao" class="codenator.member.MemberDAO" />

<%
	//로그인 판정하는 코드를 작성하여 상황에 맞게 메뉴를 달리 출력한다
	String loginId = (String)session.getAttribute("id");

	boolean loginFlag;
	if (loginId == null) {
		loginFlag = false;
	} else {
		loginFlag = true;
	}

	boolean su = Boolean.parseBoolean(request.getParameter("su")),
            log = Boolean.parseBoolean(request.getParameter("log")),
            inverse = Boolean.parseBoolean(request.getParameter("inverse"));
  
	MemberDTO mdto = mdao.search(loginId);  
  
	String pow_addr = new String();
    String pow_kor = new String();
    if(loginFlag){
    	String pow = new String(mdto.getPower());
    	if (pow.equals("admin")) {
    		pow_addr = "/page/menu/prof/prof_main.jsp"+"?inverse=true";
            pow_kor = "관리자";
    	} else if (pow.equals("prof")) {
    		pow_addr = "/page/menu/prof/prof_main.jsp"+"?inverse=true";
            pow_kor = "교사";
    	} else if (pow.equals("stu")) {
    		pow_addr = "/page/menu/stu/stu_main.jsp"+"?inverse=true";
    		pow_kor = "학생";
    	} else {}
    }
    
    /* boolean checkInv = (boolean)request.getAttribute("inverse"); */
%>

<!-- <header class="navbar-fixed-top"> -->
<%
	if (!inverse) {
%>
<!-- Should ignore this warning sign. No malfunction. -->
<nav class="navbar navbar-default">
<%
  	} else {
%>
  <nav class="navbar navbar-inverse">
<% }%>
    <div class="container-fluid-div">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">Codenator</a>
      </div>
      <div class="collapse navbar-collapse" id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
          <%
          	if (!loginFlag) {
          		if (su == true || log == true) {
          		} else {
          %>
          <li><a href="<%=request.getContextPath()%>/page/member/login.jsp?log=true">로그인</a></li>
          <%
          	           }
          	    } else {
          %>
          <li><a href="<%=request.getContextPath() + pow_addr%>&prof_id=<%=mdto.getProf_id()%>" 
          data-toggle="tooltip" data-placement="bottom" 
          title="나의 수강정보"><%=mdto.getName()%> 님, 환영합니다 <b style="font-size:90%; letter-spacing: 0px;"><%=pow_kor%></b></a></li>
          <%
           /* For debugging purpose only!!! */
          if((mdto.getProf_id()).equals("19920829")){   
            /* String sha1 = mdao.sha1("19920829"); */
           %>
           <li>
           <a href="${pageContext.request.contextPath}/page/debug/debug.jsp"> 
              <span class="glyphicon glyphicon-sunglasses" style="font-size:20px;"></span>
           </a>
           </li>
           <%
           	}
           	}
           %>
          <%
          	if (!loginFlag) {
          		if (su == true) {
          		} else {
          %>
          <li><a href="<%=request.getContextPath()%>/page/member/signup.jsp?su=true">회원가입</a></li>
          <%
          	}
          	} else {
          %>
          <li><a href="<%=request.getContextPath()%>/page/member/logout.jsp">로그아웃</a></li>
          <%
          	}
          %>
          <%
          	if (loginFlag) {
          %>
          <li><a href="#" onclick="dropout();"><b>탈퇴</b></a></li>
          <!-- 임시 -->
          <%
          	} else {
          	}
          %>
        </ul>
      </div>
    </div>
  </nav>
  <!-- </header> -->

  <script>
	function dropout() {
		var choice = window.confirm("정말 탈퇴하시겠습니까?\n복구되지 않습니다");
		//window.alert(choice);
		if (choice) {
			location.href = "${pageContext.request.contextPath}/page/member/dropout.jsp";
		}
	}
</script>