<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 데이터 수신 -->
<%
	request.setCharacterEncoding("UTF-8");
    int prof_id=Integer.parseInt(request.getParameter("prof_id"));
%>
<jsp:useBean id="cdto" class="codenator.cclass.CclassDTO" />
<jsp:setProperty name="cdto" property="*" />
<!-- DB처리 -->
<jsp:useBean id="cdao" class="codenator.cclass.CclassDAO" />
<%
	cdao.cinsert(cdto);
    response.sendRedirect(request.getContextPath() + "/page/menu/prof/prof_main.jsp?inverse=true&prof_id=" + prof_id);
%>
<!-- HTML 코드를 이용한 사용자가 볼 화면 출력		: View 코드(클라이언트) -->

