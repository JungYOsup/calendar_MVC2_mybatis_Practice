package com.hk.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hk.dto.Dto;

public class Dao extends SqlMapConfig{
	
	
	private String namespace ="com.hk.calboard.";
	
	public Dao() {
		
	}
	
	//일정추가(insert문)
	//일정 추가해줄때 필요한게 성공여부로만 판단하기 위해 boolean으로 리턴타입을 해주고
	//파라미터로는 여러개를 받아야하므로 dto를 받자 
	public boolean insertCalBoard(Dto dto) {
		
		int count =0;
		
		SqlSession sqlSession = null;
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true); //autocommit이 되게끔
			
			count = sqlSession.insert(namespace+"insertboard",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
				
		return count>0?true:false;
		
	}
	
	
	//일정목록조회(select문ㅡlist)
	public List<Dto> selectBoard(String id , String yyyyMMdd){
		Map<String, String> map = new HashMap<String,String>();
		List<Dto> list = null;
		SqlSession sqlSession = null;
		
		map.put("id", id);
		map.put("yyyyMMdd",yyyyMMdd);
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(namespace+"calllist", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return list;
		
	}
	//mybatis(orm object relation mapping을 한다 DB와 )는 객체를 전달한다. 와 JDBC의 차이
	//일정상세조회(select문,반환 CalDto)
	public Dto selectdetail(int seq) {
		Dto dto = null;
		/*Dto dto = new Dto(); 위에꺼와 밑에것을 썻을때의 차이점*/
		//엄청난 차이점이 잇다. 결과값이 객체로 넘어오는데 dto를 객체로 생성해서 만들경우 기존에 연결했던것을 끊고 넘어오는 객체와 연결되므로
		//연결이 끊어진 객체가 메모리에 남으므로 비효율적이다. 
		
		//우리는 JDBC에서는 객체를 만들어서 값을 받아왔는데 , Mybatis는 결과값이 객체로넘어오므로 Dto dto = new Dto()라고 할 필요가 없이
		//Dto dto = null로 해주면 된다.
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("seq", seq);
		SqlSession sqlSession = null;
		
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(namespace+"seldetail",map); //여기서 결과값이 객체로 넘어온다.
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
						
		return dto;
		
		
	}
	
	//일정수정하기(update문)
	public boolean updateBoard(Dto dto) {
		SqlSession sqlSession = null;
		int count =0;
		Map<String, Dto > map = new HashMap<String, Dto>();
		map.put("dto", dto);
		
		try {
			sqlSession=getSqlSessionFactory().openSession(true);
			count = sqlSession.update(namespace+"updateboard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
				
	}
	
	//일정삭제하기(delete문)
	public boolean deleteBoard(String[] seq) {
		
		SqlSession sqlSession = null;
		int count =0;
		Map<String, String[]> map = new HashMap<String,String[]>();
		
		map.put("seq", seq);
		
		try {
			sqlSession = getSqlSessionFactory().openSession(false);
			count = sqlSession.delete("muldel",map);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return count>0?true:false;
		
		
		
	}
}
