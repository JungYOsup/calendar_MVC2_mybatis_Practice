package com.hk.cont;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hk.dao.Dao;
import com.hk.dto.Dto;
import com.hk.util.Util;

@WebServlet("/Controller.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html charset=utf-8");
		
		String command = request.getParameter("command");
		Dao dao = new Dao();
		
		if(command.equals("calendar")) {
			
			response.sendRedirect("calendar_practice.jsp");					
		}else if(command.equals("insertboard")) {
			
			String id = request.getParameter("id");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");
			String hour = request.getParameter("hour");
			String min = request.getParameter("min");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			String mDate = year + Util.change(month) + Util.change(date) +Util.change(hour) + Util.change(min);
			
			boolean isS = dao.insertCalBoard(new Dto(id,title,content,mDate));
			
			if(isS) {
				response.sendRedirect("Controller.do?command=calendar");	
			}else {
				response.sendRedirect("Controller.do?command=calendar");
			}
			
			
		}else if(command.equals("callist")) {
			
			//그날의 리스트는 내가 선택한 ,id와,년도의 월과 일로써 쿼리에서  찾아서 가져오면 될것이다. 그런데 굳이 년도 월 일 만필요하므로 시간과 나머지로 찾을 필요는 없을것인데
			//데이터 베이스에 MDate는 년도월일시간분초로 되어있으므로 잘라서 쿼리에 전달해서 결과값을 받으면 될것같다.
			List<Dto> lists = null;
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String date = request.getParameter("date");
			
			String yyyyMMdd = year + Util.change(month) + Util.change(date);
			
			lists=dao.selectBoard("hk", yyyyMMdd); //결과값이 객체로 넘어오기 때문에 굳이 List<Dto> lists = new List<Dto>(); 굳이 객체를 만들필요가 없다
			//tip) int a = 0 에서 a 는 변수 하지만 (변수는 값을 담는애) Dto dto = new Dto()에서 dto는 객체(주소를 받는애)
			
			
			//자바에서는 다음페이지로 전달하는 방법이 있다. 
			//우리가 jsp에서는 값을 안 담고 이동할때 스크립트를 쓰거나,respond.sendRedrirect를 썻고 , 값을 담을때는  request.setAttribute를 써서 객체를 담고 PageContext.forward를 썻다.
			//그러나 지금은 자바파일이기때문에 pageContext가 안되므로 다른방법으로 값을 담아서 이동해야한다. 그 방법이 
			
			
			request.setAttribute("lists", lists);
			RequestDispatcher dispatch = request.getRequestDispatcher("listboard.jsp");
			dispatch.forward(request, response);
			
		}
		
	}

}
