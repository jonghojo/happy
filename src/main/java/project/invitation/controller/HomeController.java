package project.invitation.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	 @RequestMapping("/") // 서버 루트 경로에 접근할 때
	    public String Wedding() {
	        // "/invitation/wedding.jsp"로 리다이렉트
	        return "redirect:/invitation/wedding";  // 이 경로로 리다이렉트
	    }
	
}
