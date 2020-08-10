<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	String msg = "";
	String err = request.getParameter("err");

	if (err != null) {
		switch (err) {
			case "10":
				msg = "등록할 수 없습니다.";
				break;
			case "20":
				msg = "DB 에러 발생";
				break;
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기페이지</title>
<style>
	#msg{ color: red;}
</style>
</head>
<body>
	<div>
		<div>
			<a href="boardList">리스트로 가기</a>
		</div>
		<div id = "msg"><%= msg %></div>
		<form id="frm" action="/boardWrite" method="post" onsubmit="return chk()">
			<div>
				<label>제목 : <input type="text" name="title"></input></label>
			</div>
			<div>
				<label>내용 : <textarea name="ctnt"></textarea></label>
			</div>
			<div>
				<label>작성자 : <input type="text" name="i_student"></input></label>
			</div>
			<div>
				<input type="submit" value="글등록">
			</div>
			</form>
	</div>
	<script>
	function eleVaild(ele, nm) {
		if(ele.value.length == 0) {
			alert(nm + "을(를) 입력해 주세요.");
			ele.focus()
			return true;
		}
	}
	
	function chk() {
		//console.log(`title: \${frm.title.value}`);
		if(eleVaild(frm.title, '제목')) {
			return false;
		} else if(eleVaild(frm.ctnt, '내용'))  {
			return false; 
		} else if(eleVaild(frm.i_student, '작성자')) {
			
			return false; 
		}
	}
	</script>
	
</body>
</html>