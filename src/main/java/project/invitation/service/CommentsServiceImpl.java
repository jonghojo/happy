package project.invitation.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import project.invitation.domain.CommentsVO;
import project.invitation.domain.Criterial;
import project.invitation.mapper.CommentsMapper;
import project.invitation.mapper.MessageMapper;

@Service
@Log4j
@RequiredArgsConstructor
public class CommentsServiceImpl implements CommentsService {

    // 하나의 CommentsMapper만 주입
    private final CommentsMapper commentsMapper;

    private final MessageMapper messageMapper;

    @Override
    public void  register(CommentsVO vo) {
        log.info("register......" + vo);
        int result = commentsMapper.insert(vo); // Mapper 호출
        if (result != 1) {
            throw new RuntimeException("Failed to insert comment");
        }
    }

    @Override
    public CommentsVO get(Long cno) {
        log.info("get......" + cno);
        return commentsMapper.read(cno);
    }

    @Override
    public int modify(CommentsVO vo) {
        log.info("modify......" + vo);
        return commentsMapper.update(vo);
    }

    @Override
    public int remove(Long cno, String commenter) {
        log.info("remove......" + cno);
        CommentsVO co = commentsMapper.read(cno);
        return commentsMapper.delete(cno);
    }

    @Override
    public List<CommentsVO> getList(Long mno) {
        log.info("getList......" + mno);
        return commentsMapper.getList(mno); // 페이징 없이 댓글 목록 조회
    }

}
