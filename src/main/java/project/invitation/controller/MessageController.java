package project.invitation.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
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
import project.invitation.domain.PagingVO;
import project.invitation.domain.ViewList;
import project.invitation.service.MessageService;

@Controller
@Log4j
@RequestMapping("/invitation/*")
@RequiredArgsConstructor
public class MessageController {
	
	private final MessageService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list", service.getList());
//	}
	
	@GetMapping("/list")
	public void list(@RequestParam(value = "page", defaultValue = "1") int pageNum,ViewList viewlist,Model model) {
		log.info("list........"+viewlist);
		
		// pageNum 값을 ViewList 객체에 반영
	    viewlist.setPageNum(pageNum);  // 페이지 번호를 ViewList에 반영

	    // 게시글 목록 조회
		List<MessageVO> list = service.getList(viewlist);
		model.addAttribute("list",list);
		
		// 전체 게시글 개수 조회
		int total = service.getTotal(viewlist);
		model.addAttribute("total", total);
		
		log.info("ViewList: "+ viewlist);
		log.info("Total Posts: "+ total);
		
		// PagingVO 객체 생성
	    PagingVO pagingVO = new PagingVO(viewlist, total);
	    model.addAttribute("pageMaker", pagingVO);
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
	
	
	@PostMapping("/modify")
	public ResponseEntity<String> modify(@RequestParam ("mno") Long mno,@RequestParam ("content")String content,@RequestParam ("guestpw") String guestpw, RedirectAttributes rttr) {
	    log.info("Updating message: ");
	    
	    
	    MessageVO vo = new MessageVO();
	    vo.setContent(content);
	    vo.setMno(mno);
	    vo.setGuestpw(guestpw);
	    
	    boolean isUpdated = service.modify(vo); 
	    log.info("isUpdated : "+isUpdated);
	    // 업데이트가 성공했을 경우
	    if (isUpdated) {
	    	return new ResponseEntity<String>("success" ,HttpStatus.OK); 
	       
	    } else {

	    	return new ResponseEntity<String>("Error" ,HttpStatus.OK);
	     
	    }
	    
	     // 결과에 따라 리다이렉트
	}
	
	
//	@PostMapping("/modify")
//	public ResponseEntity<String> modify(@RequestBody MessageVO messageVO) {
//	    log.info("Received messageVO: " + messageVO);
//
//	    log.info("Content: " + messageVO.getContent());
//	    log.info("Mno: " + messageVO.getMno());
//	    
//
//	    if (messageVO.getContent() != null) {
//	        messageVO.setContent("");  // 빈 문자열로 처리
//	    }
//
//	    boolean isUpdated = service.modify(messageVO);
//
//	    if (isUpdated) {
//	        return ResponseEntity.ok("{\"result\": \"success\"}");
//	    } else {
//	        return ResponseEntity.status(400).body("{\"result\": \"fail\"}");
//	    }
//	    
//	 
//	}
	   
	
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
	    public ResponseEntity<String> getGuestPwByMno(@RequestParam("mno") Long mno, @RequestParam("enteredPassword") String enteredPassword) {
	        // 게시글 번호(mno)로 비밀번호를 가져옴
	        String guestpw = service.getGuestPwByMno(mno);
	        log.info("guestpw : "+guestpw);
	        
	        if (guestpw.equals(enteredPassword)) {
	        	return new ResponseEntity<String>(guestpw, HttpStatus.OK);
		    } 
	        else {
	        	return new ResponseEntity<String>("Error" ,HttpStatus.OK);
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
	
	@RequestMapping("/wedding")
    public String showWeddingPage() {
        // "/WEB-INF/views/invitation/wedding.jsp"를 보여준다
        return "invitation/wedding";  // JSP 뷰 이름 반환
    }
}
