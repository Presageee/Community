package org.learncommunity.service;

import org.apache.ibatis.annotations.Param;
import org.learncommunity.entity.Reply;
import org.learncommunity.entity.Topic;

import java.util.List;

/**
 * Created by LJT on 2015/12/9.
 */
public interface TopicService {
    int deleteByPrimaryKey(Integer id);

    int insert(Topic record);

    int insertSelective(Topic record);

    Topic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKey(Topic record);

    List<Topic> queryForList();

    List<Topic> selectByUserId( Integer userId, Integer offset, Integer limit);

    List<Topic> selectLimit(Integer offset, Integer limit);

    List<Topic> selectLimitByUserId(Integer userId, Integer offset, Integer limit);

    List<Topic> selectByTitleOrType(String name, String type, int offset, int limit);
}