package com.gootdate.cs.dao.lhw;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import com.gootdate.domain.CSVo;
import com.gootdate.domain.MemberPointVo;
import com.gootdate.domain.PagingInfoDTO;

public interface CsDAO {
	// create
	// 게시판에 글 저장하기
	int insertCSVo(CSVo bo) throws NamingException, SQLException;

	// 게시판에 글 작성시 멤버 포인트 증가
	int insertMemberPoint(MemberPointVo mp) throws NamingException, SQLException;

	// Read
	// 게시판 전체 글 불러오기
	List<CSVo> selectAllBoard(int pageNo, PagingInfoDTO pi) throws NamingException, SQLException;

	// 전체글수 얻어오기
	int selectCntPost() throws NamingException, SQLException;

	/**
	 * @date:2021. 9. 7.
	 * @param no
	 * @return return value:
	 */
	// 글번호로 게시물 불러오기
	CSVo selectBoard(int no) throws NamingException, SQLException;
	// update

	// 조회수증가
	/**
	 * @date:2021. 9. 7. return value:
	 */
	void updateReadCount(int no) throws NamingException, SQLException;

//delete
	void deleteBoard(int bno);

}
