<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.koreait.web.BoardVO"%>
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
<%!   
   public Connection getCon() throws Exception {
      String url = "jdbc:oracle:thin:@localhost:1521:orcl";
      String userName = "hr";
      String password = "koreait2020";
      
      Class.forName("oracle.jdbc.driver.OracleDriver");
      Connection con = DriverManager.getConnection(url, userName, password);
      System.out.println("접속성공!");
      return con;
   }
%>
<%
   String strI_board = request.getParameter("i_board");
   if(strI_board == null){                              
%>
   <script>
      alert('잘못된 접근입니다.');
      location.href='/jsp/boardList.jsp';
   </script>
<%
      return;
   }                                                
   int i_board = Integer.parseInt(strI_board);
                                                   
   String sql = "SELECT title, ctnt, i_student FROM t_board where i_board = ?" ;
   //String sql = "SELECT title, ctnt, A.i_student, nm FROM t_board A inner join t_student B on A.I_student=B.I_student where i_board="+ strI_board;  //조인
   
   Connection con = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   
   BoardVO vo = new BoardVO();
   //String nm=null;
   
   try{
      con = getCon();
      ps = con.prepareStatement(sql);            //쿼리문 ? 에 주입할 수 있음.(쿼리문에서 직접 + 해도 되지만 많아지면 가독성 떨어짐.)
      //ps.setInt(1,3);                     //쿼리문에 값을 넣기. (1번째 ?에 3을 넣는다)
      ps.setInt(1,i_board);         //strI_board를 정수형으로 바꿔서 쿼리문 1번째 ?에 주입.
      //setString은 문자열 양끝에 자동으로 홑따옴표('') 넣어줌.
      
      rs = ps.executeQuery();                  //완성된 쿼리문 실행
      
      
      while(rs.next()){                     //0줄일수도 있으니까 while이나 if(rs.next()){} 의 조건으로 확인을 해줘야 에러가 안터짐.(여러줄일때는 while을 써야 여러줄 다 받아옴)
         String title = rs.getNString("title");   //getString과 똑같지만 getString은 에러날 가능성이 아주야아아악간 있다(톰캣에서 어떤 기능을 끄면...). getNString은 안전.
         String ctnt = rs.getNString("ctnt");   
         int i_student = rs.getInt("i_student");
         //nm = rs.getNString("nm");
         vo.setI_board(i_board);
         vo.setTitle(title);
         vo.setCtnt(ctnt);
         vo.setI_student(i_student);
      }
   }catch(Exception e){
      e.printStackTrace();
   } finally {   
      if(rs!=null) { try{ rs.close(); }catch(Exception e){} }            
      if(ps!=null) { try{ ps.close(); }catch(Exception e){} }            
      if(con!=null) { try{ con.close(); }catch(Exception e){} }
   }
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정페이지</title>
<style>
	#msg{ color: red;}
</style>
</head>
<body>
	<div>
		<div>
			<a href="/jsp/boardList.jsp">리스트로 가기</a>
		</div>
		<div id = "msg"><%= msg %></div>
		<form id="frm" action="/jsp/boardModProc.jsp" method="post" onsubmit="return chk()">
			<div>
				<label>제목 : <input type="text" name="title" value="<%=vo.getTitle()%>"></input></label>
			</div>
			<div>
				<label>내용 : <textarea name="ctnt"><%=vo.getCtnt()%></textarea></label>
			</div>
			<div>
				<label>글쓴이 : <input type="text" name="i_student" value="<%=vo.getI_student()%>"></input></label>
			</div>
			<div>
				<input type="submit" value="글수정">
			</div>
			<input type="hidden" name="i_board" value="<%=vo.getI_board()%>"></input>
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