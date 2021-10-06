/**
 * 
 */
package com.gootdate.domain;

/**
 * @author baekd
 * @packageName: domain
 * @fileName: PagingInfoDTO.java
 * @date: 2021. 9. 7.
 * description:
 */
public class PagingInfoDTO {
	private int postPerPage = 10; // 페이지당 글 갯수
	   private int pageCntPerBlock = 10; // 블럭 당 페이지 수
	   
	   private int totalPage; // 전체 페이지 수
	   private int startNum; // 출력 시작할 번호
	   
	   private int currentPagingBlock;  // 현재 페이지가 속한 블록
	   private int startPageNoOfBlock;  // 블록의 시작페이지 번호
	   private int endPageNoOfBlock;    // 블록의 끝 페이지 번호
	   private int totalPagingBlockCnt; // 전체 페이징블록 갯수
	   
	   public PagingInfoDTO() {
		   super();
	   }
	   
	   public PagingInfoDTO(int postPerPage, int pageCntPerBlock, int totalPage, int startNum, int currentPagingBlock,
	         int startPageNoOfBlock, int endPageNoOfBlock, int totalPagingBlockCnt) {
	      super();
	      this.postPerPage = postPerPage;
	      this.pageCntPerBlock = pageCntPerBlock;
	      this.totalPage = totalPage;
	      this.startNum = startNum;
	      this.currentPagingBlock = currentPagingBlock;
	      this.startPageNoOfBlock = startPageNoOfBlock;
	      this.endPageNoOfBlock = endPageNoOfBlock;
	      this.totalPagingBlockCnt = totalPagingBlockCnt;
	   }
	   
	   public int getPostPerPage() {
	      return postPerPage;
	   }
	   public void setPostPerPage(int postPerPage) {
	      this.postPerPage = postPerPage;
	   }
	   public int getPageCntPerBlock() {
	      return pageCntPerBlock;
	   }
	   
	   public void setPageCntPerBlock(int pageCntPerBlock) {
	      this.pageCntPerBlock = pageCntPerBlock;
	   }
	   
	   public int getTotalPage() {
	      return totalPage;
	   }
	   
	   public void setTotalPage(int totalPost) {
	      // 전체 페이지 수 : 전체 글의 갯수 / 페이지당 보여줄 글의 갯수(나누어 떨어지지 않았다면 + 1)
	      if (totalPost % this.postPerPage != 0) {
	         this.totalPage = (totalPost / this.postPerPage) + 1;
	      } else {
	         this.totalPage = totalPost / this.postPerPage;
	      }
	   }
	   
	   public int getStartNum() {
	      return this.startNum;
	   }
	   public void setStartNum(int pageNo) {
	      // 출력시작할 번호 : (현재페이지번호 - 1) * 한 페이지당 보여줄 글의 갯수
	      this.startNum = (pageNo - 1) * this.postPerPage;
	   }
	   public int getCurrentPagingBlock() {
	      return currentPagingBlock;
	   }
	   
	   public void setCurrentPagingBlock(int pageNo) {
	      // -- * 현재 페이징 블록 = 현재페이지번호 / 페이징블록 (올림)
	      this.currentPagingBlock = (int)(Math.ceil((float)pageNo / this.pageCntPerBlock));
	   }
	   
	   public int getStartPageNoOfBlock() {
	      return startPageNoOfBlock;
	   }
	   public void setStartPageNoOfBlock(int currrentPagingBlock) {
	      // * 현재 페이징 블록의 시작페이지번호 = ((현재 페이징 블록 - 1) * 페이징블록) + 1
	      this.startPageNoOfBlock = ((currrentPagingBlock - 1) * this.pageCntPerBlock) + 1;
	   }
	   
	   public int getEndPageNoOfBlock() {
	      return endPageNoOfBlock;
	   }
	   
	   public void setEndPageNoOfBlock(int startPageNoOfBlock) {
	      //현재 페이징 블록의 끝 페이지 번호 = (현재 페이징 블록시작페이지 번호 + 페이징블록) - 1
	      this.endPageNoOfBlock = (startPageNoOfBlock + this.pageCntPerBlock) - 1;
	      
	      // 없는 페이지가 페이지블록에 나오는 걸 방지
	      if (this.totalPage < this.endPageNoOfBlock) {  
	         this.endPageNoOfBlock = this.totalPage;
	      }
	   }
	   
	   public int getTotalPagingBlockCnt() {
	      return totalPagingBlockCnt;
	   }
	   public void setTotalPagingBlockCnt(int totalPage) {
	      // 전체 페이징블록 수 = 전체페이지수 / 페이징 블록 (나누어 떨어지지 않으면 + 1)
	      this.totalPagingBlockCnt = (int)Math.ceil((float)totalPage / this.pageCntPerBlock);
	   }
	   
	   @Override
	   public String toString() {
	      return "PagingInfo [페이지당글갯수=" + postPerPage + ", 블럭당페이지수=" + pageCntPerBlock + ", 전체페이지수="
	            + totalPage + ", 출력시작할번호=" + startNum + ", 현재페이징블록=" + currentPagingBlock
	            + ", 블럭의시작페이지번호=" + startPageNoOfBlock + ", 블럭의끝페이지번호=" + endPageNoOfBlock
	            + ", 전체페이징블럭수=" + totalPagingBlockCnt + "]";
	   }
	   

}
