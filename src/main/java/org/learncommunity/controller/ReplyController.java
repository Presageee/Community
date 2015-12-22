package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.Reply;
import org.learncommunity.entity.Topic;
import org.learncommunity.entity.User;
import org.learncommunity.service.ReplyService;
import org.learncommunity.service.TopicService;
import org.learncommunity.service.UserService;
import org.springframework.jdbc.object.UpdatableSqlQuery;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/21.
 */
@Controller
public class ReplyController {

    private static Logger logger = Logger.getLogger(ReplyController.class);

    @Resource
    private ReplyService replyService;

    @Resource
    private TopicService topicService;

    @Resource
    private UserService userService;

    /**
     * loadReply by topic id and page index
     * @param id
     * @param index
     * @return json of replyList
     */
    @RequestMapping("/loadReply.do")
    @ResponseBody
    public Map<String, Object> loadReply(@RequestParam("topicId")int id, @RequestParam("index") int index){
        Map<String, Object> modelMap = new HashMap<>();
        List<Reply> replies = replyService.selectLimitByTopicId(id, index, 15);
        logger.info(replies.size());
        if (replies != null){
            modelMap.put("success", "true");
            modelMap.put("replies", replies);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * create a new reply
     * @param content
     * @param id
     * @param request
     * @return json of status
     */
    @RequestMapping("/createReply.do")
    @ResponseBody
    public Map<String, Object> createReply(@RequestParam("content")String content,
                                           @RequestParam("topicId")int id, HttpServletRequest request){
        Map<String, Object> modelMap = new HashMap<>();
        int insertReplyFlag = -1;
        int updateTopicFlag = -1;
        int updateUserFlag = -1;
        boolean isNotNull = true;
        User user = null;
        try {
            user = (User) request.getSession().getAttribute("user");
            logger.info(user);
        } catch (NullPointerException e) {
            e.printStackTrace();
            isNotNull = false;
            logger.info("user is null");
        }
        logger.info(isNotNull);
        if (user.equals("")){
            isNotNull = false;
        }
        if (isNotNull) {
            Topic topic = topicService.selectByPrimaryKey(id);
            Reply reply = new Reply();
            Date tmpDate = new Date(System.currentTimeMillis());
            reply.setContent(content);
            reply.setTopicid(id);
            reply.setRoot(user.getRoot());
            reply.setTime(tmpDate);
            reply.setUserid(user.getId());
            insertReplyFlag = replyService.insertSelective(reply);
            topic.setId(id);
            topic.setLastreplytime(tmpDate);
            topic.setReplycnt(topic.getReplycnt() + 1);
            updateTopicFlag = topicService.updateByPrimaryKey(topic);
            user.setReplycnt(user.getReplycnt() + 1);
            updateUserFlag = userService.updateByPrimaryKeySelective(user);
        }
        if (insertReplyFlag > 0 && updateTopicFlag > 0 && updateUserFlag > 0) {
            modelMap.put("success", "true");
            request.getSession().removeAttribute("user");
            request.getSession().setAttribute("user", user);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }
}
