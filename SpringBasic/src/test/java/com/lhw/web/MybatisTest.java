package com.lhw.web;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(  // root-context.xml 파일을 함께 실행하여 테스트 해라
	locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}	
)	
public class MybatisTest {
	@Inject
	private SqlSessionFactory sf;
	
	@Test
	public void testFactory() {
		if (sf != null) {
			System.out.println(sf);
		}
	}
}
