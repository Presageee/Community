package org.learncommunity.service;

import org.learncommunity.entity.Media;

import java.util.List;

/**
 * Created by LJT on 2015/12/10.
 */
public interface MediaService {
    int deleteByPrimaryKey(Integer id);

    int insert(Media record);

    int insertSelective(Media record);

    Media selectByPrimaryKey(Integer id);

    Media selectMediaJoinUserByPK(Integer id);

    int updateByPrimaryKeySelective(Media record);

    int updateByPrimaryKey(Media record);

    List<Media> selectByUserId(int userId, int offset, int limit);

    List<Media> selectByNameOrType(String name, String type, int offset, int limit);
}
