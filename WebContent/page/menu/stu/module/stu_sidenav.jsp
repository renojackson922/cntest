<%@ page import="java.util.List,java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="codenator.cclass.*,codenator.member.*"%>
<jsp:useBean id="cdao" class="codenator.cclass.CclassDAO" />
<!-- Member, Occurs an error but couln't find the reason -->
<jsp:useBean id="mdao2" class="codenator.member.MemberDAO" />

<%
  int prof_id = Integer.parseInt(request.getParameter("prof_id"));
  List<CclassDTO> clist = cdao.clist(prof_id);
  String id=(String)session.getAttribute("id");
  
  MemberDTO mdto2 = mdao2.search(id);
  /* RequestDispatcher res; */
%>


<div class="col-sm-2 sidenav">
  <div class="well" style="padding: 5px 5px 5px 5px; margin-bottom: 5px;">
    <div class="media">
      <div class="media-left">
        <img src="./module/chansu_shin.jpg" class="media-object img-rounded" style="width: 60px">
      </div>
      <div class="media-body">
        <h5 class="media-heading" style="padding-top: 5px"><b><%=mdto2.getName() %></b></h5>
        <p style="font-size: 50%; border-top: 1px solid #e5e5e5"><%=mdto2.getBelong() %></p>
      </div>
      <div class="well" style="margin-bottom: 5px; background: rgb(255, 255, 255); font-size: 70%;">
        <%=mdto2.getIntro() %>
      </div>
        <a href="#" 
      class="btn btn-warning btn-lg btn-block" style="font-size: 70%; color: #fff; background-color: #4ec3f0; border-color: #42a2bf;">정보 수정하기</a>
    <%--   <a href="${pageContext.request.contextPath}/page/menu/prof/prof_create.jsp?prof_id=<%=mdto2.getProf_id()%>" 
      class="btn btn-warning btn-lg btn-block" style="font-size: 70%;">과목 개설하기</a> --%>
      <!-- style="float: right; margin-bottom:5px; -->
    </div>

  </div>
  <div class="dropdown">
    <button class="btn btn-default btn-lg btn-block dropdown-toggle" type="button" data-toggle="dropdown" style="margin-bottom: 5px; width: 100%; letter-spacing: 5px; font-size: 70%;">
      <b>과목선택</b> <span class="caret"></span>
    </button>
    <ul class="dropdown-menu" style="width: 100%;">
      <li class="dropdown-header">과목</li>
      <% 
        if(clist.isEmpty()){
      %>
      <li><a>개설된 과목이 없습니다.</a></li>
      <%
        }
      %>
      <%
          for (CclassDTO cdto : clist){
        %>
      <%--         <%
          res = request.getRequestDispatcher("");
        %> --%>
      <li><a href="${pageContext.request.contextPath}/page/menu/stu/stu_subject_brief.jsp?inverse=true&prof_id=<%=cdto.getProf_id()%>&cid=<%=cdto.getCid()%>"><%=cdto.getCname() %></a></li>
      <%
          }
        %>
      <li class="dropdown-header">기타</li>
      <li><a href="#">환경설정</a></li>
    </ul>
  </div>
  <!-- <button type="button" class="btn btn-default btn-lg btn-block" style="letter-spacing: 5px; font-size: 70%;">공지사항</button>
  <button type="button" class="btn btn-default btn-lg btn-block" style="letter-spacing: 5px; font-size: 70%;">과제</button>
  <button type="button" class="btn btn-default btn-lg btn-block" style="letter-spacing: 5px; font-size: 70%;">강의</button> -->
</div>
