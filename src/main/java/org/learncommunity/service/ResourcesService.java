package org.learncommunity.service;

import org.learncommunity.entity.Media;
import org.learncommunity.entity.Resources;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
public interface ResourcesService {
    int deleteByPrimaryKey(Integer id);

    int insert(Resources record);

    int insertSelective(Resources record);

    Resources selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Resources record);

    int updateByPrimaryKey(Resources record);

    List<Resources> selectAll();

    List<Resources> selectByCourseType(String courseType);

    List<Resources> selectByUserId(int userId, int offset, int limit);

    List<Resources> selectByNameOrType(String name, String type, int offset, int limit);
}
