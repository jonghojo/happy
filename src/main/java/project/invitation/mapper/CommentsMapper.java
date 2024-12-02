package project.invitation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import project.invitation.domain.CommentsVO;
import project.invitation.domain.Criterial;

@Mapper
public interface CommentsMapper {

	public int insert(CommentsVO vo);
	
	public CommentsVO read(Long cno);
	
	public int delete(Long cno);
	
	public int update(CommentsVO vo);
	
	public List<CommentsVO> getList(Long mno);

	List<CommentsVO> getCommentsByAdminId(String adminId);
	
	
}
