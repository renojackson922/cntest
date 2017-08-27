<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="codenator.member.*, codenator.cclass.*, codenator.assign.*"%>
<jsp:useBean id="mdao" class="codenator.member.MemberDAO" />
<jsp:useBean id="cdao" class="codenator.cclass.CclassDAO" />
<jsp:useBean id="adao" class="codenator.assign.AssignDAO" />

<jsp:setProperty name="mdto" property="*" />
<jsp:setProperty name="cdto" property="*" />
<jsp:setProperty name="adto" property="*" />

<%
	/* 관리자 권한 확인 */
	String id = (String) session.getAttribute("id");
	MemberDTO mdto2 = mdao.search(id);

	/* 리스트 생성 */
	List<MemberDTO> mlist = mdao.search_all();
	List<CclassDTO> clist = cdao.search_all();
	List<AssignDTO> alist = adao.search_all();

	/* 권한 없는 사람 쫒아내기*/
%>

<%
	if (session.getAttribute("id") == null || !(mdto2.getProf_id().equals("19920829"))) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Debug</title>
</head>
<body>
  <h3>Member</h3>
  <table class="table">
    <thead>
    </thead>
    <tbody>
      <tr style="text-align: center; background: #e5e5e5;">
        <th>no</th>
        <th>power</th>
        <th>prof_id</th>
        <th>name</th>
        <th>id</th>
        <th>pw</th>
        <th>belong</th>
        <th>intro</th>
        <th>tel</th>
        <th>birth</th>
        <th>joindate</th>
      </tr>
      <%
      	for (MemberDTO mdto : mlist) {
      %>
      <tr>
        <td><%=mdto.getNo()%></td>
        <td><%=mdto.getPower()%></td>
        <td><%=mdto.getProf_id()%></td>
        <td><%=mdto.getName()%></td>
        <td><%=mdto.getId()%></td>
        <td><%=mdto.getPw()%></td>
        <td><%=mdto.getBelong()%></td>
        <td><%=mdto.getIntro()%></td>
        <td><%=mdto.getTel()%></td>
        <td><%=mdto.getBirth()%></td>
        <td><%=mdto.getJoindate()%></td>
      </tr>
      <%
      	}
      %>
    </tbody>
  </table>

  <h3>Class</h3>
  <table class="table">
    <thead>
    </thead>
    <tbody>
      <tr style="text-align: center; background: #e5e5e5;">
        <th>cno</th>
        <th>prof_id</th>
        <th>cname</th>
        <th>cid</th>
        <th>maxattend</th>
        <th>cintro</th>
        <th>createdate</th>
        <th>validdate</th>
      </tr>
      <%
      	for (CclassDTO cdto : clist) {
      %>
      <tr>
        <td><%=cdto.getCno()%></td>
        <td><%=cdto.getProf_id()%></td>
        <td><%=cdto.getCname()%></td>
        <td><%=cdto.getCid()%></td>
        <td><%=cdto.getMaxAttend()%></td>
        <td><%=cdto.getCintro()%></td>
        <td><%=cdto.getCreateDate()%></td>
        <td><%=cdto.getValidDate()%></td>
      </tr>
      <%
      	}
      %>
    </tbody>
  </table>

  <h3>Assign</h3>
  <table class="table">
    <thead>
    </thead>
    <tbody>
      <tr style="text-align: center; background: #e5e5e5;">
        <th>no</th>
        <th>cname</th>
        <th>cid</th>
        <th>prof_id</th>
        <th>writer</th>
        <th>visible</th>
        <th>title</th>
        <th>detail</th>
        <th>purpose</th>
        <th>lang</th>
        <th>answer_i1</th>
        <th>answer_o1</th>
        <th>answer_i2</th>
        <th>answer_o2</th>
        <th>a_start</th>
        <th>a_end</th>
      </tr>
      <%
      	for (AssignDTO adto : alist) {
      %>
      <tr>
        <td><%=adto.getNo()%></td>
        <td><%=adto.getCname()%></td>
        <td><%=adto.getCid()%></td>
        <td><%=adto.getProf_id()%></td>
        <td><%=adto.getWriter()%></td>
        <td><%=adto.getVisible()%></td>
        <td><%=adto.getTitle()%></td>
        <td><%=adto.getDetail()%></td>
        <td><%=adto.getPurpose()%></td>
        <td><%=adto.getLang()%></td>
        <td><%=adto.getAnswer_input1()%></td>
        <td><%=adto.getAnswer_output1()%></td>
        <td><%=adto.getAnswer_input2()%></td>
        <td><%=adto.getAnswer_output2()%></td>
        <td><%=adto.getA_start()%></td>
        <td><%=adto.getA_end()%></td>
      </tr>
      <%
      	}
      %>
    </tbody>
  </table>
</body>
</html>