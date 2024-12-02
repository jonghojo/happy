package project.invitation.mapper;

import java.util.List;



import project.invitation.domain.MessageVO;
import project.invitation.domain.ViewList;

public interface MessageMapper {
	
	
	public List<MessageVO> 	getList();
	
	public List<MessageVO> getListWithPage(ViewList viewlist);
	
	public void insert(MessageVO messageVO);
	
	public MessageVO read(Long mno);
	
	public int delete(Long mno);
	
	public int update(MessageVO messageVO);
	
	public int getTotalCount(ViewList viewlist);	//전체 데이터 개수
	
	public boolean checkguestpw(MessageVO messageVO);
	
	public String getGuestPwByMno(Long mno);

}
