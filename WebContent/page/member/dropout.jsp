<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- <%@ include file="/page/layout/header.jsp" %> --%>

<jsp:useBean id="mdao" class="codenator.member.MemberDAO" />
<%
	//로그인 판정하는 코드를 작성하여 상황에 맞게 메뉴를 달리 출력한다
	String loginId = (String)session.getAttribute("id");
	boolean loginFlag;
	if(loginId == null){
		loginFlag = false;
	}else{
		loginFlag = true;
	}
%>

<%
	//[1] 세션 아이디 추출... 필요없음(loginId)
	//[2] DB연결
	mdao.drop(loginId);
	//[3] 로그아웃 + index로 이동
	//response.sendRedirect("logout.jsp"); 
%>
<script>
	window.alert("그동안 이용해 주셔서 감사합니다 ^^");
	location.href="logout.jsp";
</script>

<%@ include file="/page/layout/footer.jsp"%>