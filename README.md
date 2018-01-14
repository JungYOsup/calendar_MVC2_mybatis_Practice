# calendar_MVC2_mybatis_Practice
켈린더_MVC2_mybatis_연습
자바에서는 다음페이지로 전달하는 방법이 있다.   
우리가 jsp에서는 값을 안 담고 이동할때 스크립트를 쓰거나,respond.sendRedrirect를 썻고 , 값을 담을때는  request.setAttribute를 써서 객체를 담고 PageContext.forward를 썻다.   
그러나 지금은 자바파일이기때문에 pageContext가 안되므로 다른방법으로 값을 담아서 이동해야한다. 
그 방법이         

##### 코드
```java
request.setAttribute("lists", lists);   //전달할객체를 담고
RequestDispatcher dispatch = request.getRequestDispatcher("listboard.jsp");  //getRequestDispatcher("url") 
dispatch.forward(request, response);

```
