package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.*;
import org.learncommunity.service.MediaService;
import org.learncommunity.service.ReplyService;
import org.learncommunity.service.ResourcesService;
import org.learncommunity.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/8.
 */
@Controller
@RequestMapping("/")
public class SkipController {
    private static Logger logger = Logger.getLogger(SkipController.class);

    @Autowired
    private TopicService topicService;

    @Resource
    private ResourcesService resourcesService;

    @Resource
    private ReplyService replyService;

    @Resource
    private MediaService mediaService;

    /**
     * The following method is skip to ?.jsp
     */


    @RequestMapping(value = "/stuLoginSkip.do", method = RequestMethod.GET)
    public ModelAndView stuLoginSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Login/stuLogin");
        return mv;
    }

    @RequestMapping(value = "/stuRegisterSkip.do", method = RequestMethod.GET)
    public ModelAndView stuRegisterSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Login/stuRegister");
        return mv;
    }

    @RequestMapping(value = "/teaLoginSkip.do", method = RequestMethod.GET)
    public ModelAndView teaLoginSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Login/teaLogin");
        return mv;
    }

    @RequestMapping(value = "/homeSkip.do", method = RequestMethod.GET)
    public ModelAndView homeSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/home");
        return mv;
    }

    @RequestMapping(value = "/homeEditSkip.do", method = RequestMethod.GET)
    public ModelAndView homeEditSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homeEdit");
        return mv;
    }

    @RequestMapping(value = "/homeEditPasswordSkip.do", method = RequestMethod.GET)
    public ModelAndView homeEditPasswordSkip() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homeEditPassword");
        return mv;
    }

    @RequestMapping(value = "/homeMediaSkip.do", method = RequestMethod.GET)
    public ModelAndView homeMediaSkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homeMedia");
        return mv;
    }

    @RequestMapping(value = "/homePDFSkip.do", method = RequestMethod.GET)
    public ModelAndView homePDFSkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homePDF");
        return mv;
    }

    @RequestMapping(value = "/homeReplySkip.do", method = RequestMethod.GET)
    public ModelAndView homeReplySkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homeReply");
        return mv;
    }

    @RequestMapping(value = "/homeTopicSkip.do", method = RequestMethod.GET)
    public ModelAndView homeTopicSkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Home/homeTopic");
        return mv;
    }

    @RequestMapping(value = "/logoutSkip.do", method = RequestMethod.GET)
    @ResponseBody
    public void logoutSkip(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.getSession().removeAttribute("user");
        request.getSession().removeAttribute("isLogin");
        String ctx = request.getContextPath();
        logger.info(ctx);
        response.sendRedirect(ctx + "/index.jsp");
    }

    @RequestMapping(value = "/EBook/", method = RequestMethod.GET)
    public ModelAndView PDFSkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        //request.getSession().setAttribute("");
        if (request.getSession().getAttribute("searchKey") != null) {
            request.getSession().removeAttribute("searchKey");
            request.getSession().setAttribute("searchKey", "default");
        } else {
            request.getSession().setAttribute("searchKey", "default");
        }
        logger.info(request.getSession().getAttribute("searchKey"));
        mv.setViewName("/PDFResources/resources");
        return mv;
    }

    /**
     * redirectPDFReader
     * @param request
     * @param
     * @throws IOException
     */
    @RequestMapping(value = "EBook/PDFReader/{pdfId}")
    public ModelAndView RedirectPDFReader(HttpServletRequest request, Model model, @PathVariable Integer pdfId) throws IOException{
        ModelAndView mv = new ModelAndView();
        model.addAttribute("pdfId", pdfId);
        logger.info("ididid   " + pdfId);
        mv.setViewName("/PDFResources/PDFPages");
        return mv;
    }

    @RequestMapping(value = "/MediaSkip.do")
    public ModelAndView MediaSkip(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        if (request.getSession().getAttribute("searchMediaKey") != null) {
            request.getSession().removeAttribute("searchMediaKey");
            request.getSession().setAttribute("searchMediaKey", "");
        } else {
            request.getSession().setAttribute("searchMediaKey", "");
        }
        mv.setViewName("/Media/media");
        return mv;
    }

    @RequestMapping(value = "/topic")
    public ModelAndView topicSkip(HttpServletRequest request){
        ModelAndView mv = new ModelAndView();
        if (request.getSession().getAttribute("searchTopicKey") != null) {
            request.getSession().removeAttribute("searchTopicKey");
            request.getSession().setAttribute("searchTopicKey", "");
        } else {
            request.getSession().setAttribute("searchTopicKey", "");
        }
        mv.setViewName("/Topic/topic");
        return mv;
    }

    @RequestMapping("EBook/PDFUploadSkip.do")
    public ModelAndView PDFUploadSkip() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/PDFResources/PDFUpload");
        return modelAndView;
    }

    @RequestMapping("/mediaUploadSkip.do")
    public ModelAndView mediaUploadSkip() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/Media/mediaUpload");
        return modelAndView;
    }

    @RequestMapping("/about.do")
    public void about(HttpServletResponse response) throws IOException{
        response.sendRedirect("about.jsp");
    }
}
