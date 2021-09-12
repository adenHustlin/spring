package com.webshjin.web;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.webshjin.domain.Member;
import com.webshjin.persistence.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(  // root-context.xml 로딩하여 현재 클래스와 같이 실행되도록
	locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}	
)	
public class MemberDAOTest {
	@Inject
	private MemberDAO dao;  // MemberDAO 객체 주입
	
//	@Test
//	public void testTime() {
//		System.out.println("현재시간 : " + dao.getTime());
//	}
	
//	@Test
//	public void testInserMember() {
//		Member m = new Member("michol", "1234", "마이콜", "michol@dooly.com", "images/dooly.png", null, null);
//		Member m = new Member();
//		m.setUserid("michol");
//		m.setPassword("1234");
//		m.setName("마이콜");
//		m.setEmail("michol@dooly.com");
//		System.out.println(m.toString());
//		if (dao.insertMember(m)) {
//			System.out.println("저장 성공");
//		} else {
//			System.out.println("저장 실패");
//		}
//	}
	
//	@Test
//	public void testSelectAllMembers() {
//		List<Member> lst = dao.selectAllMembers();
//		
//		for (Member m : lst) {
//			System.out.println(m.toString());
//		}
//	}
	
	@Test
	public void testSelectMember() {
		String userid = "dooly";
		
		System.out.println(dao.selectMemberByUserId(userid).toString());
	}
}
