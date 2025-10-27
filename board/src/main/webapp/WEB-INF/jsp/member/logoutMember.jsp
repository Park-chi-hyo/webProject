<%@ page contentType="text/html; charset=utf-8"%>
<%
	session.invalidate();
	response.sendRedirect("/bookmarket/member/loginMember.do");
%>