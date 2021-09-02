package com.lhw.web;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.lhw.domain.Member;
import com.lhw.persistence.MemberDao;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(// root-context.xml을 로딩하여 현재 클래스와 같이 실행되도록
		locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}
		)
public class MemberDAOTest {
	@Inject
	private MemberDao dao; // MemberDAO 객체 주입
	
	 
	@Test
	public void testIme() {
		
		System.out.println(dao.getTime());
	}
	
//	@Test
//	public void testInsertMember() throws Exception {
//		Member m= new Member("montana", "1234","montana", "montana@gmail.com", "img/baddy.png", null, null);
////		Member m = new Member();
////		m.setUserid("montana");
////		m.setPassword("1234");
////		m.setName("montana");
////		m.setEmail("montana@gmail.com");
//		if(dao.insertMember(m)) {
//			System.out.println("success");
//		}
//	}
	 
//		@Test
//		public void selectMember() {
//			
//			System.out.println(dao.selectAllMembers());
//		}
		@Test
		public void getUserId() {
			
			Member m =new Member();
			m.setUserid("choi");
			System.out.println(dao.getMemberByUserId(m));
		}
}
