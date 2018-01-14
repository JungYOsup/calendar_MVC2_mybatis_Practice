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
<style type="text/css">
#calendar{border:1px solid gray; border-collapse: collapse;}
#calendar th{width: 80px; border: 1px solid gray;}
#calendar td{width: 80px; height: 80px; border: 1px solid gray; text-align: left; vertical-align: top;}

a{text-decoration: none;}
	
img{
	width: 25px;
	height: 25px;
}
</style>
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String paramYear=request.getParameter("year");
	String paramMonth=request.getParameter("month");
	//달력이 어떤식으로 구성되어잇는지 잘생각해보자
	
	Calendar cal = Calendar.getInstance(); // 자바의 Calenear api 사용
	
	int year = cal.get(Calendar.YEAR); //현재년도를 가지고온다.
	int month = cal.get(Calendar.MONTH)+1; //컴퓨터는 Month를 0부터 11로 생각하기므로 우리가 보기 편하도록 +1을 해준다.
	
	if(paramYear!=null){
		year = Integer.parseInt(paramYear);
	}
	if(paramMonth!=null){
		month = Integer.parseInt(paramMonth);
	}
	if(month>12){
		month=1;
		year++;
	}
	if(month<1){
		month=12;
		year--;
	}
		
	//월의 마지막날 구하기
	int lastday =cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	cal.set(year, month-1, 1);
	
	int dayofWeek = cal.get(Calendar.DAY_OF_WEEK); //1일의 요일을 구함
	

%>
<%!

	public String method(int i){
		String str="";
		
		if(i==0){
			str="blue";
			
		}else if(i==1){
			str="red";
			
		}else{
			str="black";
		}
		
				
		return str;
	}
%>
<body>

<h1>일정보기</h1>
<table id="calendar">
	<caption>
		<a href="calendar_practice.jsp?year=<%=year-1%>&month=<%=month%>">◁</a>
		<a href="calendar_practice.jsp?year=<%=year%>&month=<%=month-1%>">◀</a>
		<span><%=year%></span>년<span><%=month%></span>월<span>
		<a href="calendar_practice.jsp?year=<%=year%>&month=<%=month+1%>">▶</a>
		<a href="calendar_practice.jsp?year=<%=year+1%>&month=<%=month%>">▷</a>
	
	</caption>
	
	<tr>
		<td>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td>토</td>
	</tr>
	<tr>
		<%
			//공백을구함
			for(int i=0; i<dayofWeek-1; i++){
				out.print("<td>&nbsp;</td>"); //out.print는  jsp파일에서 자바코드로 화면에 보여주기 위해쓴다.
			}
		%>
		<%
			for(int i=1; i<=lastday; i++){
				
				%>
				<td>
				<a href="Controller.do?command=callist&year=<%=year%>&month=<%=month%>&date=<%=i%>" style="color:<%=method((dayofWeek-1+i)%7)%>"><%=i%></a>
				<a href="insertboard.jsp?year=<%=year%>&month=<%=month%>&date=<%=i%>&lastday=<%=lastday%>">
				<img alt="사진" src="img/pen.png"></a>
				</td>
				<%
			if((dayofWeek-1+i)%7==0){
				
				out.print("</tr><tr>");
			}
				
			}
			
			for(int i=0; i<(7-(dayofWeek-1+lastday)%7)%7; i++){
				
				out.print("<td>&nbsp;</td>");
			}
			
		
		%>
		
	</tr>
	


</table>

</body>
</html>