package service.board;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.cj.jdbc.exceptions.PacketTooBigException;

import domain.BoardVo;
import domain.MemberPointVo;
import domain.PagingInfoDTO;
import persistence.board.BoardDAO;
import service.board.BoardService;


@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO dao;

	@Override
	public boolean addBoard(BoardVo bo) throws NamingException, SQLException {
		boolean addBoard = false;
		// 타이틀에 태그 실행 방지
//        bo.setContent(bo.getTitle().replace("<", "&lt;")); 
//        bo.setContent(bo.getTitle().replace(">", "&gt;"));
//        
//        bo.setContent(bo.getContent().replace("\n", "<br />")); // 줄바꿈
//        bo.setContent(bo.getContent().replace("\t", "&nbsp;&nbsp;&nbsp;&nbsp;"));
		int result = dao.insertBoardVo(bo);
		int result2= 0;
		if (result == 1) { // 글쓰기 정상
			result2 = dao.insertMemberPoint(new MemberPointVo(bo.getWriter(), null, 2, "글작성"));
			
		}
		
		if (result == 1 && result2 ==1) {
			
		}
		return addBoard;
	}

	@Override
	public Map<String, Object> readAllBoard(int pageNo) throws NamingException, SQLException {
		PagingInfoDTO pi= pagingProcess(pageNo);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("boardList", dao.selectAllBoard(pageNo, pi));
		map.put("pagingInfo", pi);
		return map;
	}
	// 페이징을 위한 처리 작업 전담 메서드
	   private PagingInfoDTO pagingProcess(int pageNo) throws NamingException, SQLException {
	      PagingInfoDTO pi = new PagingInfoDTO();
	      
	      pi.setStartNum(pageNo);  // 출력 시작할 번호
	      int totalPost = 0;
	      
	            totalPost = dao.selectCntPost(); // 전체 글 수를 얻음
	        
	         
	         pi.setTotalPage(totalPost); // 전체 페이지 수
	         pi.setCurrentPagingBlock(pageNo); // 현재 페이지블록
	         
	         pi.setStartPageNoOfBlock(pi.getCurrentPagingBlock());//시작페이지 블록
	         pi.setEndPageNoOfBlock(pi.getStartPageNoOfBlock());//끝페이지 블록
	         pi.setTotalPagingBlockCnt(pi.getTotalPage());//페이지블록 개수
	      
	      return pi;
	   }
	 @Transactional(isolation = Isolation.READ_COMMITTED)//조회수 업데이트 문이 커밋된 데이터에 한해 셀렉트되도록 격리 레벨을 올림
	@Override
	public BoardVo readBoard(int no) throws NamingException, SQLException {
		//하루에 한번 증가시키는거 아이피주소로하는거 jsp할때 했었음 그거참고하자
		 dao.updateReadCount(no);//readcount 
		BoardVo vo =dao.selectBoard(no);
		
		
		return vo;
	}

}
