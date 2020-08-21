package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardDomain;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

public class BoardDAO {
	
	public static int updBoard(final BoardVO param) {		
		String sql = " UPDATE t_board4 "
				+ " SET  "
				+ " title = ?, ctnt = ? , m_dt = SYSDATE "
				+ " WHERE i_board = ? "
				+ " AND i_user = ?";
				
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_board());
				ps.setInt(4, param.getI_user());
			}
		});
	}
	
	public static int addHits(final int i_board) {		
		String sql = " UPDATE t_board4 "
				+ " SET  "
				+ " hits = hits + 1"
				+ " WHERE i_board = ? ";
				
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setInt(1, i_board);
				
			}
		});
	}
	
	public static List<BoardVO> selBoardList() {
		final List<BoardVO> list = new ArrayList();
		
		String sql = " SELECT i_board, title, hits, A.i_user, A.r_dt, nm FROM t_board4 A, t_user B where A.i_user = B.i_user"
				+ " ORDER BY i_board DESC ";
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					int i_user = rs.getInt("i_user");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
	
					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setI_user(i_user);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					
					list.add(vo);
				}
				return 1;
			}
			
		});
		
		return list;
	}
	
	public static BoardDomain selBoard(final int i_board) {
		BoardDomain result = new BoardDomain();
		result.setI_board(i_board);
		
		String sql = " SELECT B.nm, i_board "
				+ " , A.title, A.ctnt, A.hits, TO_CHAR(A.r_dt, 'YYYY/MM/DD HH24:MI') as r_dt, A.i_user "
				+ " FROM t_board4 A "
				+ " INNER JOIN t_user B "
				+ " ON A.i_user = B.i_user "
				+ " WHERE A.i_board = ? ";
		
		int resultInt = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, i_board);
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					result.setI_board(rs.getInt("i_board"));
					result.setNm(rs.getNString("nm"));
					result.setTitle(rs.getNString("title"));
					result.setCtnt(rs.getNString("ctnt"));
					result.setHits(rs.getInt("hits"));
					result.setR_dt(rs.getNString("r_dt"));
					result.setI_user(rs.getInt("i_user"));
				}
				return 0;
			}
		});
		
		return result;
	}
	
	public static int insBoard(BoardVO param) {		
		String sql = " INSERT INTO t_board4 "
				+ " (i_board, title, ctnt, i_user) "
				+ " VALUES "
				+ " (seq_board.nextval, ?, ?, ?) ";
				
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_user());
						
			}
		});
	}
	
	public static int delBoard(BoardVO param) {
		
		String sql = " DELETE "
				+ " FROM t_board4 "
				+ " WHERE i_board = ? AND i_user = ? ";
			
		
		int resultInt = JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {				
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
		});
		
		return resultInt;
	}
}
