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
<style>
.itemRow:hover {
	background-color: #7D9CB5;
	cursor: pointer;
}
</style>

</head>
<body>
	<div>게시판 리스트</div>
	<table>
		<tr>
			<th>No</th>
			<th>제목</th>
			<th>작성자</th>
		</tr>
		<% for (BoardVO vo : boardList) { %>
		<tr class="itemRow" onclick='moveToDetail(<%=vo.getI_board()%>)'>
			<td><%=vo.getI_board()%></td>
			<td><%=vo.getTitle()%></td>
			<td><%=vo.getI_student()%></td>
		</tr>
		<% } %>
	</table>
	<script>
		function moveToDetail(i_board) {
			console.log('moveToDetail - i_board :' + i_board);
			location.href = 'boardDetail?i_board=' + i_board;
		}
	</script>
</body>
</html>