package org.learncommunity.serviceImpl;

import org.learncommunity.dao.TopicMapper;
import org.learncommunity.entity.Topic;
import org.learncommunity.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by LJT on 2015/12/9.
 */
@Service
public class TopicServiceImpl implements TopicService{

    @Autowired
    public TopicMapper topicMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return topicMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Topic record) {
        return topicMapper.insert(record);
    }

    @Override
    public int insertSelective(Topic record) {
        return topicMapper.insertSelective(record);
    }

    @Override
    public Topic selectByPrimaryKey(Integer id) {
        return topicMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Topic record) {
        return topicMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Topic record) {
        return topicMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Topic> queryForList() {
        return topicMapper.queryForList();
    }

    @Override
    public List<Topic> selectByUserId(Integer userId, Integer offset, Integer limit) {
        return topicMapper.selectByUserId(userId, (offset - 1) * limit, limit);
    }

    @Override
    public List<Topic> selectLimit(Integer offset, Integer limit) {
        return topicMapper.selectLimit(offset, limit);
    }

    @Override
    public List<Topic> selectLimitByUserId(Integer userId, Integer offset, Integer limit) {
        return topicMapper.selectLimitByUserId(userId, offset, limit);
    }

    @Override
    public List<Topic> selectByTitleOrType(String name, String type, int offset, int limit) {
        return topicMapper.selectByTitleOrType(name, type, (offset - 1) * limit, limit);
    }
}
