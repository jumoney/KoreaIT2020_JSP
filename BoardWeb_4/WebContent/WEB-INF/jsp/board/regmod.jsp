<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${data == null ? '등록':'수정'}</title>
</head>
<body>
	<div>
		<form id="frm" action="regmod" method="post" onsubmit="return chk()">
			<input type="hidden" name="i_board" value="${data.i_board}">
			<div>제목:<input type="text" name="title" value="${data.title }"></div>
			<div>내용:<textarea name="ctnt">${data.ctnt }</textarea></div>
			<div><input type="submit" value="등록"></div>
		</form>
	</div>
</body>
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
		if(frm.title.value > 100){
			alert('제목이 너무 깁니다.');
		}
		if(frm.ctnt.value > 2000){
			alert('내용이 너무 깁니다.');
		}
	}
	
	</script>
</html>