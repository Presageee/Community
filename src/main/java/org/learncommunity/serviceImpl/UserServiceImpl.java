package org.learncommunity.serviceImpl;


import org.apache.log4j.Logger;
import org.learncommunity.dao.UserMapper;
import org.learncommunity.entity.User;
import org.learncommunity.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static org.learncommunity.util.MD5Encode.*;
import static org.learncommunity.util.RootDefine.*;

/**
 * Created by LJT on 2015/12/10.
 */
@Service
public class UserServiceImpl implements UserService {

    private static Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return userMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(User record) {
        return userMapper.insert(record);
    }

    @Override
    public int insertSelective(User record) {
        return userMapper.insertSelective(record);
    }

    @Override
    public User selectByPrimaryKey(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(User record) {
        return userMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(User record) {
        return userMapper.updateByPrimaryKey(record);
    }

    @Override
    public boolean stuLogin(String email, String password) {
        User user = userMapper.selectByEmail(email);
        //System.out.println("hahah" + user.getPassword());
        if (user == null){
            logger.info("account is not exists");
            return false;
        }
        if (MD5(password).equals(user.getPassword())){
            return true;
        }
        logger.info("incorrect password");
        return false;
    }

    @Override
    public boolean stuRegister(String email, String name, String password) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(MD5(password));
        user.setName(name);
        user.setRoot(STUDENT);
        int flag;
        flag = userMapper.insertSelective(user);
        if (flag == -1){
            logger.info("insert error,transaction rollback");
            return false;
        }
        return true;
    }

    @Override
    public boolean teaLogin(String email, String password) {
        User user = userMapper.selectByEmail(email);
        if (user == null){
            logger.info("account is not exists");
            return false;
        }
        if (MD5(password).equals(user.getPassword())){
            return true;
        }
        logger.info("incorrect password");
        return false;
    }

    @Override
    public boolean teaRegister(String email, String name, String password) {
        User user = new User();
        user.setEmail(email);
        user.setPassword(password);
        user.setName(name);
        user.setRoot(TEACHER);
        int flag;
        flag = userMapper.insertSelective(user);
        if(flag == -1){
            logger.info("insert error, transaction rollback");
            return false;
        }
        return true;
    }
    @Override
    public boolean editPassword(int id, String oldPw, String newPw){
        User user = userMapper.selectByPrimaryKey(id);
        logger.info(MD5(oldPw));
        logger.info(user.getPassword());
        if (MD5(oldPw).equals(user.getPassword())) {
            user.setPassword(MD5(newPw));
            int flag = userMapper.updateByPrimaryKey(user);
            if (flag > 0) {
                logger.info("update success");
                return true;
            }
        }
        return false;
    }

    @Override
    public User selectByEmail(String email) {
        return userMapper.selectByEmail(email);
    }

    @Override
    public User selectByName(String name) {
        return userMapper.selectByName(name);
    }
}
