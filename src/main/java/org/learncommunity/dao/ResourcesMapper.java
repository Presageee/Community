package org.learncommunity.dao;

import org.apache.ibatis.annotations.Param;
import org.learncommunity.entity.Resources;

import java.util.List;

public interface ResourcesMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Resources record);

    int insertSelective(Resources record);

    Resources selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Resources record);

    int updateByPrimaryKey(Resources record);

    List<Resources> selectAll();

    List<Resources> selectByCourseType(String courseType);

    List<Resources> selectByUserId(@Param("uploaderid") Integer userid, @Param("offset") Integer offset, @Param("limit") Integer limit);

    List<Resources> selectByNameOrType(@Param("name") String name, @Param("type") String type, @Param("offset") Integer offset, @Param("limit") Integer limit);
}