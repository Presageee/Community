package org.learncommunity.dao;

import org.learncommunity.entity.CourseType;

import java.util.List;

public interface CourseTypeMapper {
    int deleteByPrimaryKey(CourseType key);

    int insert(CourseType record);

    int insertSelective(CourseType record);

    List<CourseType> selectAll();
}