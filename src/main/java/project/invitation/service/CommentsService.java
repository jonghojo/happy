package project.invitation.service;

import java.util.List;

import org.springframework.stereotype.Service;

import project.invitation.domain.CommentsVO;
import project.invitation.domain.Criterial;

@Service
public interface CommentsService {
	
	public void register(CommentsVO vo); //insert
	
	public CommentsVO get(Long cno);//read
	
	public int modify(CommentsVO vo);//update
	
	public int remove(Long cno, String commenter);//delete
	
	public List<CommentsVO> getList(Long mno);

//	public List<CommentsVO> getList(Criterial cri);
	
}
