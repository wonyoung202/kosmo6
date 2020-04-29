<%@page import="java.util.HashMap"%>
<%@page import="model.BBSDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Delete.jsp -->
<%
	
	//1]파라미터 받기
	String no = request.getParameter("no");
	
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));

	//2]CRUD작업용 DAO계열 객체 생성
	BBSDao dao = new BBSDao(application);
	int affected = dao.delete(no);
	
	//마지막 레코드 삭제 시 페이지가 하나 줄어드는 경우 코딩 시작
	int total = dao.getTotalRowCount(new HashMap());//total
	int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));//size
	int totalPage = (int)Math.ceil((double)total/pageSize);
	if(totalPage < nowPage) nowPage = totalPage;
	
	//마지막 레코드 삭제 시 페이지가 하나 줄어드는 경우 코딩 끝
	dao.close();
	
	if(affected == 1){//입력성공
		response.sendRedirect("List.jsp?nowPage="+nowPage);
	}
	else{//입력실패 
	%>
		<script>
			alert("삭제 실패");
			history.back();
		</script>
	<%
	}
	

%>