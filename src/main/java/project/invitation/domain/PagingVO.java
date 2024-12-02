package project.invitation.domain;



import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PagingVO {

	private int startPage;
	private int endPage;
	private boolean prev,next;
	
	private int total;
	private ViewList viewlist;
	
	public PagingVO(ViewList viewList ,int total) {
		
		this.viewlist = viewList;
		this.total = total;
		
		System.out.println(viewList.getPageNum());
		System.out.println(viewList.getAmount());
		
		int realEnd = (int)(Math.ceil((total*1.0)/viewList.getAmount()));
		
		this.endPage = (int)(Math.ceil(viewList.getPageNum()/(double)viewList.getAmount()) * viewList.getAmount());
		startPage = this.endPage -9;
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		// startPage가 1보다 작은 경우 1로 설정
		if (this.startPage < 1) {
			this.startPage = 1;
		}
		
		
		this.prev = startPage>1;
		this.next = this.endPage < realEnd;
	}
}
