package org.learncommunity.serviceImpl;

import org.learncommunity.dao.ReplyMapper;
import org.learncommunity.entity.Reply;
import org.learncommunity.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
@Service
public class ReplyServiceImpl implements ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return replyMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Reply record) {
        return replyMapper.insert(record);
    }

    @Override
    public int insertSelective(Reply record) {
        return replyMapper.insertSelective(record);
    }

    @Override
    public Reply selectByPrimaryKey(Integer id) {
        return replyMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Reply record) {
        return replyMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Reply record) {
        return replyMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Reply> selectByUserId(int userId, int offset, int limit) {
        return replyMapper.selectByUserId(userId, offset, limit);
    }

    @Override
    public List<Reply> selectLimitByTopicId(int topicId, int offset, int limit) {
        return replyMapper.selectLimitByTopicId(topicId, (offset - 1) * limit, limit);
    }
}
