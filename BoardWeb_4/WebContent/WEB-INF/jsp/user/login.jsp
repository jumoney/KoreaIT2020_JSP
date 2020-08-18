<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
.err { color:red}
</style>
</head>
<body>
	<h1>로그인</h1>
	<div class="err">${msg}</div>
	<div>
		<form action="/login" method="post">
			<div>
				<input type="text" name="user_id" palceholder="아이디" value="${user_id}">
			</div>
			<div>
				<input type="password" name="user_pw" palceholder="비밀번호">
			</div>
			<div>
				<input type="submit" value="로그인">
			</div>
		</form>

	</div>
</body>
</html>