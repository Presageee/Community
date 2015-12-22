package org.learncommunity.serviceImpl;

import org.learncommunity.dao.MediaMapper;
import org.learncommunity.entity.Media;
import org.learncommunity.service.MediaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
@Service
public class MediaServiceImpl implements MediaService {

    @Autowired
    private MediaMapper mediaMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mediaMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Media record) {
        return mediaMapper.insert(record);
    }

    @Override
    public int insertSelective(Media record) {
        return mediaMapper.insertSelective(record);
    }

    @Override
    public Media selectByPrimaryKey(Integer id) {
        return mediaMapper.selectByPrimaryKey(id);
    }

    @Override
    public Media selectMediaJoinUserByPK(Integer id) {
        return mediaMapper.selectMediaJoinUserByPK(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Media record) {
        return mediaMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(Media record) {
        return mediaMapper.updateByPrimaryKey(record);
    }

    @Override
    public List<Media> selectByUserId(int userId, int offset, int limit) {
        return mediaMapper.selectByUserId(userId, (offset - 1) * limit, limit);
    }

    @Override
    public List<Media> selectByNameOrType(String name, String type, int offset, int limit) {
        return mediaMapper.selectByNameOrType(name, type, (offset - 1) * limit, limit);
    }
}
