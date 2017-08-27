<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.removeAttribute("id");
    session.invalidate();

	//사용자가 볼 페이지를 서버에서 교체(redirect)
	response.sendRedirect(request.getContextPath()+"/index.jsp");
%>