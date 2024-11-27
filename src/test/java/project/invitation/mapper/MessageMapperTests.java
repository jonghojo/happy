package project.invitation.mapper;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import project.invitation.domain.MessageVO;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class MessageMapperTests {

	@Autowired
	private MessageMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		MessageVO messageVO = new MessageVO();
		messageVO.setContent("축하해요");
		messageVO.setWriter("guest1");
		messageVO.setGuestpw("1234");
		mapper.insert(messageVO);
		
		log.info(messageVO);
	}
	
	@Test
	public void testRead() {
		MessageVO messageVO = mapper.read(1L);
		log.info(messageVO);
	}
	
	@Test
	public void testDelete() {
		log.info("DELETE COUNT : " + mapper.delete(2L));
	}
	@Test
	public void testUpdate() {
		MessageVO messageVO = new MessageVO();
		
		messageVO.setMno(2L);
		messageVO.setContent("축해해요 수정");
		
		int count = mapper.update(messageVO);
		log.info(count);
	}
	
}
