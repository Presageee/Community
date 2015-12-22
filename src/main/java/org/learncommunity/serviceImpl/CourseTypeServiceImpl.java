package org.learncommunity.serviceImpl;

import org.learncommunity.dao.CourseTypeMapper;
import org.learncommunity.entity.CourseType;
import org.learncommunity.service.CourseTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
@Service
public class CourseTypeServiceImpl implements CourseTypeService {

    @Autowired
    private CourseTypeMapper courseTypeMapper;

    @Override
    public int deleteByPrimaryKey(CourseType key) {
        return courseTypeMapper.deleteByPrimaryKey(key);
    }

    @Override
    public int insert(CourseType record) {
        return courseTypeMapper.insert(record);
    }

    @Override
    public int insertSelective(CourseType record) {
        return courseTypeMapper.insertSelective(record);
    }

    @Override
    public List<CourseType> selectAll() {
        return courseTypeMapper.selectAll();
    }
}
