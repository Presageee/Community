package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.*;
import org.learncommunity.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/15.
 */

@Controller
@RequestMapping("/")
public class HomeController {

    private static Logger logger = Logger.getLogger(HomeController.class);

    @Resource
    private UserService userService;

    @Resource
    private MediaService mediaService;

    @Resource
    private ResourcesService resourcesService;

    @Resource
    private ReplyService replyService;

    @Resource
    private TopicService topicService;

    /**
     * Asynchronous request edit user data
     *
     * @param request client request
     * @return json of status
     */
    @RequestMapping(value = "/edit.do")
    @ResponseBody
    public Map<String, Object> edit(@RequestParam("id") Integer id, @RequestParam("imgSrc") String imgSrc, HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<>();
        logger.info(request.getSession().toString());
        logger.info(id);
        User user = userService.selectByPrimaryKey(id);
        if (imgSrc != null && !imgSrc.equals("")) {
            user.setPhotourl(imgSrc);
        }
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));
        user.setGoodat(request.getParameter("goodAt"));
        user.setEducationalbackground(request.getParameter("educational"));
        user.setDescription(request.getParameter("profile"));
        int flag = userService.updateByPrimaryKeySelective(user);
        if (flag > 0) {
            modelMap.put("success", "true");
            request.removeAttribute("user");
            request.getSession().setAttribute("user", user);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request
     *
     * @param request client request
     * @return json of status
     */
    @RequestMapping(value = "/editPassword.do")
    @ResponseBody
    public Map<String, Object> editPassword(@RequestParam("oldPassword") String oldPw, @RequestParam("newPassword") String newPw, HttpServletRequest request) {
        Map<String, Object> modelMap = new HashMap<>();
        int id = Integer.parseInt(request.getParameter("id"));
        boolean flag = userService.editPassword(id, oldPw, newPw);
        logger.info(oldPw);
        if (flag) {
            modelMap.put("success", "true");
            logger.info("set new password successful");
        } else {
            modelMap.put("success", "false");
            logger.info("old Password error");
        }
        return modelMap;
    }

    /**
     * Asynchronous request upload image
     *
     * @param response server response
     * @param request  client request
     * @return json of status
     * @throws IOException
     */
    @RequestMapping(value = "/imageUpload.do")
    @ResponseBody
    public Map<String, Object> imageUpload(HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        Map<String, Object> modelMap = new HashMap<>();
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        MultipartFile file = multipartHttpServletRequest.getFile("inputFile");
        logger.info(file);
        if (!file.isEmpty()) {
            String filePath = request.getSession().getServletContext().getRealPath("/") + "image/" + file.getOriginalFilename();
            file.transferTo(new File(filePath));
            modelMap.put("success", "true");
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request MediaList
     *
     * @param request client request
     * @return json of list and status
     */
    @RequestMapping(value = "/moreMedia.do")
    @ResponseBody
    public Map<String, Object> moreMedia(@RequestParam("id") Integer id, @RequestParam("index") Integer index) {
        Map<String, Object> modelMap = new HashMap<>();

        List<Media> media = mediaService.selectByUserId(id, index, 16);
        System.out.println("time is " + media.get(1).getTime());
        if (media != null) {
            modelMap.put("success", "true");
            modelMap.put("media", media);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request more PDFList
     *
     * @param request client request
     * @return json of list and status
     */
    @RequestMapping(value = "/morePDF.do")
    @ResponseBody
    public Map<String, Object> morePDF(@RequestParam("id") Integer id, @RequestParam("index") Integer index) {
        Map<String, Object> modelMap = new HashMap<>();
        List<Resources> resources = resourcesService.selectByUserId(id, index, 16);
        if (resources != null) {
            modelMap.put("success", "true");
            modelMap.put("pdf", resources);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request more reply list
     *
     *
     */
    @RequestMapping("/moreReply.do")
    @ResponseBody
    public Map<String, Object> moreReply(@RequestParam("id")int id, @RequestParam("index") int index) {
        Map<String, Object> modelMap = new HashMap<>();
        List<Reply> replies = replyService.selectByUserId(id, index, 16);
        if (replies != null) {
            modelMap.put("success", "true");
            modelMap.put("replies", replies);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * Asynchronous request more topic list
     * @param id
     * @param index
     * @return
     */
    @RequestMapping("/moreTopic.do")
    @ResponseBody
    public Map<String, Object> moreTopic(@RequestParam("id")int id, @RequestParam("index") int index) {
        Map<String, Object> modelMap = new HashMap<>();
        List<Topic> topics = topicService.selectByUserId(id, index, 16);
        if (topics != null) {
            modelMap.put("success", "true");
            modelMap.put("topics", topics);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }
}