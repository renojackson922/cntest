<%@ page import="java.util.List,java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="codenator.cclass.*,codenator.notice.*,codenator.assign.*"%>
<jsp:useBean id="cdao2" class="codenator.cclass.CclassDAO" />
<jsp:useBean id="ndao" class="codenator.notice.NoticeDAO" />
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />

<%
  if (session.getAttribute("id") == null) {
    response.sendRedirect(request.getContextPath() + "/index.jsp");
  }

    /* request.setAttribute("inverse", true); */
%>

<%
	int prof_id_brief = Integer.parseInt(request.getParameter("prof_id"));
	String cid = (String) request.getParameter("cid");
    String cname = (String)request.getParameter("cname");
  
    /* 과목ID로 과목 불러오기 */
	CclassDTO cdto2 = cdao2.get(prof_id_brief, cid);
  
    /* 공지사항 */
	List<NoticeDTO> nlist_b = ndao.search(prof_id_brief, cid);
    
    /* 과제 */
    List<AssignDTO> clist_b = adao.search(cid);
%>

<html>
<head>
<title>나의 수강정보(학생) :: Codenator</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/stu.css?ver=5" />
</head>
<style>
tr, th {
	text-align: center;
}
body {
    padding-right: 0 !important
}
</style>
<body>
  <%@ include file="/page/layout/navbar.jsp"%>
  <div class="container-fluid text-center">
    <div class="row content" style="min-height:800px; height:80%">
      <%@ include file="./module/stu_sidenav.jsp"%>
      <div class="col-sm-8 text-left" style="margin-bottom: 20px; margin-top: 10px">
        <div class="row">
          <div class="col-sm-3">
            <img class="img-responsive img-rounded" src="./data_structure.png" style="border: 1px solid #e5e5e5;">
          </div>
          <div class="col-sm-9">

            <!-- 과목이름 -->
            <h3 style="margin-bottom: 5px;"><b><%=cdto2.getCname()%></b></h3>
            <p><%=cdto2.getCintro() %></p>
          </div>
          <!-- Very important. It shows you how to put cols inside cols; also called neating -->
          <div class="container" style="padding-bottom: 10px; width: 100%;"></div>
          <!-- Second Container -->
          <div class="container" style="border: 1px solid #e5e5e5; border-radius: 6px; /* background: #fff; */ width: inherit; padding: 12px; margin: 10px">
            <h3 style="margin-top: 5px; padding-left:10px;">공지사항</h3>
            <%
                /* System.out.println(list); */
                if(nlist_b.isEmpty()){
            %>
            <h5 style="text-align: center;">공지사항이 작성되지 않았습니다.</h5>
            <%         
                }else{
            %>
            <table class="table">
              <thead>
              </thead>
              <tbody>
                <tr style="text-align: center; background: #e5e5e5;">
                  <th>작성자</th>
                  <th>제목</th>
                  <th>시간</th>
                  <th>읽음</th>
                  <th>    </th>
                </tr>
                <%
                	for (NoticeDTO ndto : nlist_b) {
                %>
                <tr>
                  <td><%=ndto.getWriter()%></td>
                  <td>
                    <a href="#" class="open_notice" data-id=<%=ndto.getNo()%> data-toggle="modal" data-target="#myModal">
                    <%=ndto.getTitle()%>
                    </a>
                  </td>
                  <td><%=ndto.getReg()%></td>
                  <td><%=ndto.getRead()%></td>
                  <td >
                    <!-- It should ask user whether remove or not; Have to fix it -->
                    <a href="${pageContext.request.contextPath}/page/menu/stu/stu_notice_remove.jsp?prof_id=<%=ndto.getProf_id()%>&no=<%=ndto.getNo()%>&cid=<%=ndto.getCid() %>" 
                    onclick="window.open(this.href, '', ''); return false;">
                    <span class="glyphicon glyphicon-remove" style="margin-top:3px"></span>
                    </a>
                  </td>
                 </tr>
                <%
                	}
                }
                %>
              </tbody>
            </table>
            <!-- Important! Float! -->
            <a href="stu_notice.jsp?subject=<%=cdto2.getCname() %>&cid=<%=cdto2.getCid()%>&prof_id=<%=cdto2.getProf_id()%>" class="btn btn-default" style="float: right;">작성하기</a>
          </div>
          <!-- Third Container -->
          <div class="container" style="border: 1px solid #e5e5e5; border-radius: 6px; /* background: #fff; */ width: inherit; padding: 12px; margin: 10px">
            <h3 style="margin-top: 5px; padding-left:10px;">과제목록</h3>
            <% 
              if(clist_b.isEmpty()){
            %>
            <h5 style="text-align: center;">출제된 과제가 없습니다.</h5>
            <%
              } else {
            %> 
             <table class="table">
              <thead>
              </thead>
              <tbody>
                <tr style="text-align: center; background: #e5e5e5;">
                  <th>작성자</th>
                  <th>제목</th>
                  <th>언어</th>
                  <th>시작</th>
                  <th>종료</th>
                  <th>    </th>
                </tr>
            <%
              for (AssignDTO adto : clist_b) {
                if(adto.getVisible().equals("FALSE")){
            %>
                <tr>
                  <td><%=adto.getWriter()%></td>
                  <td>
                    <a href="${pageContext.request.contextPath}/page/menu/ide/ide.jsp?no=<%=adto.getNo()%>&cid=<%=adto.getCid() %>"> 
                    <%=adto.getTitle()%>
                    </a>
                  </td>
                  <td><%=adto.getLang()%></td>
                  <td><%=adto.getA_start()%></td>
                  <td><%=adto.getA_end()%></td>
                  <td>
                    <!-- It should ask user whether remove or not; Have to fix it -->
                    <a href="${pageContext.request.contextPath}/page/menu/stu/stu_assign_remove.jsp?prof_id=<%=adto.getProf_id()%>&no=<%=adto.getNo()%>&cid=<%=adto.getCid() %>" onclick="window.open(this.href, '', ''); return false;"> <span class="glyphicon glyphicon-remove" style="margin-top: 3px"></span>
                    </a>
                  </td>
                </tr>
                <%
                	} else {
                %>
            <tr>
                  <td><%=adto.getWriter()%></td>
                  <td>
                    <a href="${pageContext.request.contextPath}/page/menu/ide/ide.jsp?no=<%=adto.getNo()%>&cid=<%=adto.getCid() %>"> 
                    <%=adto.getTitle()%>
                    </a>
                  </td>
                  <% 
                    if(adto.getLang().equals("c")){
                  %>
                  <td>C/C++</td>
                  <%
                    } else if(adto.getLang().equals("java")){
                  %>
                  <td>Java</td>
                  <%} else if(adto.getLang().equals("python")){ %>
                  <td>Python</td>
                  <%
                    } else {}
                  %>
                  <td><%=adto.getA_start()%></td>
                  <td><%=adto.getA_end()%></td>
                  <td >
                    <!-- It should ask user whether remove or not; Have to fix it -->
                    <a href="${pageContext.request.contextPath}/page/menu/stu/stu_assign_remove.jsp?prof_id=<%=adto.getProf_id()%>&no=<%=adto.getNo()%>&cid=<%=adto.getCid() %>" 
                    onclick="window.open(this.href, '', ''); return false;">
                    <span class="glyphicon glyphicon-remove" style="margin-top:3px"></span>
                    </a>
                  </td>
                 </tr>
            <%
                  }
                }
              }
            %>
            </tbody>
            </table>
            <!-- Important! Float! -->
            <a href="stu_assign_simple.jsp?cname=<%=cdto2.getCname() %>&cid=<%=cdto2.getCid()%>&prof_id=<%=cdto2.getProf_id()%>" class="btn btn-default" style="float: right;">출제하기</a>
            <!-- <button class="btn btn-default" style="float: right;">출제하기</button> -->
          </div>
          <!-- Fourth Container -->
          <div class="container" style="border: 1px solid #e5e5e5; border-radius: 6px; /* background: #fff; */ width: inherit; padding: 12px; margin: 10px">
            <h3 style="margin-top: 5px; padding-left:10px;">강의</h3>
             <% 
              if(true){ // 강의 list 확인해야 함.
            %>
            <h5 style="text-align: center;">진행 중인 강의가 없습니다.</h5>
            <%
              }
            %> 
            <!-- Important! Float! -->
            <button class="btn btn-default" style="float: right;">강의작성</button>
          </div>
        </div>
      </div>
      <%@ include file="./module/stu_sidenavR.jsp"%>
    </div>
  </div>
