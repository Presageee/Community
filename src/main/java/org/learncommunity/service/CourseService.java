package org.learncommunity.service;

import org.learncommunity.entity.Course;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
public interface CourseService {
    int deleteByPrimaryKey(Integer id);

    int insert(Course record);

    int insertSelective(Course record);

    Course selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    List<Course> selectAll();
}
