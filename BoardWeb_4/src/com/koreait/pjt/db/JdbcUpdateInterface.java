package com.koreait.pjt.db;

import java.sql.*;

public interface JdbcUpdateInterface {
	void update(PreparedStatement ps) throws SQLException;
}
