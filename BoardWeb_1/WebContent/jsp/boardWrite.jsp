<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.web.BoardVO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기페이지</title>
<style>
</style>
</head>
<body>
	<div>
		<div>
			<a href="/jsp/boardList.jsp">리스트로 가기</a>
		</div>
		<form action="/jsp/boardWriteProc.jsp" method="post">
			<div>
				<label>제목 : <input type="text" name="title"></input></label>
			</div>
			<div>
				<label>내용 : <textarea name="ctnt"></textarea></label>
			</div>
			<div>
				<label>글쓴이 : <input type="text" name="i_student"></input></label>
			</div>
			<div>
				<input type="submit" value="글등록">
			</div>
	</div>
	</form>
</body>
</html>