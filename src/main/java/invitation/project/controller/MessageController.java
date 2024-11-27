package invitation.project.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import project.invitation.domain.MessageVO;
import project.invitation.service.MessageService;

@Controller
@Log4j
@RequestMapping("/invitation/*")
@RequiredArgsConstructor
public class MessageController {
	
	private final MessageService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list", service.getList());
	}
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(MessageVO messageVO , RedirectAttributes rttr) {
		
		log.info("register.......: "+messageVO);
		service.register(messageVO);
		
		rttr.addFlashAttribute("result", messageVO.getMno());
		return "redirect:/invitation/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("mno") Long mno, Model model) {
		log.info("/get");
		model.addAttribute("messageVO", service.get(mno));
	}
	
	
//	@PostMapping("/modify")
//	public String modify(MessageVO messageVO, RedirectAttributes rttr) {
//	    log.info("Updating message: " + messageVO);
//	    
//	    // content가 null일 경우 빈 문자열로 처리
//	    //if (messageVO.getContent() == null) {
//	    //    messageVO.setContent(""); // 빈 문자열을 기본값으로 설정
//	    //}
//	    
//	    // service.modify()가 boolean 값을 반환한다고 가정
//	    boolean isUpdated = service.modify(messageVO); 
//	    
//	    // 업데이트가 성공했을 경우
//	    if (isUpdated) {
//	        rttr.addFlashAttribute("result", "success");
//	    } else {
//	        rttr.addFlashAttribute("result", "fail");
//	    }
//	    
//	    return "redirect:/invitation/list";  // 결과에 따라 리다이렉트
//	}
	
	
	@PostMapping("/modify")
	public ResponseEntity<String> modify(@RequestBody MessageVO messageVO) {
	    log.info("Received messageVO: " + messageVO);

	    log.info("Content: " + messageVO.getContent());
	    log.info("Mno: " + messageVO.getMno());
	    
	    if (messageVO.getGetEnteredPassword() == null || messageVO.getGetEnteredPassword().isEmpty()) {
	        return ResponseEntity.badRequest().body("{\"error\": \"비밀번호를 입력하세요.\"}");
	    }

	    if (messageVO.getContent() == null) {
	        messageVO.setContent("");  // 빈 문자열로 처리
	    }

	    boolean isUpdated = service.modify(messageVO);

	    if (isUpdated) {
	        return ResponseEntity.ok("{\"result\": \"success\"}");
	    } else {
	        return ResponseEntity.status(400).body("{\"result\": \"fail\"}");
	    }
	    
	 
	}
	   
	
	@PostMapping("/remove")
    @ResponseBody
    public String remove(@RequestParam Long mno, @RequestParam String enteredPassword) {
        // DB에서 게시글 정보 가져오기
        MessageVO messageVO = service.get(mno);

        // DB에 저장된 비밀번호와 입력된 비밀번호 비교
        if (messageVO != null && messageVO.getGuestpw().equals(enteredPassword)) {
            // 비밀번호 일치하면 삭제 처리
            boolean isRemoved = service.remove(mno);
            log.info("*************");
            log.info(messageVO);
            log.info(isRemoved);
            log.info("*************");
            if (isRemoved) {
            	
                return "success";  // 삭제 성공
            }
        }

        return "fail";  // 비밀번호 불일치 또는 삭제 실패
    }
	
	 @GetMapping("/getGuestPwByMno")
	 @RequestMapping
	    public String getGuestPwByMno(@RequestParam("mno") Long mno, @RequestParam("enteredPassword") String enteredPassword) {
	        // 게시글 번호(mno)로 비밀번호를 가져옴
	        String guestpw = service.getGuestPwByMno(mno);

	        // 비밀번호 비교 로직
	        if (guestpw != null && guestpw.equals(enteredPassword)) {
	            return guestpw; // 비밀번호가 맞으면 반환
	        } else {
	            return null; // 비밀번호가 틀리면 null 반환
	        }
	    }
	
	@PostMapping("/invitation/validatePassword")
    public String validatePassword(@RequestParam("mno") Long mno, @RequestParam("enteredPassword") String enteredPassword, Model model) {
        // DB에서 guestpw 가져오기
        String guestpw =service.getGuestPwByMno(mno);

        // 입력된 비밀번호와 DB 비밀번호 비교
        if (guestpw != null && guestpw.equals(enteredPassword)) {
            // 비밀번호가 맞으면 수정 페이지로 이동
            return "redirect:/invitation/edit?mno=" + mno;
        } else {
            // 비밀번호가 틀리면 에러 메시지
            model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
            return "errorPage";  // 에러 페이지로 이동
        }
    }
}
