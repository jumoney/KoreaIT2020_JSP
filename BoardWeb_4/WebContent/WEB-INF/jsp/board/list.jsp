<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.pjt.vo.BoardVO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style>
table {
	border-collapse: collapse;
	text-align: center;
}

table th, td {
	width: 100px;
}
.itemRow:hover {
	background-color: #7D9CB5;
	cursor: pointer;
}
#err{
	color:red;
}
</style>
</head>
<body>
	<div>${loginUser.nm}님 환영합니다.<a href="/logout">로그아웃</a><div>
	<c:if test="${err == 1}">
		<div id="err">삭제에 실패했습니다.</div>
	</c:if>
	<div>
		<a href="/board/regmod">글등록</a>
	</div>
	<h1>리스트</h1>
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>글쓴이</th>
			<th>개시일자</th>
		</tr>
		<c:forEach items="${list}" var="item">
		<tr class="itemRow" onclick='moveToDetail(${item.i_board})'>
			<td>${item.i_board}</td>
			<td>${item.title}</td>
			<td>${item.hits}</td>
			<td>${item.nm}</td>
			<td>${item.r_dt}</td>
		</tr>
		</c:forEach>
	</table>
	<script>
		function moveToDetail(i_board) {
			console.log('moveToDetail - i_board :' + i_board);
			location.href = '/board/detail?i_board=' + i_board;
		}
	</script>

</body>
</html>