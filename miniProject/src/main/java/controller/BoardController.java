package controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import domain.BoardVo;
import domain.PagingInfoDTO;
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
	public void listAll(Model model,@RequestParam(value="pageNo",required = false,defaultValue = "1")String tmp) throws Exception{
		int pageNo=1;
		if(!tmp.equals("")||tmp!=null) {
			
			pageNo=Integer.parseInt(tmp);
		}
		logger.info("pageNo="+ pageNo);
		
		Map<String, Object> map = service.readAllBoard(pageNo);
		List<BoardVo> lst=(List<BoardVo>)map.get("boardList");
		PagingInfoDTO pi= (PagingInfoDTO)map.get("pagingInfo");
		model.addAttribute("pagingInfo", pi);
		model.addAttribute("listBoard", lst);
		
	}
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String registerBoard() {
		logger.info("register process");
		return "/board/createBoard";
		
	}
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> upFile(MultipartFile upFile, HttpServletRequest request) { // MultipartFile 객체의 변수명은
																								// jsp파일내에 ajax에서 첨부하는
																								// name과 같아야 한다
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
			return new ResponseEntity<String>(returnVal, HttpStatus.OK); // 텍스트로 이미지 경로명 파일명 반환
		} catch (IOException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); // 에러
		}

	}

//	ResponseEntity로 받아야 텍스트로 받아들임, 유저가 x표시를 눌러서 지울때
	@RequestMapping(value="/delFile", method=RequestMethod.POST, produces="text/plain; charset=utf-8")
//	origin과 thumb의 객체를 만들지 않아서 객체로 받지 못함.. 그래서 마라메터로 받음.. 실제경로가 아니기 때문에 realpath로 받기 위해 이렇게 함
	public ResponseEntity<String> delFile(@RequestParam("origin") String origin, @RequestParam("thumb") String thumb, 
			@RequestParam("notImg") String notImg ,HttpServletRequest request) {
		System.out.println("origin : " + origin + ", thumb : " + thumb);
		
//		jsp에서도 duplicate 되니 여기서도 아마도 될꺼다. 우회해서 얻어와야한다
		String path = request.getSession().getServletContext().getRealPath("resources");
		
		path += File.separator + "uploads";
		System.out.println(path);
		
		// 이미지가 아닌 파일들을 삭제
		if (notImg.equals("") && !notImg.equals("")) {
			notImg = notImg.replace('/', File.separatorChar);
			File notImgF = new File(path + notImg);
			if(notImgF.delete()) {
				return new ResponseEntity<String>(HttpStatus.OK);
			} else {
				return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
		} else if (notImg.equals("") && !origin.equals("")) { // 이미지 파일 삭제
			
			origin = origin.replace('/', File.separatorChar);
			System.out.println("지울 파일 : " + (path + origin));
			File originFile = new File(path + origin);
			
			boolean oBoolean = originFile.delete();
			boolean tBoolean = false;
			
			thumb = thumb.replace('/', File.separatorChar);
			File thumbFile = new File(path + thumb);
			tBoolean = thumbFile.delete();
			tBoolean = true;
			
			
			if (oBoolean && tBoolean) {
				return new ResponseEntity<String>(HttpStatus.OK);
			} else {
				return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
		} else {
			return new ResponseEntity<String>(HttpStatus.OK); 
		}
						 
	} 
	//RedirectAttributes위의 /listAll을 호출하기 위해
	@RequestMapping(value="/createBoard", method=RequestMethod.POST)
	public String createBoard(BoardVo vo, RedirectAttributes rttr,HttpServletRequest request) throws NamingException, SQLException { // 도메인에 감싸져서 온다
		
		System.out.println(vo.toString());
		
		if(service.addBoard(vo)) {
			rttr.addFlashAttribute("result", "success");
		} else {
			rttr.addFlashAttribute("result", "fail");
		}
		return "redirect:/board/listAll?pageNo=1";
	}
	@RequestMapping(value = "/readBoard",method=RequestMethod.GET)
	public void readBoard(@RequestParam("no")String tmp,Model model) throws NamingException, SQLException {
		int no=Integer.parseInt(tmp);
		BoardVo vo=service.readBoard(no);
		model.addAttribute("board",vo);
	}
	@RequestMapping("/imageUpload")
//    // 이미지를 저장하고, 불러오고, 업로드하기위해 매개변수를 선언
    public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload)
//    //MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하게 된다
            throws Exception {
		System.out.println();
        // 한글깨짐을 방지하기위해 문자셋 설정
        response.setCharacterEncoding("utf-8");
 
        // 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
        response.setContentType("text/html; charset=utf-8");
 
        // 업로드한 파일 이름
        String fileName = upload.getOriginalFilename();
 
        // 파일을 바이트 배열로 변환
        byte[] bytes = upload.getBytes();
 
        // 이미지를 업로드할 디렉토리(배포 디렉토리로 설정)
        String uploadPath = "C:\\lecture\\spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\miniProject\\resources\\uploads\\";

    
        OutputStream out = new FileOutputStream(new File(uploadPath+fileName));
 
        // 서버로 업로드
        // write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다.
        // 지정된 바이트를 출력 스트립에 쓴다 (출력하기 위해서)
        out.write(bytes);
        out.flush();
        // 클라이언트에 결과 표시
        String callback = request.getParameter("CKEditorFuncNum");
        
        // 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
        PrintWriter printWriter = response.getWriter();
        String fileUrl = "/uploads/"+ fileName;
        System.out.println(fileUrl);

        printWriter.println("<script type='text/javascript'>" + "window.parent.CKEDITOR.tools.callFunction(" + callback+",'"+ fileUrl+"','이미지를 업로드하였습니다.')" +"</script>");

        
       
        printWriter.flush();
    }

	
		
}
