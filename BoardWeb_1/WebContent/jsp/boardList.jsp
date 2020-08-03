<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import= "java.util.*" %>
<%@ page import="com.koreait.web.BoardVO" %>

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
	List<BoardVO> boardList = new ArrayList();
	/*try안에서 선언하지 않은 이유는 try의 중괄호({})를 벗어나는 순간 스코프가 죽기 때문에 finally에서
	사용이 불가능하다.*/
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = " SELECT i_board, title FROM t_board ORDER BY i_board DESC";
	try{
		con = getCon();
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			int i_board = rs.getInt("i_board");
			String title = rs.getNString("title");
			
			BoardVO vo = new BoardVO();
			vo.setI_board(i_board);
			vo.setTitle(title);
			boardList.add(vo);
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
<title>게시판</title>
</head>
<body>
	<div>게시판 리스트
	<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</div>
	<table>
	<tr>
	<th>No</th>
	<th>제목</th>
	</tr>
	<%for(BoardVO vo : boardList) { %>
	<tr>
	<th><%=vo.getI_board() %></th>
	<th>
	<a href="/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()%>">
	<%=vo.getTitle()%>
	</a>
	</th>
	</tr>
	<%} %>
	</table>
</body>
</html>