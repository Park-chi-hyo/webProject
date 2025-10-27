package org.big.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.big.dao.BbsDao;
import org.big.dto.BbsDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class BbsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final int LISTCOUNT = 5; 
	
	@RequestMapping("/BoardListAction.do")
	public String listAction(HttpServletRequest request) throws ServletException, IOException {
		requestBoardList(request);
		return "/board/list";
	}
	
	@RequestMapping("/BoardWriteForm.do")
	public String writeForm(HttpServletRequest request) throws ServletException, IOException {
		requestLoginName(request);
		return "/board/writeForm";
	}
	
	@RequestMapping("/BoardWriteAction.do")
	public String writeAction(HttpServletRequest request) throws ServletException, IOException {
		requestBoardWrite(request);
		return "redirect:/BoardListAction.do";
	}
	
	/*
	 * @RequestMapping("/BoardViewAction.do") public String
	 * viewAction(HttpServletRequest request, HttpServletResponse response) throws
	 * ServletException, IOException { requestBoardView(request); return
	 * "redirect:/BoardView.do"; }
	 */
	
	@RequestMapping("/BoardViewAction.do")
	public String viewAction(HttpServletRequest request)
			throws ServletException, IOException {
		requestBoardView(request);
		return "/board/view";
	}
	 
	/*
	 * @RequestMapping("/BoardView.do") public String view(HttpServletRequest
	 * request, HttpServletResponse response) throws ServletException, IOException {
	 * return "/board/view"; }
	 */
	 
	
	@RequestMapping("/BoardUpdateAction.do")
	public String updateAction(HttpServletRequest request) throws ServletException, IOException {
		requestBoardUpdate(request);
		return "redirect:/BoardListAction.do";
	}
	
	@RequestMapping("/BoardDeleteAction.do")
	public String deleteAction(HttpServletRequest request) throws ServletException, IOException {
		requestBoardDelete(request);
		return "redirect:/BoardListAction.do";
	}
	
	public void requestBoardList(HttpServletRequest request){
			
		BbsDao dao = BbsDao.getInstance();
		ArrayList<BbsDto> boardlist = new ArrayList<BbsDto>();
		
	  	int pageNum=1;
		int limit=LISTCOUNT;
		
		if(request.getParameter("pageNum")!=null)
			pageNum=Integer.parseInt(request.getParameter("pageNum"));
				
		String items = request.getParameter("items");
		String text = request.getParameter("text");
		
		int total_record=dao.getListCount(items, text);
		boardlist = dao.getBoardList(pageNum,limit, items, text); 
		
		
		int total_page;
		
		if (total_record % limit == 0){     
	     	total_page =total_record/limit;
	     	Math.floor(total_page);  
		}
		else{
		   total_page =total_record/limit;
		   Math.floor(total_page); 
		   total_page =  total_page + 1; 
		}		
   
   		request.setAttribute("pageNum", pageNum);		  
   		request.setAttribute("total_page", total_page);   
		request.setAttribute("total_record",total_record); 
		request.setAttribute("boardlist", boardlist);								
	}
	
	public void requestLoginName(HttpServletRequest request){
					
		String id = request.getParameter("id");
		
		BbsDao  dao = BbsDao.getInstance();
		
		String name = dao.getLoginNameById(id);		
		
		request.setAttribute("name", name);									
	}
   
	public void requestBoardWrite(HttpServletRequest request){
					
		BbsDao dao = BbsDao.getInstance();		
		
		BbsDto board = new BbsDto();
		board.setId(request.getParameter("id"));
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));	
		
		System.out.println(request.getParameter("name"));
		System.out.println(request.getParameter("subject"));
		System.out.println(request.getParameter("content"));
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date()); 
		
		board.setHit(0);
		board.setRegist_day(regist_day);
		board.setIp(request.getRemoteAddr());			
		
		dao.insertBoard(board);								
	}
	
	public void requestBoardView(HttpServletRequest request){
					
		BbsDao dao = BbsDao.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BbsDto board = new BbsDto();
		board = dao.getBoardByNum(num, pageNum);		
		
		request.setAttribute("num", num);		 
   		request.setAttribute("page", pageNum); 
   		request.setAttribute("board", board);   									
	}
	
	public void requestBoardUpdate(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BbsDao dao = BbsDao.getInstance();		
		
		BbsDto board = new BbsDto();		
		board.setNum(num);
		board.setName(request.getParameter("name"));
		board.setSubject(request.getParameter("subject"));
		board.setContent(request.getParameter("content"));		
		
		 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		 String regist_day = formatter.format(new java.util.Date()); 
		 
		 board.setHit(0);
		 board.setRegist_day(regist_day);
		 board.setIp(request.getRemoteAddr());			
		
		 dao.updateBoard(board);								
	}
	
	public void requestBoardDelete(HttpServletRequest request){
					
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));	
		
		BbsDao dao = BbsDao.getInstance();
		dao.deleteBoard(num);							
	}	
}

