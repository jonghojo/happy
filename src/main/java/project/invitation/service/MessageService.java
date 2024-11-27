package project.invitation.service;

import java.util.List;

import project.invitation.domain.MessageVO;

public interface MessageService {

	public void register(MessageVO messageVO);
	
	public MessageVO get(Long mno);
	
	public boolean modify(MessageVO messageVO);
	
	public boolean remove(Long mno);
	
	public List<MessageVO> getList();
	
	public boolean checkpw(MessageVO messageVO);
	
	public String getGuestPwByMno(Long mno);
}
