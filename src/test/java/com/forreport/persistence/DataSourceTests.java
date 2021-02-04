package com.forreport.persistence;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {

	@Setter(onMethod_ = @Autowired)
	private DataSource dataSource;	// HikariDataSource는 DataSource를 구현

	@Test
	public void testConnection() {
		try(Connection con = dataSource.getConnection()){
			log.info("연결 성공! :: " + con);
		}catch (Exception e) {
			fail(e.getMessage());
		}
	}
	
//	@Test
//	public void testInsertCart() {
//		try(Connection con = dataSource.getConnection()){
//			String sql = "insert into tbl_cart(cartnum, id, pronum) values(seq_cart.nextval, ?, ?)";
//			PreparedStatement stmt = con.prepareStatement(sql);
//			stmt.setString(1, "admin");
//			stmt.setString(1, "");
//		}catch (Exception e) {
//			fail(e.getMessage());
//		}
//	}

}
