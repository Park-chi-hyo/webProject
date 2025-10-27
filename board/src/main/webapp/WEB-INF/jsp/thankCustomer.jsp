<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*, org.big.dto.*, java.util.*" %>

<%
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_shippingDate = "";
	String shipping_country = "";
	String shipping_zipCode = "";
	String shipping_addressName = "";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null){
		for(int i = 0; i < cookies.length; i++){
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if(n.equals("Shipping_cartId")){
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
			if(n.equals("Shipping_Date")){
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()), "utf-8");
			}
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container py-4">
	<jsp:include page="/bookmarket/menu.do" />
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">주문완료</h1>
				<p class="col-md-8 fs-4">Order Completed</p>
			</div>
		</div>
		
		<div class="row align-items-md-stretch">
			<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
			<p> 주문은 <%out.println(shipping_shippingDate); %>에 배송될 예정입니다.
			<p> 주문번호 <%out.println(shipping_cartId); %>
		</div>
		
		<div class="container">
			<p> <a href="/bookmarket/books.do" class="btn btn-secondary">&laquo;도서목록</a>
		</div>
		<jsp:include page="/bookmarket/footer.do" />
	</div>
</body>
</html>

<%
	session.removeAttribute("cartlist");

	for(int i = 0; i < cookies.length; i++) {
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if(n.equals("Shipping_cartId")){
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shipping_name")){
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shipping_Date")){
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shipping_country")){
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shipping_zipCode")){
			thisCookie.setMaxAge(0);
		}
		if(n.equals("Shipping_addressName")){
			thisCookie.setMaxAge(0);
		}
		
		response.addCookie(thisCookie);
	}
%>









