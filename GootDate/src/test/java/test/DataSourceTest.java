package test;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(  // root-context.xml ������ �Բ� �����Ͽ� �׽�Ʈ �ض�
	locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}	
)	
public class DataSourceTest {
	@Inject
	private DataSource dataSource; // root-context�� dataSource ��ü�� ���� ����� ����
	
	@Test
	public void testConnection() throws SQLException {
		System.out.println("���Ե� DataSource ��ü : " + dataSource);
	
		Connection con = dataSource.getConnection();
		
		if (con != null) {
			System.out.println("���� ����");
			
		}
	}
	
}
