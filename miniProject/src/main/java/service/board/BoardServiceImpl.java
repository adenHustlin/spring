package service.board;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.springframework.stereotype.Service;

import domain.BoardVo;
import persistence.board.BoardDAO;


@Service
public class BoardServiceImpl implements BoardService {
	@Inject
	private BoardDAO dao;

	@Override
	public boolean addBoard(BoardVo bo) throws NamingException, SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BoardVo> readAllBoard() throws NamingException, SQLException {
		return dao.selectAllBoard();
	}

}
