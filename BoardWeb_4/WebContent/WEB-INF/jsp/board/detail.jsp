<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<style>
</style>
</head>
<body>
	<div>
		<a href="/board/list">리스트</a>
		<c:if test="${loginUser.i_user == data.i_user }">
			<a href="regmod?i_board=${data.i_board}">수정</a>
			<form id="delFrm" action="/board/del" method="post">
				<input type="hidden" name="i_board" value="${data.i_board}">
				<a href="#" onclick="submitDel()">삭제</a>
			</form>
		</c:if>
	</div>
	<h3>제목 : ${data.title}</h3>
	<c:choose>
		<c:when test="${data.yn_like != 0 }">
			<p>💚</p>
		</c:when>
		<c:otherwise>
			<p>🖤</p>
		</c:otherwise>
	</c:choose>
	<hr>
	<div>작성자 : ${data.nm}</div>
	<hr>
	<div>내용 : ${data.ctnt}</div>
	<hr>
	<div>작성일자 : ${data.r_dt}</div>
	<div>조회수 : ${data.hits}</div>
	<script>
		function submitDel() {
			delFrm.submit()
		}
	</script>
</body>
</html>