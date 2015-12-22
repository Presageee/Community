package org.learncommunity.dao;

import org.apache.ibatis.annotations.Param;
import org.learncommunity.entity.Reply;

import java.util.List;

public interface ReplyMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Reply record);

    int insertSelective(Reply record);

    Reply selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Reply record);

    int updateByPrimaryKey(Reply record);

    List<Reply> selectByUserId(@Param("userid") Integer userId, @Param("offset") Integer offset, @Param("limit") Integer limit);

    List<Reply> selectLimitByTopicId(@Param("topicid") Integer topicId, @Param("offset") Integer offset, @Param("limit") Integer limit);
}