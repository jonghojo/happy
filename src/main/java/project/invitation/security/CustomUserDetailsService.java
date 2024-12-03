package project.invitation.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import project.invitation.domain.AdminVO;
import project.invitation.mapper.AdminMapper;
import project.invitation.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        
        log.warn("-----------------" + username);
        
        // adminMapper에서 사용자 정보를 읽어옴
        AdminVO vo = adminMapper.read(username);
        
        log.warn("-----------------" + vo);
        
        // 사용자 정보를 찾지 못한 경우 예외를 던짐
        if (vo == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }
        
        // CustomUser 객체에 권한 목록을 빈 리스트로 전달하여 권한 없이 사용자를 반환
        return new CustomUser(vo);
    }
}
