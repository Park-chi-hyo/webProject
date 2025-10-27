<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.sql.*" %>
<%@ page import="org.big.dto.Book" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<%
	String cartId = session.getId();
%>

<%-- <%=cartId %> --%>
</head>
<body>
	<div class="container py-4">
	<%@ include file="dbconn.jsp" %>
	<jsp:include page="/bookmarket/menu.do" />
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">장바구니</h1>
				<p class="col-md-8 fs-4">Cart</p>
			</div>
		</div>
		
		<div class="row align-items-md-stretch">
			<div class="row">
				<table width = "100%">
					<tr>
						<td align="left">
							<a href="/bookmarket/deleteCart.do?cartId=<%=cartId%>" class="btn btn-danger">삭제하기</a>
						</td>
						<td align="right">
							<a href="/bookmarket/shippingInfo.do?cartId=<%=cartId %>" class="btn btn-success">주문하기</a>
						</td>
					</tr>
				</table>
			</div>
		
			<div style="padding-top: 50px">
				<table class="table table-hover">
					<tr>
						<th>상품</th>
						<th>가격</th>
						<th>수량</th>
						<th>소계</th>
						<th>비고</th>
					</tr>
				<%
					int sum = 0;
					ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
					
					if (cartList == null){
						cartList = new ArrayList<Book>();
					}
					
					for (int i = 0; i < cartList.size(); i++) { 						
						Book book = cartList.get(i);
						String bookId = book.getBookId();
						
						if(bookId != null && !bookId.equals("")){
							String sql = "SELECT * FROM book WHERE b_id = ?";
							PreparedStatement pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, bookId);
							ResultSet rs = pstmt.executeQuery();
							  
							if(rs.next()){
								int total = rs.getInt("b_unitPrice") * book.getQuantity();
	                            sum += total;
				%>
				<tr>
					
					<td><%=book.getBookId()%> - <%=book.getName()%></td>
					<td><%=book.getUnitPrice()%></td>
					<td><%=book.getQuantity()%></td>
					<td><%=total%></td>
					<td><a href="/bookmarket/removeCart.do?id=<%=book.getBookId()%>" class="badge text-bg-danger">삭제</a></td>
				</tr>
				<%
							}	
						}
					}
					
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>

				<a href="/bookmarket/books.do" class="btn btn-secondary">
					&laquo; 쇼핑 계속하기
				</a>
			</div>
		</div>
		<jsp:include page="/bookmarket/footer.do" />
	</div>
</body>
</html>











