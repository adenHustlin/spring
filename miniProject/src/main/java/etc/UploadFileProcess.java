package etc;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystemException;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FilenameUtils;
import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar;


/**
 * @author baekd
 * @packageName: etc
 * @fileName: UploadFileProcess.java
 * @date: 2021. 9. 3.
 * description:

 */
public class UploadFileProcess {
	private UploadFiles files=new UploadFiles();

	public UploadFiles uploadFileRename(String upPath, String originalFilename, byte[] file) throws IOException {
		// TODO Auto-generated method stub
		UUID uuid= UUID.randomUUID();
		String savedName=uuid.toString()+"_"+originalFilename;
		String savePath=calculatePath(upPath);
		File target= new File(upPath+savePath+File.separator,savedName);
		FileCopyUtils.copy(file, target);//file을 타겟 으로 저장함
		//썸네일 만들기용 확장자추출과정
		String ext = FilenameUtils.getExtension(originalFilename);
		
		//
		String uploadFileName=null;
		if(MediaConfirm.getMediaType(ext.toLowerCase())!=null){//이미지파일임
			makeThumbnail(upPath,savePath,savedName);
			System.out.println("image");
			this.files.setOriginImgFileName(savePath+File.separator+savedName);
		}else {//이미지파일이아니다
			makeIcon(upPath,savePath,savedName);
			System.out.println("smthin else");
		}
		System.out.println("Db에 저장될이름, 태그로사용될이름:"+this.files.toString());
		return this.files;
	}
	
	private void makeThumbnail(String upPath, String savePath, String savedName)throws IOException {
		System.out.println(upPath+savePath+savedName); 
			String originUpFileName=upPath+savePath+File.separator+savedName;//업로도된 원본파일이름
		BufferedImage originFile= ImageIO.read(new File(originUpFileName));//원본이미지 파일 객체
		BufferedImage destFile=Scalr.resize(originFile,Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);//높이 100 기준 리사이즈
		String thumbnailImgName=upPath+savePath+File.separator+"thumb_"+savedName;
		File newThumbnailFile= new File(thumbnailImgName);
		String ext = FilenameUtils.getExtension(savedName);
		ImageIO.write(destFile,ext, newThumbnailFile);
		this.files.setThumbnailImgFileName(thumbnailImgName.substring(upPath.length()).replace(File.separator, "/"));
		
	}
	
	private void makeIcon(String upPath, String savePath, String savedName) {
		String iconName=upPath+savePath+File.separator+savedName;
		
		this.files.setNotImgFileName( iconName.substring(upPath.length()).replace(File.separator, "/"));
		
	}

	
	

	/**
	 * @date:2021. 9. 3.
	 * @param upPath
	 * @return : 하위폴더 경로
	 * return value:
	 */
	private String calculatePath(String upPath) {
		// TODO Auto-generated method stub
		Calendar cal=Calendar.getInstance();
		String yearPath=File.separator+(cal.get(Calendar.YEAR)+"");// \2021
		String monthPath=yearPath+File.separator+new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath=monthPath+File.separator+new DecimalFormat("00").format(cal.get(Calendar.DATE));
		System.out.println(datePath);
		makeDir(upPath,yearPath,monthPath,datePath);
		return datePath;
	}

	/**
	 * @date:2021. 9. 3.
	 * @param upPath
	 * @param yearPath
	 * @param monthPath
	 * @param datePath
	 * return value:
	 */
	private void makeDir(String upPath, String... paths) {
		//String ... paths 매개변수 타입이 같은게 여러개일경우 이런식으로하면 위에서 배열을 만들필요도없이 받는곳에서 배열로 만들어서 받는듯.
		if(new File(upPath+paths[paths.length-1]).exists()) {
			//만들필요가 없어지는거다
//			System.out.println(paths[paths.length]);
			return;// 그냥 리턴해줌
		}
		for(String path:paths) {
			File dirPath=new File(upPath+path);
			if(!dirPath.exists()) {
				dirPath.mkdirs();//폴더만드는곳
			}
		}
	}

}
