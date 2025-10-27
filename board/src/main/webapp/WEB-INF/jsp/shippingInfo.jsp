<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container py-4">
	<jsp:include page="/bookmarket/menu.do" />
	
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">배송 정보</h1>
				<p class="col-md-8 fs-4">Shipping Info</p>
			</div>
		</div>
		
		<div class="row align-items-md-stretch">
			<form action="/bookmarket/processShippingInfo.do" method="post">
				<input type="text" name="cartId" value="<%=request.getParameter("cartId")%>">
				
				<div class="mb-3 row">
					<label class="col-sm-2">성명</label>
					<div class="col-sm-3">
						<input type="text" name="name" class="form-control">
					</div>
				</div>
				
				<div class="mb-3 row">
					<label class="col-sm-2">배송일</label>
					<div class="col-sm-3">
						<input type="text" name="shippingDate" class="form-control">(yyyy/mm/dd)
					</div>
				</div>
				
				<div class="mb-3 row">
					<label class="col-sm-2">국가명</label>
					<div class="col-sm-3">
						<input type="text" name="country" class="form-control">
					</div>
				</div>
				
				<div class="mb-3 row">
					<label class="col-sm-2">우편번호</label>
					<div class="col-sm-3">
						<input type="text" name="zipCode" class="form-control">
					</div>
				</div>
				
				<div class="mb-3 row">
					<label class="col-sm-2">주소</label>
					<div class="col-sm-5">
						<input type="text" name="addressName" class="form-control">
					</div>
				</div>
				
				<div class="mb-3 row">
					<div class="col-sm-offset-2 col-sm-10">
						<a href="/bookmarket/cart.do?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button">이전</a>
						<input type="submit" value="등록" class="btn btn-primary">
						<a href="/bookmarket/checkOutCancelled.do" class="btn btn-secondary" role="button">취소</a>
					</div>
				</div>
			</form>	
		</div>
		<jsp:include page="/bookmarket/footer.do" />
	</div>
</body>
</html>









