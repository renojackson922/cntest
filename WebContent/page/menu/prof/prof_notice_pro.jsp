<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 데이터 수신 -->
<% request.setCharacterEncoding("UTF-8"); 
  int prof_id_brief = Integer.parseInt(request.getParameter("prof_id"));
  String cid = (String) request.getParameter("cid");
%>
<jsp:useBean id="ndto" class="codenator.notice.NoticeDTO" />
<jsp:setProperty name="ndto" property="*" />
<!-- DB처리 -->
<jsp:useBean id="ndao" class="codenator.notice.NoticeDAO" />
<%	ndao.insert(ndto); %>
<!-- HTML 코드를 이용한 사용자가 볼 화면 출력: View 코드(클라이언트) -->
<!-- 공지작성 완료 -->
<% response.sendRedirect(request.getContextPath() + "/page/menu/prof/prof_subject_brief.jsp?inverse=true&prof_id="
    +prof_id_brief+"&cid=" + cid); %>