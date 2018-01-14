<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
    
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     --> 
<!DOCTYPE html> <!--HTML5로 버전을 지정해줌 -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	int year = Integer.parseInt(request.getParameter("year")); //requset.getParameter에서 얻어온 파마리터는 String이다 따라서 Integer.Parseint를 해줘야한다.
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int lastday = Integer.parseInt(request.getParameter("lastday"));
	
	Calendar cal = Calendar.getInstance();	
	int hour = cal.get(Calendar.HOUR_OF_DAY);
	int min =cal.get(Calendar.MINUTE);
%>
<body>
<form action="Controller.do" method="post">
<input type="hidden" name="command" value="insertboard">
<table border="1">

<tr>
	<td>아이디</td>
	<td><input type="text" readonly="readonly" value="hk" name="id"></td>
</tr>

<tr>
	<td>일정</td>
	<td>
		<select name="year">
		<% 
			for(int i=year-5; i<year+5; i++){
				%>
				<option value="<%=i%>" <%=year==i?"selected":"" %>><%=i%></option>
				<%
			}
		%>
		
		</select>년
		
		<select name="month">
		<%
			for(int i=1; i<=12; i++){
				%>
				<option value="<%=i%>" <%=month==i?"selected":"" %>><%=i%></option>
				<%
				
			}
		
		%>
		</select>월
		
		<select name="date">
		<%
			for(int i=1; i<=lastday; i++){
				%>
				<option value="<%=i%>" <%=date==i?"selected":"" %>><%=i%></option>
				<%
				
			}
		
		%>
		</select>월
		
		<select name="hour">
		<%
			for(int i=1; i<=24; i++){
				%>
				<option value="<%=i%>" <%=hour==i?"selected":"" %>><%=i%></option>
				<%
				
			}
		
		%>
		</select>시
		
		<select name="min">
		<%
			for(int i=1; i<=60; i++){
				%>
				<option value="<%=i%>" <%=min==i?"selected":"" %>><%=i%></option>
				<%
				
			}
		
		%>
		</select>분
		
	
	</td>
</tr>

<tr>
	<td>제목</td>
	<td><input type="text" name="title"></td>
</tr>

<tr>
	<td>내용</td>
	<td><textarea rows="10" cols="40" name="content"></textarea> </td>
</tr>
<tr>
	
	<td><input type="submit" value="작성완료"></td>
	<td><input type="button" value="작성취소" onclick="Controller.do?command=calendar"></td> 
	
</tr>

</table>
</form>
</body>
</html>