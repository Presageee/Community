package org.learncommunity.service;

import org.learncommunity.entity.Reply;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
public interface ReplyService {
    int deleteByPrimaryKey(Integer id);

    int insert(Reply record);

    int insertSelective(Reply record);

    Reply selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Reply record);

    int updateByPrimaryKey(Reply record);

    List<Reply> selectByUserId(int userId, int offset, int limit);

    List<Reply> selectLimitByTopicId(int topicId, int offset, int limit);
}
