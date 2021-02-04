package com.forreport.persistence;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	// static 초기화 블럭 : 가장 먼저 실행
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";

		try (Connection con = DriverManager.getConnection(url, "forreport", "forreport")) {
			log.info("연결 성공! :: " + con); // Connection 객체 출력
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}

}
