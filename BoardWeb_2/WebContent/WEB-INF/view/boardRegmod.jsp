<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	String msg = (String)request.getAttribute("msg");
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
<title>${data == null? '글등록' : '글수정' }</title>
</head>
<body>
   <div>                              
      <form id="frm" action="/${data == null? 'boardWrite' : 'boardMod' }" method="post" onsubmit="return chk()">   
      <div>${msg}</div>
         <input type = "hidden" name ="i_board" value="${data.i_board }">
         <div><label>제목: <input type="text" name="title" value="${data.title }"></label></div>
         <div><label>내용: <textarea name="ctnt">${data.ctnt }</textarea></label></div>
         <div><label>작성자: <input type="text" name="i_student" value="${data.i_student}"${data.i_student == null ? '': 'readonly'}></label></div>
         <div><input type="submit" value="${data == null? '글등록' : '글수정' }"></div>
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