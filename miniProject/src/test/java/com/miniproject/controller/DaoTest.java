package com.miniproject.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import persistence.EtcDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(  
	locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"}	
)	
public class DaoTest {
	@Inject
	private EtcDAO dao;
	
	@Test
	public void daoTest() {
		System.out.println(dao.current());
	}
}
