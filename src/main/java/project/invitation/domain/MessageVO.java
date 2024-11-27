package project.invitation.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MessageVO {

	private Long mno;
	private String content;
	private Date regdate;
	private String guestpw;
	private String writer;
	private String getEnteredPassword;
}
