package project.invitation.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ViewList {
	
	private int pageNum;		//페이지번호
	private int amount;			//화면당 레코드 갯수
	
	private String type;		//내용 or 작성
	private String keyword;		//검색어
	
	public ViewList() {
		this(1,5);
	}
	
	public ViewList(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public 	String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
 	}

}