<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><b>공지사항</b></h4>
        </div>
        <div class="modal-body">
          <input type="text" name="noticeId" id="noticeId" value=""/>
          <input type="text" name="noticeTitle" id="noticeTitle" value=""/>
          <%--           
          <p><b>번호: </b><%=ndto2.getNo()%></p>
          <p><b>과목: </b><%=ndto2.getSubject()%></p>
          <p><b>작성자: </b><%=ndto2.getWriter()%></p>
          <p><b>작성일자: </b><%=ndto2.getReg()%></p>
          <p><b>조회수: </b><%=ndto2.getRead()%></p> 
          --%>
        </div>
        <div class="modal-body">
          <h5><b>내용</b></h5>
          <%-- <p><%=ndto2.getDetail()%></p> --%>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="/page/layout/footer.jsp"%>
</body>
<script>
	/* Sending value of notice ID */
	$(document).on("click", ".open_notice", function() {
		var myNoticeId = $(this).data('id');
		<% 
            int no999 = 15;
            NoticeDTO ndto2 = ndao.get(no999); 
        %>
		$(".modal-body #noticeId").val(myNoticeId);
		var myNoticeTitle = "<%=ndto2.getTitle()%>";
		$(".modal-body #noticeTitle").val(myNoticeTitle);
	});
</script>
</html>