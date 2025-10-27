<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서등록</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/js/validation.js"></script>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="org.big.bundle.message">
		<div class="container py-4">
		<jsp:include page="/bookmarket/menu.do"/>
			<div class="p-5 mb-4 bg-body-tertiary rounded-3">
				<div class="container-fluid py-5">
					<h1 class="display-5 fw-bold"><fmt:message key="title"/></h1>
					<p class="col-md-8 fs-4">Book Addition</p>
				</div>
			</div>
			
			<div class="row align-items-md-stretch">
				<div class="text-end">
					<a href="?language=ko">Korean</a> | <a href="?language=en">English</a>
					<a href="/bookmarket/logout.do" class="btn btn-sm btn-success pull right">logout</a>	
				</div>
				<form action="/bookmarket/processAddBook.do" name="newBook" method="post" enctype="multipart/form-data" class="form-horizontal">
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="bookId"/></label>
						<div class="col-sm-3">
							<input id="bookId" type="text" name="bookId" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="name"/></label>
						<div class="col-sm-3">
							<input id="name" type="text" name="name" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="unitPrice"/></label>
						<div class="col-sm-3">
							<input id="unitPrice" type="text" name="unitPrice" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="author"/></label>
						<div class="col-sm-3">
							<input type="text" name="author" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="publisher"/></label>
						<div class="col-sm-3">
							<input type="text" name="publisher" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="releaseDate"/></label>
						<div class="col-sm-3">
							<input type="text" name="releaseDate" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
		               <label class="col-sm-2"><fmt:message key="description"/></label>
		               <div class="col-sm-5">
		                  <textarea id="description" name="description" rows="2" cols="50"
		                  class="form-control" placeholder="5자 이상 적어주세요"></textarea>
		               </div>
		            </div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="category"/></label>
						<div class="col-sm-3">
							<input type="text" name="category" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="unitsInStock"/></label>
						<div class="col-sm-3">
							<input id="unitsInStock" type="text" name="unitsInStock" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="condition"/></label>
						<div class="col-sm-5">
							<input type="radio" name="condition" value="New"> <fmt:message key="condition_New"/>
							<input type="radio" name="condition" value="Old"> <fmt:message key="condition_Old"/>
							<input type="radio" name="condition" value="EBook"> <fmt:message key="condition_Ebook"/>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2"><fmt:message key="bookImage"/></label>
						<div class="col-sm-5">
							<input type="file" name="bookImage" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="button" class="btn btn-primary" value="<fmt:message key="button"/>" onclick="checkAddBook()">
						</div>
					</div>
				</form>	
			</div>
			<jsp:include page="/bookmarket/footer.do"/> 
		</div>
	</fmt:bundle>
</body>
</html>

