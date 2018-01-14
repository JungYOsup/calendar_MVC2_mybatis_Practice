﻿# calendar_MVC2_mybatis_Practice
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

# mybatis란
mybatis (orm= object relation mapping) 이라는 명칭을 지니고 있으며 객체 관계 연결 프레임워크라고 보면된다.
일단 mapping이라는것부터 이해해보자. 
mtbatis에서 mapping이란 DB에 있는 하나하나의 컬럼과 dto에 맴버필드에 있는것들을 매칭시키는 역할을 mybatis에서 알아서
처리를 해준다.

예를들어 설명하자면 Dao에서 결과값을  while문을 돌려서 
rs.getint(1) 이런식으로 하나하나씩 쿼리에서 결과값을 받고 dto에 전달했다면

```mybatis 적용전
//글 상세보기 기능:상세보기는 글하나에 대한 정보를 구하기때문에 유니크한 값 seq가 필요함	
	public YoungSangDto getBoard(int seq) {
		YoungSangDto dto = new YoungSangDto();
		Connection conn= null;
		PreparedStatement psmt = null;
		ResultSet rs=null;
		//DB연결할때 쓸 내용
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String user="HK";
		String password="HK";
		//쿼리 준비할때 쓸 내용
		String sql=" SELECT SEQ,ID,NAME,TITLE,CONTENT,REGDATE FROM BYUNGJUBOARD WHERE SEQ = ? ";
		
		try {
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("2단계 Connection(DB)연결 성공");
			
			psmt =conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("3단계 쿼리 준비성공");
			rs = psmt.executeQuery();
			System.out.println("4단계 쿼리 성공");
			
			while(rs.next()) {
				
				dto.setSeq(rs.getInt(1));
				dto.setId(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setTitle(rs.getString(4));
				dto.setContent(rs.getString(5));
				dto.setRegdate(rs.getDate(6));
				
			}
			System.out.println(dto); //dto받은값
			System.out.println("5단계성공");
								
		} catch (SQLException e) {
			System.out.println("쿼리 실행 실패");
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(psmt!=null) {
					psmt.close();
				}
				if(conn!=null) {
					conn.close();
				}
				System.out.println("6단계 성공");
			} catch (SQLException e) {
				System.out.println("6단계 실패");
				e.printStackTrace();
			}
```

이렇게 적용후에는 결과값을 객체로 받은다음 dto에 전달을 해주기만하면 알아서 dto의 파라미터에 적용시켜준다. 

```mybatis 적용후

//글 상세보기 기능:상세보기는 글하나에 대한 정보를 구하기때문에 유니크한 값 seq가 필요함	
	public YoungSangDto getBoard(int seq) {
		YoungSangDto dto = new YoungSangDto();
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto=sqlSession.selectOne(namespace+"detailboard", seq); //결과값으로 객체를 받음
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}

```

mapping을 하면서 좋은점은 ? 

우리가 DB에서 넘어온 결과값을 받을때 dto.set()이런식으로 하나하나씩 받았지만 그렇지 않고 객체를 dto에 전달하기 때문에 
뭄텅이로 받아서 코드가 간편해진다.

# mybatis 주의해야할점
````
SELECT SEQ,ID,NAME,TITLE,CONTENT,to_char(REGDATE,'YYYY-DD-MM hh24:mi:ss') FROM BYUNGJUBOARD WHERE SEQ =#{seq}
SELECT SEQ,ID,NAME,TITLE,CONTENT,to_char(REGDATE,'YYYY-DD-MM hh24:mi:ss') as Ajaxregdate FROM BYUNGJUBOARD  WHERE SEQ =#{seq}
````
의 둘이 차이점은 
첫번째의 경우 우리가 dao에서 결과값을 호출하고 받을때 dto의 맴버필드와 결과값의 칼럼명이 다를경우 값이 전달되지 않는다.
첫번째쿼리를 출력해보면 칼럼명이  SEQ,ID,NAME,TITLE,CONTENT,to_char(REGDATE,'YYYY-DD-MM hh24:mi:ss') 로 출력이 된다.
그렇기에 dto의 맴버필드와 칼럼명이 다를경우인것이다.

(그 이유는 mybatis에서는 이름이 같아야지만 mapping이 성립되어 알아서 값을 dto에 전달하는데(Mapping을 하면 dto.set()을 하지않아도 알아서 값을 넣어준다)
이름이 다를경우 성립하지 않아 이름이 같은값만 전달하고 그렇지 않은 맴버필드에는 값을 전달하지 못한다) 

두번째의 경우 우리가 dao에서 결과값을 호출하고 받을때 dto의 맴버필드와 결과값의 칼럼명이 같으므로 값이 전달된다 않는다.
(대소문자는 상관없다 즉 칼럼이 대문자고 맴버필드가 소문자여도 mybatis에서는 알아서 mapping을 해준다.)


			
		}
		
		
		
		return dto;
	}


