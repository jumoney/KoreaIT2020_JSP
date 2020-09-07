<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="secrtionContainerCenter">
	<div>
		<form id="frm" class="frm" action="joinProc" method="POST">
			<div>
				<input type="text" name="user_id" placeholder="아이디">
			</div>
			<div>
				<input type="password" name="user_pw" placeholder="비밀번호">
			</div>
			<div>
				<input type="password" name="user_pwre" placeholder="비밀번호 확인">
			</div>
			<div>
				<input type="submit" value="회원가입">
			</div>
		</form>
		<div>
			<a href="/user/login">로그인</a>
		</div>
	</div>
</div>
