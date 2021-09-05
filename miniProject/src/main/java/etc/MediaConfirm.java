package etc;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

/**
 * @author A
 * @packageName:com.miniProject.etc;
 * @fileName:MediaConfirm.java
 * @date: 2021. 9. 3 description :
 */
public class MediaConfirm {
   private static Map<String, MediaType> mediMap;

   static { //현재 클래스의 멤버 중에서 static 멤버가 초기화를 할 수 있는 블록
      //static을 쓰지 않으면? 인스턴스 멤버가 초기화되는 블록이 된다.

      mediMap = new HashMap<String, MediaType>();

      // 이미지 파일 형식을 맵에 넣어두고 맵에 없는 확장자라면 이미지가 아니다.
      mediMap.put("jpg", MediaType.IMAGE_JPEG);
      mediMap.put("gif", MediaType.IMAGE_GIF);
      mediMap.put("png", MediaType.IMAGE_PNG);
      mediMap.put("jpeg", MediaType.IMAGE_JPEG);
   }

   /**
    * @date : 2021. 9. 3
    * @param ext
    * @author A return value :
    * @return 
    */
   public static MediaType getMediaType(String ext) {
      return mediMap.get(ext);
   }

}