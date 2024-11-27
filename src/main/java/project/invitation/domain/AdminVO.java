package project.invitation.domain;

import java.util.List;

import lombok.Data;

@Data
public class AdminVO {

	private String admin_id;
	private String admin_pw;
	
	private List<AuthVO> authList;
}
