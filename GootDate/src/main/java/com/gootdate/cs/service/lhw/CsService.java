package com.gootdate.cs.service.lhw;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;

import com.gootdate.domain.CSLikeVo;
import com.gootdate.domain.CSVo;

public interface CsService {
	// Create
	// 게시판에 글 저장 하기
	boolean addBoard(CSVo bo) throws NamingException, SQLException;

	// Read
	// 게시판 전제 글 불러오기
	Map<String, Object> readAllBoard(int pageNo) throws NamingException, SQLException;

	// 게시물 불러오기
	CSVo readBoard(int no) throws NamingException, SQLException;

	// delete
	void deleteBoard(int bno);
	//likes
	//getlikeVo
	

	CSLikeVo getCSLikeVo(CSLikeVo vo);

	int countLikes(CSLikeVo vo);

	int countDisLikes(CSLikeVo vo);

	void makeLikeTo1(CSLikeVo vo);

	

	void makeLikeToMinus1(CSLikeVo vo);

	void deleteLike(CSLikeVo vo);

	void insertLike(CSLikeVo vo);

	void processCs(CSLikeVo vo);

	

	void editBoard(CSVo vo);

	List<CSVo> getList(CSVo vo) throws NamingException, SQLException;

	
}
