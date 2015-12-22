package org.learncommunity.service;

import org.learncommunity.entity.User;

/**
 * Created by LJT on 2015/12/10.
 */
public interface UserService {
    public int deleteByPrimaryKey(Integer id);

    public int insert(User record);

    public int insertSelective(User record);

    public User selectByPrimaryKey(Integer id);

    public int updateByPrimaryKeySelective(User record);

    public int updateByPrimaryKey(User record);

    /**
     * Determine whether the student exists
     * @param email input email
     * @param password input password
     * @return if is, return true
     */
    public boolean stuLogin(String email, String password);

    /**
     * Determine whether the student exists
     * @param email input email
     * @param name input name
     * @param password input password
     * @return if not,insert student to database and return true
     */
    public boolean stuRegister(String email, String name, String password);

    /**
     * Determine whether the teacher exists
     * @param email input email
     * @param password input password
     * @return if is, return true
     */
    public boolean teaLogin(String email, String password);

    /**
     * Determine whether the teacher exists
     * @param email input email
     * @param name  input name
     * @param password input password
     * @return if not,insert teacher to database and return true
     */
    public boolean teaRegister(String email, String name, String password);

    /**
     * set new password
     * @param id user pk
     * @param oldPw old password
     * @param newPw new password
     * @return
     */
    public boolean editPassword(int id,String oldPw, String newPw);
    /**
     * get user entity by email
     * @param email input email
     * @return entity obj
     */
    public User selectByEmail(String email);

    /**
     * get user entity by name
     * @param name input email
     * @return entity obj
     */
    public User selectByName(String name);

}
