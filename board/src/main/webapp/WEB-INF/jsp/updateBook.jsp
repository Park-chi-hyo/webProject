<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서수정</title>
<link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container py-4">
		<jsp:include page="/bookmarket/menu.do"/>
			<div class="p-5 mb-4 bg-body-tertiary rounded-3">
				<div class="container-fluid py-5">
					<h1 class="display-5 fw-bold">도서수정</h1>
					<p class="col-md-8 fs-4">Book Updating</p>
				</div>
			</div>
			<%@ include file="dbconn.jsp" %>
			<%
				String bookId = request.getParameter("id");
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "SELECT * FROM book WHERE b_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bookId);
				rs = pstmt.executeQuery();
				if(rs.next()){
			%>
			<div class="row align-items-md-stretch">
				<div class="col-md-5">
					<img alt="image" src="/images/<%=rs.getString("b_fileName")%>" style="width: 100%">
				</div>
				
				<div class="col-md-7">
					<form action="/bookmarket/processUpdateBook.do" name="newBook" method="post" enctype="multipart/form-data" class="form-horizontal">
					<div class="mb-3 row">
						<label class="col-sm-2">도서코드</label>
						<div class="col-sm-5">
							<input id="bookId" type="text" name="bookId" class="form-control" value='<%=rs.getString("b_id")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">도서명</label>
						<div class="col-sm-5">
							<input id="name" type="text" name="name" class="form-control" value='<%=rs.getString("b_name")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">가격</label>
						<div class="col-sm-5">
							<input id="unitPrice" type="text" name="unitPrice" class="form-control" value='<%=rs.getString("b_unitPrice")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">저자</label>
						<div class="col-sm-5">
							<input type="text" name="author" class="form-control" value='<%=rs.getString("b_author")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">출판사</label>
						<div class="col-sm-5">
							<input type="text" name="publisher" class="form-control" value='<%=rs.getString("b_publisher")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">출판일</label>
						<div class="col-sm-5">
							<input type="text" name="releaseDate" class="form-control" value='<%=rs.getString("b_releaseDate")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
		               <label class="col-sm-2">상세정보</label>
		               <div class="col-sm-5">
		                  <textarea id="description" name="description" rows="2" cols="50"
		                  class="form-control" placeholder="5자 이상 적어주세요" value='<%=rs.getString("b_description")%>'></textarea>
		               </div>
		            </div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">분류</label>
						<div class="col-sm-5">
							<input type="text" name="category" class="form-control" value='<%=rs.getString("b_category")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">재고수</label>
						<div class="col-sm-5">
							<input id="unitsInStock" type="text" name="unitsInStock" class="form-control" value='<%=rs.getString("b_unitsInStock")%>'>
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">상태</label>
						<div class="col-sm-8">
							<input type="radio" name="condition" value="New">신규도서
							<input type="radio" name="condition" value="Old">중고도서
							<input type="radio" name="condition" value="EBook">E-Book
						</div>
					</div>
					
					<div class="mb-3 row">
						<label class="col-sm-2">이미지</label>
						<div class="col-sm-8">
							<input type="file" name="bookImage" class="form-control">
						</div>
					</div>
					
					<div class="mb-3 row">
						<div class="col-sm-offset-2 col-sm-10">
							<input type="submit" class="btn btn-primary" value="등록">
						</div>
					</div>
				</form>
				</div>	
			</div>
			<%
				}
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			%>
			<jsp:include page="/bookmarket/footer.do"/> 
		</div>
</body>
</html>