package org.learncommunity.dao;

import org.apache.ibatis.annotations.Param;
import org.learncommunity.entity.Media;

import java.util.List;

public interface MediaMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Media record);

    int insertSelective(Media record);

    Media selectByPrimaryKey(Integer id);

    Media selectMediaJoinUserByPK(Integer id);

    int updateByPrimaryKeySelective(Media record);

    int updateByPrimaryKey(Media record);

    List<Media> selectByUserId(@Param("uploaderid") int userId, @Param("offset")int offset, @Param("limit") int limit);

    List<Media> selectByNameOrType(@Param("name") String name, @Param("type") String type, @Param("offset") Integer offset, @Param("limit") Integer limit);
}