package com.lhw.web;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(  // root-context.xml 파일을 함께 실행하여 테스트 해라
	locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}	
)	
public class DataSourceTest {
	@Inject
	private DataSource dataSource; // root-context의 dataSource 객체를 현재 멤버에 주입
	
	@Test
	public void testConnection() throws SQLException {
		System.out.println("주입된 DataSource 객체 : " + dataSource);
		
		Connection con = dataSource.getConnection();
		
		if (con != null) {
			System.out.println("정상 연결");
			
		}
	}
	
}
