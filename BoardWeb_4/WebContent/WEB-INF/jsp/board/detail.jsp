<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<style>
.pointerCursor{cursor:pointer;}
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
	<div class="pointerCursor" onclick="toggleLike(${data.yn_like})">
		<c:choose>
		<c:when test="${data.yn_like != 0 }">
			<span class="material-icons" style="color:red;"> favorite </span>
		</c:when>
		<c:otherwise>
			<span class="material-icons"> favorite_border </span>
		</c:otherwise>
	</c:choose>
	</div>	
	<hr>
	<div>작성자 : ${data.nm}</div>
	<hr>
	<div>내용 : ${data.ctnt}</div>
	<hr>
	<div>작성일자 : ${data.r_dt}</div>
	<div>조회수 : ${data.hits}</div>
	<div>좋아요 개수 : ${data.count}</div>
	<script>
		function submitDel() {
			delFrm.submit()
		}
		
		function toggleLike(yn_like) {
			location.href ="/board/toggleLike?i_board=${data.i_board}&yn_like=" + yn_like;
		}
	</script>
</body>
</html>