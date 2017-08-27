<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자에게 보여질 내용이 없는 페이지, 오로지 처리만 할 예정이므로 템플릿페이지 사용하지 않는다 -->
<jsp:useBean id="mdao" class="codenator.member.MemberDAO" />
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	//체크박스 수신
	String remember = request.getParameter("remember"); //null 또는 ok

	boolean result = mdao.login(id, pw);
%>
<%
	if (result) {
%>
<%-- <%
		//쿠키 작업 수행
		//1. remember == ok 일 경우, 아이디를 저장하는 쿠키를 생성
		//2. remember == null 일 경우, 아이디를 저장하는 쿠키를 삭제
		if(remember == null){
			Cookie c = new Cookie("remember", id);
			c.setMaxAge(0);
			response.addCookie(c);
		}else{
			Cookie c = new Cookie("remember", id);
			c.setMaxAge(Integer.MAX_VALUE);//최대로 설정
			response.addCookie(c);
		}
	%> --%>
<%
	//session에 로그인 성공값을 저장	 	(예) a="ok", 사용자 아이디, 사용자 정보
	session.setAttribute("id", id); //id가 Object로 저장(이름은 "id")
%>
<script>
/* 	window.alert("환영합니다"); */
	location.href = "../../index.jsp";
</script>
<%
	} else {
%>
<script>
	window.alert("사용자 정보를 다시 확인해주세요");
	history.back();
</script>
<%
	}
%>
