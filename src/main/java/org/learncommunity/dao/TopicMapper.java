package org.learncommunity.dao;

import org.apache.ibatis.annotations.Param;
import org.learncommunity.entity.Reply;
import org.learncommunity.entity.Topic;

import java.util.List;

public interface TopicMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Topic record);

    int insertSelective(Topic record);

    Topic selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Topic record);

    int updateByPrimaryKey(Topic record);

    List<Topic> queryForList();

    List<Topic> selectByUserId(@Param("userid") Integer userId, @Param("offset") Integer offset, @Param("limit") Integer limit);

    List<Topic> selectLimit(@Param("offset") Integer offset, @Param("limit") Integer limit);

    List<Topic> selectByTitleOrType(@Param("title") String title, @Param("type") String type, @Param("offset") Integer offset, @Param("limit") Integer limit);

    List<Topic> selectLimitByUserId(@Param("userid") Integer userId, @Param("offset") Integer offset, @Param("limit") Integer limit);
}