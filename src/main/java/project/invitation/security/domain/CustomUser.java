package project.invitation.security.domain;

import org.springframework.security.core.userdetails.User;

import project.invitation.domain.AdminVO;

import java.util.Collections;

public class CustomUser extends User {

    private AdminVO adminVO;

    public CustomUser(AdminVO adminVO) {
        // User 클래스의 생성자는 사용자 이름, 비밀번호, 권한 목록 등을 받습니다.
        // 여기서 권한을 빈 리스트로 전달하여 권한이 없는 사용자로 설정합니다.
        super(adminVO.getUsername(), adminVO.getAdmin_password(), Collections.emptyList());
        this.adminVO = adminVO;
    }

    @Override
    public String getUsername() {
        // 제대로 username을 반환하는지 확인하는 로그 추가
        String username = super.getUsername();
        System.out.println("CustomUser username: " + username);  // 이 부분을 확인
        return username;
    }

    public AdminVO getAdminVO() {
        return adminVO;
    }
}
