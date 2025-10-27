<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="java.util.*, org.big.dto.*, org.big.dao.*" %>  

<%@ include file="dbconn.jsp" %>
<%
	String id = request.getParameter("id");
	if(id == null || id.trim().equals("")){
		response.sendRedirect("/bookmarket/books.do");
		return;
	}
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	Book book = null;
    
    try{
    	String sql = "SELECT * FROM book WHERE b_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
    	
    	if(rs.next()){
        	book = new Book();
        	book.setBookId(rs.getString("b_id"));
            book.setName(rs.getString("b_name"));
            book.setUnitPrice(rs.getInt("b_unitPrice"));
            book.setAuthor(rs.getString("b_author"));
            book.setPublisher(rs.getString("b_publisher"));
            book.setReleaseDate(rs.getString("b_releaseDate"));
            book.setDescription(rs.getString("b_description"));
            book.setCategory(rs.getString("b_category"));
            book.setUnitsInStock(rs.getInt("b_unitsInStock"));
            book.setCondition(rs.getString("b_condition"));
            book.setFilename(rs.getString("b_filename"));
        }
    }catch(SQLException e){
    	e.getMessage();
    }finally{
    	if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
    }

    if (book == null) {
        response.sendRedirect("exceptionNoBookId.jsp");
        return;
    }
	
	ArrayList<Book> list = (ArrayList<Book>) session.getAttribute("cartlist");
	if(list == null){
		list = new ArrayList<Book>();
		session.setAttribute("cartlist", list);
	}
	
	int cnt = 0;
	Book goodsQnt = new Book();
	
	for(int i = 0; i<list.size(); i++) {
		goodsQnt = list.get(i);
		if(goodsQnt.getBookId().equals(id)){
			cnt++;
			int orderQuantity = goodsQnt.getQuantity() + 1;
			goodsQnt.setQuantity(orderQuantity);
			break;
		}
	}

	if(cnt == 0){
		book.setQuantity(1);
		list.add(book);
	}
	
	response.sendRedirect("/bookmarket/cart.do");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>