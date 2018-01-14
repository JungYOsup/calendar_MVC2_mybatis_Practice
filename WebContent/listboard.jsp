<!--- 페이지 디렉티브<%--  <%@page %> --%> : JSP페이지에 대한 설정 정보를 지정 -->
<!--인코딩은 UTF-8이고 , html이다.  -->
<!--이렇게 3가지를 구성해줘야지 한글이 안깨짐  -->
<%@page import="com.hk.dto.Dto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%request.setCharacterEncoding("utf-8"); %> 
<%response.setContentType("text/html; charset=UTF-8"); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> HTML4버전     --> 
<!DOCTYPE html> <!--HTML5로 버전을 지정해줌 -->
<%-- <%

	List<Dto> lists = (List<Dto>) request.getAttribute("lists"); // 값이 String형태로 넘어오기때문에 형변환을 해줘야한다
%> --%>

<!--이 페이지 에서는 JSTL과 EL테그로써 적용해보곘다.  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>일정목록보기</h1>

<table border="1">
	<tr>
		<th>번호</th>
		<th>제목</th>		
		<th>일정</th>
		<th>작성일</th>
	</tr>
	
		
	<c:choose><!--c테그의   c:if테그가 있지만 if테그는 else를 쓸수가 없어서 when테그를 쓴것이다. 내가 밑에처럼 c:if테르를 <>안에 넣을경우 주석오류뜨므로 조심하자 그리고 주석은 옆에쓰고 테그밑에 주석을 달경우 오류뜸-->
		<c:when test="${empty lists}"> <!--if()에서 ()가 테스트라고 보면 되겠다. , 리스트에 아무것도 없을경우  --> 
		
		
			<tr>
				<td colspan="4">---일정이 없습니다.---</td>
			</tr>
		
		</c:when>
		
		<c:otherwise><!--else의 역할  -->
			
			<c:forEach items="${lists}" var="dto"><!--var:현재 아이템의 변수명 items:반복데이터가 잇는 아이템 Collection명(Collection이란 같은 타입의 참조값을 여러개 저장하기 위한 자바 라이브러리이다.
			list,set,map)  lists가 변수 dto에 하나씩 꺼내져서 들어감 , 향상된 for문을 생각하자  for(Dto dto : lists)와 같은-->
				<tr>
					<td>${dto.seq}</td>
					<td>${dto.title}</td>
					<td>${dto.mDate}</td>
					<td>${dto.regDate}</td>
				</tr>
			
			</c:forEach>
		
		</c:otherwise>
	
	</c:choose>
	




</table>


</body>
</html>