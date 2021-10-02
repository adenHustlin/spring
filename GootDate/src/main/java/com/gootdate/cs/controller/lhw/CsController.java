package com.gootdate.cs.controller.lhw;

import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.gootdate.cs.service.lhw.CsService;
import com.gootdate.domain.CSVo;
import com.gootdate.domain.PagingInfoDTO;

@Controller
@RequestMapping("/cs")
public class CsController {
	@Inject
	private CsService service;

	private static Logger logger = LoggerFactory.getLogger(CsController.class);

	// 글작성페이지 이동
	@RequestMapping(value = "/createBoard", method = RequestMethod.GET)
	public String registerBoard(HttpServletRequest request) {

		return "/cs/createBoard";

	}

//글목록
	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(Model model, @RequestParam(value = "pageNo", required = false, defaultValue = "1") String tmp,
			HttpServletRequest request) throws Exception {

		int pageNo = 1;
		if (!tmp.equals("") || tmp != null) {

			pageNo = Integer.parseInt(tmp);
		}
		Map<String, Object> map = service.readAllBoard(pageNo);
		List<CSVo> lst = (List<CSVo>) map.get("boardList");
		PagingInfoDTO pi = (PagingInfoDTO) map.get("pagingInfo");
		model.addAttribute("pagingInfo", pi);
		model.addAttribute("listBoard", lst);
		
	}

	// 글작성
	@RequestMapping(value = "/createBoard", method = RequestMethod.POST)
	public String createBoard(CSVo vo, RedirectAttributes rttr, HttpServletRequest request)
			throws NamingException, SQLException {

		System.out.println(vo.toString());

		if (service.addBoard(vo)) {
			rttr.addFlashAttribute("result", "success");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		return "redirect:/cs/listAll?pageNo=1";
	}

//글상세페이지
	@RequestMapping(value = "/readBoard", method = RequestMethod.GET)
	public void readBoard(@RequestParam("no") String tmp, Model model, HttpServletRequest request)
			throws NamingException, SQLException {
		
		int no = Integer.parseInt(tmp);
		CSVo vo = service.readBoard(no);
		model.addAttribute("board", vo);
	}

	// 글삭제
	@RequestMapping(value = "/deleteBoard", method = RequestMethod.GET)
	public ModelAndView deleteBoard(@RequestParam("bno") String tmp,ModelAndView mv, Model model, HttpServletRequest request)
			throws NamingException, SQLException {
		
		int bno = Integer.parseInt(tmp);
		
		service.deleteBoard(bno);
		mv.setView(new RedirectView("/cs/listAll"));
		return mv;
	}
	//글수정
	

//에디터 이미지 업로드
	@RequestMapping("/imageUpload")

	public void imageUpload(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam MultipartFile upload)
//    //MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하게 된다
			throws Exception {
		// 한글깨짐을 방지하기위해 문자셋 설정
		response.setCharacterEncoding("utf-8");

		response.setContentType("text/html; charset=utf-8");
		Date createDate = new Date();
		String year = (new SimpleDateFormat("yyyy").format(createDate));// 파일경로
		String month = (new SimpleDateFormat("MM").format(createDate));
		String day = (new SimpleDateFormat("dd").format(createDate));
		UUID uuid = UUID.randomUUID();// 파일이름에 임의스트링 붙이기위한 코드생성

		String fileName = upload.getOriginalFilename();

		byte[] bytes = upload.getBytes();

		// 이미지를 업로드할 디렉토리(임시)
		String uploadPath = session.getServletContext().getRealPath("resources/uploads");

		Path directory = Paths.get(uploadPath, year, month, day);
		String uuidFilename = uuid.toString() + "_" + fileName;
		Files.createDirectories(directory);
		Path targetPath = directory.resolve(uuidFilename).normalize();
		upload.transferTo(targetPath);

		// OutputStream out = new FileOutputStream(new File(uploadPath + fileName));

		// 서버로 업로드
		// write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
		// 지정된 바이트를 출력 스트립에 쓴다

		String callback = request.getParameter("CKEditorFuncNum");

		// 서버=>클라이언트로 텍스트 전송
		PrintWriter printWriter = response.getWriter();
		String fileUrl = "/uploads/" + year + "/" + month + "/" + day + "/" + uuidFilename;
		System.out.println(fileUrl);
		System.out.println(callback);

		printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction(" + callback
				+ ",'" + fileUrl + "','이미지를 업로드하였습니다.')" + "</script>");

		printWriter.flush();
	}

}
