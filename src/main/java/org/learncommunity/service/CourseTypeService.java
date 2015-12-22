package org.learncommunity.service;

import org.learncommunity.entity.CourseType;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
public interface CourseTypeService {
    int deleteByPrimaryKey(CourseType key);

    int insert(CourseType record);

    int insertSelective(CourseType record);

    List<CourseType> selectAll();
}
