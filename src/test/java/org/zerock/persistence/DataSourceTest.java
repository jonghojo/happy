package org.zerock.persistence;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DataSourceTest {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SqlSessionFactory sessionFactory;
	
	@Test
	public void testConnection() {
		try(Connection con = dataSource.getConnection()) {
			System.out.println("con : " + con);
			
			log.info("con2 : " + con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testMyBatis() {
		try(
				SqlSession session = sessionFactory.openSession();
				Connection con = session.getConnection();
			) {
			log.info("con : " + con);
			log.info("session : " + session);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
