package service.board;

import java.sql.SQLException;
import java.util.List;

import javax.naming.NamingException;

import domain.BoardVo;


public interface BoardService {
	// Create
			// 게시판에 글 저장 하기
			boolean addBoard(BoardVo bo) throws NamingException, SQLException;
			
			
			
		// Read
			// 게시판 전제 글 불러오기
			List<BoardVo> readAllBoard() throws NamingException, SQLException;
}
