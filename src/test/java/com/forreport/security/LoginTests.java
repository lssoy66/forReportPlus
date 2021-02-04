package com.forreport.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class LoginTests {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;

	@Test
	public void testInsertUser() {
		String sql = "insert into tbl_user(id, password, name, phone, email, grade) values (?,?,?,?,?,?)";		
			Connection con = null;
			PreparedStatement pstmt = null;
			String id = "aaaadmin";
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);				
				
				if(id == "admin") {
					pstmt.setString(1, "admin");
					pstmt.setString(2, pwencoder.encode("admin"));
					pstmt.setString(3, "adminName");
					pstmt.setString(4, "01011111111");				
					pstmt.setString(5, "admin@admin.com");				
					pstmt.setString(6, "0");				
				} else {
					pstmt.setString(1, "bb");
					pstmt.setString(2, pwencoder.encode("bb"));
					pstmt.setString(3, "bbName");				
					pstmt.setString(4, "01022222222");				
					pstmt.setString(5, "bb@bb.com");				
					pstmt.setString(6, "0");	
				}
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						
					}
				}
				if(con != null) {
					try {
						con.close();
					} catch (Exception e) {

					}
				}
			}
		
	}
	
	@Test
	public void testInsertAuth() {
		String sql = "insert into tbl_auth (auth, id) values (?,?)";
	
			Connection con = null;
			PreparedStatement pstmt = null;
			String id = "aaaadmin";
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				if( id == "admin" ) {
					pstmt.setString(1, "ROLE_ADMIN");
					pstmt.setString(2, "admin");				
				} else {
					pstmt.setString(1, "ROLE_MEMBER");
					pstmt.setString(2, "bb");
				}
				pstmt.executeUpdate();
			} catch (Exception e) {
			e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {e.printStackTrace(); }
				}
				if(con != null) {
					try {
						con.close();
					} catch (Exception e) { e.printStackTrace();}
				}
			}
		
	}
	
}
