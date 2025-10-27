<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ page import="java.sql.*" %> 
<%@ page errorPage="exceptionNoBookId.jsp" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서정보</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
	function addToCart() {
		if (confirm("도서를 장바구니에 추가하시겠습니까?")) {
			document.addForm.submit();
		} else {
			document.addForm.reset();
		}
	}
</script>
</head>
<body>
	<div class="container py-4">
	<%@ include file="dbconn.jsp" %>
	 <jsp:include page="/bookmarket/menu.do" />
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">도서정보</h1>
				<p class="col-md-8 fs-4">BookInfo</p>
			</div>
		</div>
		<%
			String id = request.getParameter("id");
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT * FROM book WHERE b_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
		%>
		
		<div class="row align-items-md-stretch">
			<div class="col-md-5">
				<img alt="image.jsp" src="/images/<%=rs.getString("b_fileName") %>" style="width:70%">
			</div>
		
			<div class="col-md-6">
				<h3><b><%=rs.getString("b_name") %></b></h3>
				<p><%=rs.getString("b_description") %>
				<p><b>도서코드 : </b><span class="badge text-bg-danger"><%=rs.getString("b_id") %></span>
				<p><b>저자 : </b><%=rs.getString("b_author") %>
				<p><b>출판사 : </b><%=rs.getString("b_publisher") %>
				<p><b>출판일 : </b><%=rs.getString("b_releaseDate") %>
				<p><b>분류 : </b><%=rs.getString("b_category") %>
				<p><b>재고수 : </b><%=rs.getString("b_unitsInStock") %>
				<h4><%=rs.getString("b_unitPrice") %>원</h4>
				<p><form name="addForm" action="/bookmarket/addCart.do?id=<%=rs.getString("b_id")%>" method="post">
				<p><a href="#" class="btn btn-info" onclick="addToCart()">도서주문 &raquo;</a>
				<a href="/bookmarket/cart.do" class="btn btn-warning">장바구니 &raquo;</a>
				<a href="/bookmarket/books.do" class="btn btn-secondary">도서목록 &raquo;</a>
					</form>
			</div>
		<%
			}
			
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		%>
			
		</div>
		<jsp:include page="/bookmarket/footer.do" />
	</div>
</body>
</html>