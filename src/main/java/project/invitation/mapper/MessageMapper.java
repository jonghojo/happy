package project.invitation.mapper;

import java.util.List;

import project.invitation.domain.MessageVO;

public interface MessageMapper {
	
	
	public List<MessageVO> 	getList();
	
	public void insert(MessageVO messageVO);
	
	public MessageVO read(Long mno);
	
	public int delete(Long mno);
	
	public int update(MessageVO messageVO);
	
	public boolean checkguestpw(MessageVO messageVO);
	
	public String getGuestPwByMno(Long mno);

}
