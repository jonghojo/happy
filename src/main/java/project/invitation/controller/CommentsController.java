package project.invitation.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import project.invitation.controller.CommentsController;
import project.invitation.domain.CommentsVO;
import project.invitation.domain.Criterial;
import project.invitation.service.CommentsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/comments/")
@Log4j
@RequiredArgsConstructor

public class CommentsController {
	
	private final CommentsService service;
	
	
	// 댓글 작성
    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/new", 
                 consumes = MediaType.APPLICATION_JSON_VALUE, // 요청(json)
                 produces = MediaType.TEXT_PLAIN_VALUE) // 응답(String)
    public ResponseEntity<String> create(@RequestBody CommentsVO vo) {
        log.info("create....." + vo);

        // commenter를 DB에서 가져오기
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        log.info("Extracted username: " + username);
        vo.setCommenter(username);

        log.info("commenter : " + username);

        // 댓글 등록 실행
        service.register(vo);

        // 댓글이 게시글에 대한 댓글일 때, mno를 설정
        if (vo.getMno() != null) {
            log.info("Reply to message with mno: " + vo.getMno());
        }

        // 성공 응답 반환
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    // 게시물 번호로 댓글 조회 (페이징 없이)
    @GetMapping(value = "/list/{mno}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<CommentsVO>> getList(@PathVariable("mno") Long mno) {
        log.info("getList..........mno : " + mno);
        
        // 페이징 없이 댓글 목록 가져오기
        List<CommentsVO> list = service.getList(mno);
        log.info("Returned comments: " + list);
        
        return new ResponseEntity<>(list, HttpStatus.OK);
    }
    
    //댓글 번호로 목록 조회
    @GetMapping(value = "/detail/{cno}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<CommentsVO> get(@PathVariable("cno") Long cno){
        
        log.info("get............" + cno);
        
        CommentsVO commentsVO = service.get(cno);  // 댓글 번호로 댓글 정보 조회
        
        if (commentsVO != null) {
            return new ResponseEntity<>(commentsVO, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);  // 댓글이 없는 경우 404 반환
        }
    }

    // 댓글 삭제
    @PreAuthorize("isAuthenticated()")
    @DeleteMapping(value = "/{cno}", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> remove(@RequestBody CommentsVO vo, @PathVariable("cno") Long cno) {
        log.info("remove..... cno: " + cno + ", commenter: " + vo.getCommenter());
        
        // 댓글 삭제 처리
        int result = service.remove(cno, vo.getCommenter());
        
        if (result == 1) {
        	log.info("refdf****");
            return new ResponseEntity<>("success", HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 댓글 수정
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{cno}", 
                    consumes = {MediaType.APPLICATION_JSON_VALUE},
                    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(@PathVariable("cno") Long cno, @RequestBody CommentsVO vo) {
        // 댓글 수정 시, cno를 VO에 설정
        vo.setCno(cno);
        
        log.info("modify......... cno : " + cno + ", reply : " + vo);
        
        return service.modify(vo) == 1 
                ? new ResponseEntity<String>("success", HttpStatus.OK)
                : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
