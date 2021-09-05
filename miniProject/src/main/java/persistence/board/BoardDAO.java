package persistence.board;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import domain.BoardVo;



public interface BoardDAO {
	// Create
		// 게시판에 글 저장 하기
		int insertBoardVo(BoardVo bo) throws NamingException, SQLException;
		
		
		
	// Read
		// 게시판 전제 글 불러오기
		List<BoardVo> selectAllBoard() throws NamingException, SQLException;
		
}
