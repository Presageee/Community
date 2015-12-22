package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.dao.UserMapper;
import org.learncommunity.entity.Topic;
import org.learncommunity.entity.User;
import org.learncommunity.service.TopicService;
import org.learncommunity.service.UserService;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.annotation.Resources;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/4.
 */
@Controller
@RequestMapping("/")
public class LoginController {

    private static Logger logger = Logger.getLogger(LoginController.class);
    @Resource
    private UserService userService;

    /**
     * Asynchronous request Login
     * @param request client request
     * @param response
     * @return json of status
     */
    @RequestMapping("/stuLogin.do")
    @ResponseBody
    public Map<String, Object> stuLogin(HttpServletRequest request, @RequestParam("email")String email, @RequestParam("password")String password){
        logger.info(email + " " + password);
        boolean flag = userService.stuLogin(email, password);//determine whether the student exists
        Map<String, Object> modelMap = new HashMap<>();
        if (flag){
            logger.info(email + "login success");
            modelMap.put("success", "true");
            User user = userService.selectByEmail(email);
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("isLogin", "hello");
        }else {
            logger.info("email or password error");
            modelMap.put("success", "false");
        }
        logger.info(modelMap.toString());
        return modelMap;
    }

    /**
     * Asynchronous request register
     * @param request client request
     * @param response
     * @return json of status
     */
    @RequestMapping("/stuRegister.do")
    @ResponseBody
    public Map<String, Object> stuRegister(@RequestParam("email")String email,
                                           @RequestParam("password")String password, @RequestParam("name")String name){
        logger.info(email + " " + password);
        boolean flag = userService.stuRegister(email, name, password);//determine whether student exists
        Map<String, Object> modelMap = new HashMap<>();
        if (flag){
            logger.info("register success");
            modelMap.put("success", "true");
        }else {
            modelMap.put("success", "false");
            logger.info("register fail");
        }
        return modelMap;
    }

    /**
     * Asynchronous request Login
     * @param request client request
     * @param response
     * @return json of status
     */
    @RequestMapping("/teaLogin.do")
    @ResponseBody
    public Map<String, Object> teaLogin(HttpServletRequest request, @RequestParam("email")String email, @RequestParam("password")String password){
        logger.info(email + " " + password);
        boolean flag = userService.teaLogin(email, password);
        Map<String, Object> modelMap = new HashMap<>();
        if (flag){
            logger.info("login success");
            modelMap.put("success", "true");
            User user = userService.selectByEmail(email);
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("isLogin", "hello");
        }else {
            logger.info("login fail");
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request register
     * @param request client request
     * @param response
     * @return json of status
     */
    @RequestMapping("/teaRegister.do")
    @ResponseBody
    public Map<String, Object> teaRegister(@RequestParam("email")String email,
                                           @RequestParam("password")String password, @RequestParam("name")String name){
        logger.info(email + " " + password);
        boolean flag = userService.teaRegister(email, name, password);
        Map<String, Object> modelMap = new HashMap<>();
        if (flag){
            logger.info("register success");
            modelMap.put("success", "true");
        }else {
            logger.info("register fail");
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Email determine whether there by Asynchronous request
     * @param request client request
     * @return json of status
     */
    @RequestMapping("/emailIsExists.do")
    @ResponseBody
    public Map<String, Object> emailIsExists(@RequestParam("email")String email){
        logger.info(email);
        User user = null;
        user = userService.selectByEmail(email);
        Map<String, Object> modelMap = new HashMap<>();
        if (user == null) {
            logger.info("email can be used");
            modelMap.put("success", "true");
        } else {
            logger.info("email is exists");
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Name determine whether there by Asynchronous request
     * @param request client request
     * @return json of status
     */
    @RequestMapping("/nameIsExists.do")
    @ResponseBody
    public Map<String, Object> nameIsExists(@RequestParam("name")String name){
        logger.info(name);
        User user = null;
        user = userService.selectByName(name);
        Map<String, Object> modelMap = new HashMap<>();
        if (user == null) {
            logger.info("name can be used");
            modelMap.put("success", "true");
        } else {
            logger.info("name is exists");
            modelMap.put("success", "false");
        }
        return modelMap;
    }
}
