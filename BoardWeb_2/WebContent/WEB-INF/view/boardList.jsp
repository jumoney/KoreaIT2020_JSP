<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.board.vo.BoardVO"%>

<%
	List<BoardVO> boardList = (List)request.getAttribute("data");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>게시판 리스트</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
		</tr>
		<% for (BoardVO vo : boardList) { %>
		<tr>
			<th><%=vo.getI_board()%></th>
			<th><a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()%>">
					<%=vo.getTitle()%>
			</a></th>
		</tr>
		<% } %>
	</table>
</body>
</html>