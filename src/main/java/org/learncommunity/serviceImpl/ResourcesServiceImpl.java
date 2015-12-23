package org.learncommunity.serviceImpl;

import org.learncommunity.dao.ResourcesMapper;
import org.learncommunity.dao.TopicMapper;
import org.learncommunity.entity.Resources;
import org.learncommunity.entity.Topic;
import org.learncommunity.service.ResourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
@Service
public class ResourcesServiceImpl implements ResourcesService {

    @Autowired
    private ResourcesMapper resourcesMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return resourcesMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Resources record) {
        return resourcesMapper.insert(record);
    }

    @Override
    public int insertSelective(Resources record) {
        return resourcesMapper.insertSelective(record);
    }

    @Override
    public Resources selectByPrimaryKey(Integer id) {
        return resourcesMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Resources record) {
        return resourcesMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Resources record) {
        return resourcesMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Resources> selectAll() {
        return resourcesMapper.selectAll();
    }

    @Override
    public List<Resources> selectByCourseType(String courseType) {
        return resourcesMapper.selectByCourseType(courseType);
    }

    @Override
    public List<Resources> selectByUserId(int userId, int offset, int limit) {
        return resourcesMapper.selectByUserId(userId, (offset - 1) * limit, limit);
    }

    @Override
    public List<Resources> selectByNameOrType(String name, String type, int offset, int limit) {
        return resourcesMapper.selectByNameOrType(name, type, (offset - 1) * limit, limit);
    }

}
