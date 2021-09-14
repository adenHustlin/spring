package persistence.board;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.BoardVo;
import domain.MemberPointVo;
import domain.PagingInfoDTO;



@Repository
public class BoardDAOImpl implements BoardDAO {
	
	private static String namespace = "com.miniProj.mapper.boardMapper";
	
	@Inject
	private SqlSession ses;
	
	@Override
	public int insertBoardVo(BoardVo bo) throws NamingException, SQLException {
//		int result = 0;
//		if (bo.getNotimage().equals("")) { // 이미지 인경우
//			bo.setImage("uploads" + bo.getImage()); 
//			bo.setThumbimage("uploads" + bo.getThumbimage());
//			result = ses.insert(namespace + ".createBoardWithImage", bo);
//		} else if (bo.getImage().equals("")) { // 이미지 파일이 아닌경우
//			bo.setNotimage("uploads" + bo.getNotimage());
//			result = ses.insert(namespace + ".createBoardWithNoImage", bo);
//		} else {
//			result = ses.insert(namespace + ".createBoard", bo);
//		
		
//		return result;
		return ses.insert(namespace + ".createBoard", bo);
	}
	@Override
	public List<BoardVo> selectAllBoard(int pageNo,PagingInfoDTO pi) throws NamingException, SQLException {
		return ses.selectList(namespace + ".selectAllBoard",pi);
	}

	@Override
	public int insertMemberPoint(MemberPointVo mp) throws NamingException, SQLException {
		return ses.insert(namespace + ".insertMemberPoint", mp);
	}

	@Override
	public int selectCntPost() throws NamingException, SQLException {
		
		return Integer.parseInt(ses.selectOne(namespace+".getTotalPostCnt").toString());
	}

	@Override
	public BoardVo selectBoard(int no) throws NamingException, SQLException {
		// TODO Auto-generated method stub
		return ses.selectOne(namespace+".selectBoard",no);
	}

	@Override
	public void updateReadCount(int no) throws NamingException, SQLException {


		ses.update(namespace+".increaseReadCount",no);
	}
	

}
