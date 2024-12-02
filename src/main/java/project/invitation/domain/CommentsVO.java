package project.invitation.domain;

import java.util.Date;

import project.invitation.domain.CommentsVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommentsVO {
	private Long mno;
	private Long cno;
	
	private String c_content; //답변내용
	private String commenter; //작성자
	
	private Date c_date;
	
}
