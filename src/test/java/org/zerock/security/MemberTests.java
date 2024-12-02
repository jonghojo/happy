package org.zerock.security;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
                  "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class MemberTests {

   @Autowired
   private PasswordEncoder passwordEncoder;
   
   @Autowired
   private DataSource ds;
   
   @Test
   public void testInsertMember() {
      String sql = "insert into admin(admin_id, admin_password, username) values(?,?,?)";
      
      for(int i=0; i<2; i++) {
         Connection con = null;
         PreparedStatement pstmt = null;
         
         try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(2, passwordEncoder.encode("1234"));
            
            if(i<80) {
               pstmt.setString(1, "admin"+i);
               pstmt.setString(3, "사용자");
            }else if(i<90) {
               pstmt.setString(1, "manager"+i);
               pstmt.setString(3, "매니저"+i);
            }else {
               pstmt.setString(1, "admin"+i);
               pstmt.setString(3, "관리자"+i);
            }
            
            pstmt.executeUpdate();
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            if(pstmt !=null) {
               try {
                  pstmt.close();
               } catch (SQLException e) {
                  e.printStackTrace();
               }
            }
            
            if(con != null) {
               try {
                  con.close();
               } catch (SQLException e) {
                  e.printStackTrace();
               }
            }
         }
      }
   }
   
   @Test
   public void testInsertAuth() {
	   String sql = "insert into admin_auth(admin_id, auth) values(?,?)";
	      
	      for(int i=0; i<100; i++) {
	         Connection con = null;
	         PreparedStatement pstmt = null;
	         
	         try {
	            con = ds.getConnection();
	            pstmt = con.prepareStatement(sql);
	            
	            
	            if(i<80) {
	               pstmt.setString(1, "user"+i);
	               pstmt.setString(2, "ROLE_USER");
	            }else if(i<90) {
	               pstmt.setString(1, "manager"+i);
	               pstmt.setString(2, "ROLE_MEMBER");
	            }else {
	               pstmt.setString(1, "admin"+i);
	               pstmt.setString(2, "ROLE_ADMIN");
	            }
	            
	            pstmt.executeUpdate();
	         }catch(Exception e) {
	            e.printStackTrace();
	         }finally {
	            if(pstmt !=null) {
	               try {
	                  pstmt.close();
	               } catch (SQLException e) {
	                  e.printStackTrace();
	               }
	            }
	            
	            if(con != null) {
	               try {
	                  con.close();
	               } catch (SQLException e) {
	                  e.printStackTrace();
	               }
	            }
	         }
	      }
   }
   
   @Test
   public void testPass() {
	   String sql = "select userpw from tbl_member where userid=?";
	   Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       try {
    	   con = ds.getConnection();
    	   pstmt = con.prepareStatement(sql);
    	   pstmt.setString(1, "user0");
    	   rs = pstmt.executeQuery();
    	   if(rs.next()) {
    		   String userpw = rs.getString("userpw");
    		   log.info("userpw : "+userpw);
    		   boolean matches = passwordEncoder.matches("1234", userpw);
    		   log.info("pw check : " + matches);
    	   }
	} catch(Exception e) {
        e.printStackTrace();
     }finally {
        if(pstmt !=null) {
           try {
              pstmt.close();
           } catch (SQLException e) {
              e.printStackTrace();
           }
        }
        
        if(con != null) {
           try {
              con.close();
           } catch (SQLException e) {
              e.printStackTrace();
           }
        }
     }
  }
   
   
   

}



















