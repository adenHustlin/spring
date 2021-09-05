package controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.mysql.cj.result.Field;

import domain.BoardVo;
import etc.UploadFileProcess;
import etc.UploadFiles;
import service.board.BoardService;


@Controller
@RequestMapping("/board*")
public class BoardController {
	@Inject
	private BoardService service;
	
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value="/listAll", method=RequestMethod.GET)
	public void listAll(Model model) throws Exception {
		logger.info("list all");
		
		List<BoardVo> lst = service.readAllBoard();
		System.out.println(lst);
		
		model.addAttribute("listBoard", lst);
		
	}
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String registerBoard() {
		logger.info("register process");
		return "/board/createBoard";
		
	}
	@RequestMapping(value="/uploadFile", method=RequestMethod.POST, produces="text/plain; charset=utf-8")
	public ResponseEntity<String> upFile(MultipartFile upFile, HttpServletRequest request) {  // MultipartFile 객체의 변수명은 jsp파일내에 ajax에서 첨부하는 name과 같아야 한다
		logger.info("업로드 된 파일 처리 시작....");
		
		logger.info("업로드된 파일 이름 : " + upFile.getOriginalFilename());
		logger.info("파일사이즈 : " + upFile.getSize());
		logger.info("업로드된 파일의 타입 : " + upFile.getContentType());
		logger.info("파일 separator : " + File.separator);
		
		String upPath = request.getSession().getServletContext().getRealPath("resources/uploads");
		logger.info("업로드 되는 실제 경로 : " + upPath);
		
		UploadFiles files;
		try {
			files = new UploadFileProcess().uploadFileRename(upPath, upFile.getOriginalFilename(), upFile.getBytes());
			
			String returnVal = null;
			if (files.getThumbnailImgFileName() != null) {
				// 이미지 파일이므로 썸네일 이미지 경로 반환
				returnVal = files.getThumbnailImgFileName();
			} else if (files.getNotImgFileName() != null) {
				// 이미지 파일이 아니므로 경로 반환
				returnVal = files.getNotImgFileName();
			}
			return new ResponseEntity<String>(returnVal, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		
	}
}
