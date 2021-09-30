/**
 * 
 */
package com.gootdate.security.service.lhw;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gootdate.domain.MemberDetailsDto;
import com.gootdate.domain.MemberVo;
import com.gootdate.domain.SocialRegisterVo;
import com.gootdate.security.dao.lhw.SecurityDaoImpl;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

/**
 * @author baekd
 * @packageName: service.security
 * @fileName: MemberDetailsServiceCustom.java
 * @date: 2021. 9. 16. description:
 */
@Service("MemberLoginService")
public class SecurityService implements UserDetailsService {
	@Inject
	SecurityDaoImpl SecurityDaoImpl;
	@Inject
	JavaMailSender mailSender;
	@Value("${firstKey}")
	String coolsmsKey1;
	@Value("${secondKey}")
	String coolsmsKey2;

//로그인시 회원정보가져오기
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		MemberDetailsDto memberDetailsDto = SecurityDaoImpl.getMemberDetails(userid);
		if (memberDetailsDto == null) {
			throw new UsernameNotFoundException(userid);

		}
		return memberDetailsDto;
	}

//있는아이디인지 select
	public MemberDetailsDto useridExistance(String userid) {

		return SecurityDaoImpl.getMemberDetails(userid);
	}

//회원가입 insert
	public int memberRegister(MemberVo vo) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.memberRegister(vo);
	}

//로그인실패횟수 update
	public int UpdateFailureCnt(String userid) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.updateFailureCount(userid);
	}

//로그인실패횟수 select
	public int checkFailureCount(String userid) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.checkFailureCount(userid);
	}

//회원계정 잠구기 update
	public void disableMember(String userid) {
		SecurityDaoImpl.updateDisabled(userid);

	}

//로그인 실패횟수 초기화 update
	public void resetFailureCnt(String userid) {

		SecurityDaoImpl.resetFailureCnt(userid);
	}

//멤버정보 받아오기 select
	public MemberVo getMemberVo(Map<String, String> map) {

		return SecurityDaoImpl.getMemberVo(map);
	}

//소셜회원가입 insert
	public int SocialMemberRegister(SocialRegisterVo vo) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.SocialMemberRegister(vo);
	}

//이메일 인증했으니 enable 만들기 update
	public int confirmEmail(String email) {
		// TODO Auto-generated method stub
		return SecurityDaoImpl.confrimEmail(email);
	}

	public void sendMail(String email, String purpose) throws MessagingException {
		System.out.println(purpose);
		String message = "";
		if (purpose == "registrEmailConfirm") {
			System.out.println("register email confirm sent");
			message = "<a href='http://localhost:8081/security/emailConfirm?email=" + email
					+ "'>누르면 인증성공페이지로 이동합니다</a>";
		} else if (purpose == "sendUseridToEmail") {
			Map<String, String> STNK = new HashMap<>();
			STNK.put("searchType", "email");
			STNK.put("keyword", email);
			MemberVo vo = SecurityDaoImpl.getMemberVo(STNK);
			message = "<h3>Your Userid:  " + vo.getUserid() + "</h3>";
		}
		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "utf-8");
		mailHelper.setFrom("gootdate"); // 보내는 사람 셋팅
		mailHelper.setTo(email); // 받는 사람 셋팅
		mailHelper.setSubject("GootDate Email Confirmation Mail"); // 제목 셋팅
		mailHelper.setText(message, true); // 내용 셋팅
		mailSender.send(mail);

	}

	public void sendMessage(String toNumber, String randomNumber) {

		Message coolsms = new Message(coolsmsKey1, coolsmsKey2);

		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", toNumber);
		params.put("from", "01071359167");
		params.put("type", "SMS");
		params.put("text", "[GootDate] 인증번호 " + randomNumber + " 를 입력하세요.");
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());

		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());

		}

	}

	public int changePassword(String userid, String Npwd) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String encNPassword = encoder.encode(Npwd);
		map.put("userid", userid);
		map.put("password", "{bcrypt}"+encNPassword);

		return SecurityDaoImpl.changePassword(map);
	}

}
