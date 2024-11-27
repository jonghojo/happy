package project.invitation.service;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import project.invitation.domain.MessageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MessageServiceTests {

	@Autowired
	private MessageService service;
	
	@Test
	public void testRegister() {
		MessageVO messageVO = new MessageVO();
		messageVO.setContent("축하해요2");
		messageVO.setWriter("guest2");
		messageVO.setGuestpw("1234");
		
		service.register(messageVO);
		
		log.info("");
	}

}
