package persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class EtcDAOImpl implements EtcDAO {
	@Inject
	private SqlSession ses;
	
	private static String ns = "com.miniProj.etcMapper";
	
	@Override
	public String current() {
		return ses.selectOne(ns + ".now");
	}

}
