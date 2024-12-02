package org.zerock.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	
	/* 생략가능
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	*/
	@Test
	public void testConnection() {
//		String url = "jdbc:oracle:thin:@localhost:1521:xe";
//		String id = "book_ex";
//		String pass = "1234";
//		Connection con = null;
		
		try(Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe",
				"book_ex",
				"1234"
				)) {
//			con = DriverManager.getConnection(url, id, pass);
			
			System.out.println("con : " + con);
		} catch (Exception e) {
			e.printStackTrace();
		} /*
			 * finally { try { con.close(); } catch (SQLException e) {
			 * e.printStackTrace(); } }
			 */
	}
}
