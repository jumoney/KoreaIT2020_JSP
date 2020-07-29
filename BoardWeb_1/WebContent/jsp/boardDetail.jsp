<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.web.BoardVO"%>
<%!
	private Connection getCon() throws Exception{
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String userName = "hr";
	String password = "koreait2020";

	Class.forName("oracle.jdbc.driver.OracleDriver");
	
	Connection con = DriverManager.getConnection(url, userName, password);
	System.out.println("접속 성공!");
	return con;
}
%>
<%
	BoardVO vo = null;
	String nm = null;
	String strI_board = request.getParameter("i_board");
	String sql = "SELECT A.title, A.ctnt, A.i_student, B.nm " 
			+ " FROM t_board A " 
			+ " INNER JOIN t_student B ON A.i_studEnt = b.i_student "  
			+ " WHERE I_board  = " + strI_board;
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String title = rs.getNString("title");
			String ctnt = rs.getNString("ctnt");
			int i_student = rs.getInt("i_student");
			nm = rs.getNString("nm");
			vo = new BoardVO();
			vo.setI_board(Integer.parseInt(strI_board));
			vo.setTitle(title);
			vo.setCtnt(ctnt);
			vo.setI_student(i_student);
		}
		
	}catch(Exception e) {
		e.printStackTrace();
	}finally {
		/*rs, ps, con 의 try catch문을 따로 사용한 이유는 rs든 
		어디든 예외가 발생해도 다른 것들이라도 닫아주기 위해*/
		if(rs != null) {try {rs.close();} catch(Exception e){} }
		if(ps != null) {try {ps.close();} catch(Exception e){} }
		if(con != null) {try {con.close();} catch(Exception e){} }
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 페이지</title>
<style>
.container {
	width: 600px;
	margin: 0 auto;
	border: 1px solid black;
	height: 300px;
}

span {
	font-weight: bold;
	color: blue;
}

.style2 {
	margin-left: 200px
}
</style>
</head>
<body>
	<div class="container">
		<div>
			<span>상세 페이지:</span>
			<%=strI_board%><br>
			<hr>
			<span>제목:</span>
			<%=vo.getTitle()%>
			<span class="style2">글쓴이:</span>
			<%=nm%>
		</div>
		<hr>
		<div>
			<span>내용:</span>
			<%=vo.getCtnt() %></div>
	</div>
	<div>
		<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()-1%>">이전글
	
	</a>
	<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()+1%>">다음글
	
	</a>
	</div>
</body>
</html>