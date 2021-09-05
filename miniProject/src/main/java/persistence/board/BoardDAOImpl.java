package persistence.board;

import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.BoardVo;



@Repository
public class BoardDAOImpl implements BoardDAO {
	
	private static String namespace = "com.miniProj.mapper.boardMapper";
	
	@Inject
	private SqlSession ses;
	
	@Override
	public int insertBoardVo(BoardVo bo) throws NamingException, SQLException {
		return ses.insert(namespace + ".createBoard", bo);
	}

	@Override
	public List<BoardVo> selectAllBoard() throws NamingException, SQLException {
		return ses.selectList(namespace + ".selectAllBoard");
	}

}
