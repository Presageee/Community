package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.Media;
import org.learncommunity.entity.Reply;
import org.learncommunity.entity.Topic;
import org.learncommunity.entity.User;
import org.learncommunity.service.ReplyService;
import org.learncommunity.service.TopicService;
import org.learncommunity.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/20.
 */
@Controller
@RequestMapping("/")
public class TopicController {

    private static Logger logger = Logger.getLogger(TopicController.class);

    @Resource
    private TopicService topicService;

    @Resource
    private ReplyService replyService;

    @Resource
    private UserService userService;

    /**
     * get topic by search key
     * @param key
     * @param index
     * @return
     */
    @RequestMapping("/searchTopic.do")
    @ResponseBody
    public Map<String, Object> searchTopic(@RequestParam("searchTopicKey")String key, @RequestParam("index") int index){
        Map<String, Object> modelMap = new HashMap<>();
        List<Topic> topics = topicService.selectByTitleOrType(key, key, index, 15);
        if (topics != null){
            modelMap.put("success", "true");
            modelMap.put("topics", topics);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

/*    @RequestMapping("/getTopicPages.do")
    public ModelAndView getTopicPages(Model model, @RequestParam("topicId") int id){
        model.addAttribute("topicId", id);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Topic/topicPages");
        return mv;
    }*/

    /**
     * Asynchronous request load Media
     * @param
     * @return json of Media
     */
    @RequestMapping("/loadReply.do")
    @ResponseBody
    public Map<String, Object> loadReply(@RequestParam("topicId") Integer id){
        Map<String, Object> modelMap = new HashMap<>();
        //Media media = topicService.selectMediaJoinUserByPK(id);
        Topic topic = new Topic();
        if (topic != null){
            modelMap.put("success", "true");
            modelMap.put("topic", topic);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * skip to topic.jsp and set key
     * @param request
     * @return
     */
    @RequestMapping("/searchTopicByKey.do")
    public ModelAndView searchTopicByKey(HttpServletRequest request, @RequestParam("search") String key){
        request.getSession().removeAttribute("searchTopicKey");
        request.getSession().setAttribute("searchTopicKey",key);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Topic/topic");
        return mv;
    }

    /**
     * create a new topic
     * @param content
     * @param type
     * @param title
     * @param request
     * @return
     */
    @RequestMapping("/createTopic.do")
    @ResponseBody
    public Map<String, Object> createTopic(@RequestParam("content")String content, @RequestParam("courseType") String type,
                                    @RequestParam("title") String title, HttpServletRequest request){
        Map<String, Object> modelMap = new HashMap<>();
        Topic topic = new Topic();
        User user = null;
        logger.info(content + " t : " + type + " title: " + title);
        boolean isNotNull = true;
        int insertTopicFlag = -1;
        int updateUserFlag = -1;
        try {
            user = (User)request.getSession().getAttribute("user");
            logger.info(user.getName());
        } catch (NullPointerException e){
            e.printStackTrace();
            isNotNull = false;
            logger.info("user is null");
        }
        if (isNotNull) {
            logger.info(user.getId());
            topic.setContent(content);
            topic.setTitle(title);
            topic.setType(type);
            topic.setTime(new Date(System.currentTimeMillis()));
            topic.setLastreplytime(new Date(System.currentTimeMillis()));
            topic.setReplycnt(0);
            topic.setUserid(user.getId());
            insertTopicFlag = topicService.insertSelective(topic);
            user.setTopiccnt(user.getTopiccnt() + 1);
            updateUserFlag = userService.updateByPrimaryKeySelective(user);
        }
        logger.info(insertTopicFlag);
        if (insertTopicFlag > 0 && updateUserFlag > 0) {
            modelMap.put("success", "true");
            request.getSession().removeAttribute("user");
            request.getSession().setAttribute("user", user);
            logger.info("insert success");
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * get topicPage by topic id and skip
     * @param topicId
     * @param model
     * @return
     */
    @RequestMapping("/topicPages.do")
    public ModelAndView topicPages(@RequestParam("topicId") int topicId, Model model){
        ModelAndView mv = new ModelAndView();
        Topic topic = topicService.selectByPrimaryKey(topicId);
        if (topic != null) {
            model.addAttribute("topic", topic);
        }
        mv.setViewName("/Topic/topicPages");
        return mv;
    }
}
