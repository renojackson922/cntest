<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 데이터 수신 -->
<% request.setCharacterEncoding("UTF-8"); 
    int prof_id=Integer.parseInt(request.getParameter("prof_id"));
    String cid = request.getParameter("cid");%>
<jsp:useBean id="adto" class="codenator.assign.AssignDTO" />
<jsp:setProperty name="adto" property="*" />

<!-- DB처리 -->
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />
<% adao.insert(adto); %>

<!-- HTML 코드를 이용한 사용자가 볼 화면 출력		: View 코드(클라이언트) -->

http://localhost:8080/gjl/page/menu/prof/prof_subject_brief.jsp?inverse=true&prof_id=19920829&cid=a06c8d75fd372cec9db177b17a431b1772ed512
<%
    response.sendRedirect(request.getContextPath() + "/page/menu/prof/prof_subject_brief.jsp?inverse=true&prof_id=" + prof_id + "&cid=" + cid);
%>