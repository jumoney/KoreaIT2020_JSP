package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardCmtDomain;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.BoardVO;

public class BoardCmtDAO {
	public static int insCmt(BoardCmtVO param) {
		String sql = " INSERT INTO t_board4_cmt " 
	+ " (i_cmt, i_board, i_user, cmt) " 
	+ " VALUES(seq_board4_cmt.nextval, ?, ?, ? ) ";

		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
				ps.setString(3, param.getCmt());
			}
		});
	}
	
	public static List<BoardCmtDomain> selCmtList(int i_board) {
		final List<BoardCmtDomain> list = new ArrayList();
		
		String sql = " SELECT i_cmt, cmt, B.i_user, B.nm, A.r_dt "
				+ " FROM t_board4_cmt A, t_user B "
				+ " where A.i_user = B.i_user AND A.i_board = ?"
				+ " ORDER BY A.i_cmt";
		
		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, i_board);
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_cmt = rs.getInt("i_cmt");
					String cmt = rs.getNString("cmt");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
					int i_user = rs.getInt("i_user");
					
					BoardCmtDomain vo = new BoardCmtDomain();
					vo.setI_cmt(i_cmt);
					vo.setCmt(cmt);
					vo.setNm(nm);
					vo.setI_user(i_user);
					vo.setR_dt(r_dt);
					
					list.add(vo);
				}
				return 1;
			}
			
		});
		
		return list;
	}

	public static int updCmt(BoardCmtVO param) {
		String sql = " UPDATE t_board4_cmt " 
				+ " SET"
				+ " cmt = ?,  m_dt=sysdate " 
				+ " WHERE i_cmt = ? AND i_user=?";

					return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
						@Override
						public void update(PreparedStatement ps) throws SQLException {
							ps.setNString(1, param.getCmt());
							ps.setInt(2, param.getI_cmt());
							ps.setInt(3, param.getI_user());
						}
					});
	}

	public static int delCmt(BoardCmtVO param) {
		String sql = " DELETE FROM t_board4_cmt " 
				+ " WHERE i_cmt=? AND i_user=?";

					return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
						@Override
						public void update(PreparedStatement ps) throws SQLException {
							ps.setInt(1, param.getI_cmt());
							ps.setInt(2, param.getI_user());
							
						}
					});
	}
}
