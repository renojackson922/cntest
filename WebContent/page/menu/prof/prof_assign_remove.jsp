<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao2" class="codenator.assign.AssignDAO" />
<jsp:useBean id="adto" class="codenator.assign.AssignDTO" />
<jsp:setProperty name="adto" property="*" />
<%
  int prof_id_brief = Integer.parseInt(request.getParameter("prof_id"));
  int no = Integer.parseInt(request.getParameter("no"));
  String cid = (String)request.getParameter("cid");
%>    

<script>
  function remove() {
    var choice = window.confirm("정말 삭제하시겠습니까?\n복구되지 않습니다");
    window.alert(choice);
    if (choice) {
      <% adao2.remove(no, cid); %>
    }
    else{

    }
    <% response.sendRedirect(request.getContextPath() + "/page/menu/prof/prof_subject_brief.jsp?inverse=true&prof_id="
  	      +prof_id_brief+"&cid=" + cid); %>	
  }
</script>
 
<script>
    remove();
</script>
    

