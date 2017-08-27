<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 데이터 수신 -->
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mdto" class="codenator.member.MemberDTO" />
<jsp:setProperty name="mdto" property="*" />
<!-- DB처리 -->
<jsp:useBean id="mdao" class="codenator.member.MemberDAO" />
<%	mdao.insert(mdto); %>
<!-- HTML 코드를 이용한 사용자가 볼 화면 출력		: View 코드(클라이언트) -->
<!-- <h1>회원 가입이 완료되었습니다</h1>
<h3><a href="login.jsp">로그인 페이지로 이동</a></h3>
<h3><a href="../../index.jsp">메인 페이지로 이동</a></h3> -->
<% response.sendRedirect(request.getContextPath() + "/index.jsp"); %>