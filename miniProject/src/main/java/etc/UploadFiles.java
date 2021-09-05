/**
 * 
 */
package etc;

/**
 * @author baekd
 * @packageName: etc
 * @fileName: UploadImgs.java
 * @date: 2021. 9. 3.
 * description:
 */
public class UploadFiles {
 private String originImgFileName;
 private String thumbnailImgFileName;
 private String notImgFileName;
public String getOriginImgFileName() {
	return originImgFileName;
}
public void setOriginImgFileName(String originImgFileName) {
	this.originImgFileName = originImgFileName;
}
public String getThumbnailImgFileName() {
	return thumbnailImgFileName;
}
public void setThumbnailImgFileName(String thumbnailImgFileName) {
	this.thumbnailImgFileName = thumbnailImgFileName;
}
public String getNotImgFileName() {
	return notImgFileName;
}
public void setNotImgFileName(String notImgFileName) {
	this.notImgFileName = notImgFileName;
}
@Override
public String toString() {
	return "UploadFiles [originImgFileName=" + originImgFileName + ", thumbnailImgFileName=" + thumbnailImgFileName
			+ ", notImgFileName=" + notImgFileName + "]";
}

 
}
