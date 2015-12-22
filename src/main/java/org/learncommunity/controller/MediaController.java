package org.learncommunity.controller;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.learncommunity.entity.Media;
import org.learncommunity.entity.User;
import org.learncommunity.service.MediaService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/19.
 */
@Controller
@RequestMapping("/")
public class MediaController {

    private static Logger logger = Logger.getLogger(MediaController.class);

    @Resource
    private MediaService mediaService;

    /**
     * Asynchronous request MediaList by key and page index
     * @param request
     * @return json of MediaList
     */
    @RequestMapping("/searchMedia.do")
    @ResponseBody
    public Map<String, Object> searchMedia(@RequestParam("key")String key, @RequestParam("index")Integer index){
        Map<String, Object> modelMap = new HashMap<>();
        logger.info(key + index);
        List<Media> medias = mediaService.selectByNameOrType(key, key, index, 15);
        if (medias != null){
            modelMap.put("success", "true");
            modelMap.put("medias", medias);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * redirect MediaPlayer
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/RedirectMediaPlayer.do")
    public ModelAndView RedirectMediaPlayer(HttpServletRequest request, Model model, @RequestParam("mediaId") Integer id) throws IOException{
        ModelAndView mv = new ModelAndView();
        model.addAttribute("mediaId", id);
        mv.setViewName("/Media/mediaPages");
        return mv;
    }

    /**
     * Asynchronous request load Media
     * @param request
     * @return json of Media
     */
    @RequestMapping("/loadMedia.do")
    @ResponseBody
    public Map<String, Object> loadMedia(@RequestParam("mediaId") Integer id){
        Map<String, Object> modelMap = new HashMap<>();
        Media media = mediaService.selectMediaJoinUserByPK(id);
        if (media != null){
            modelMap.put("success", "true");
            modelMap.put("media", media);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * skip to media.jsp and set key
     * @param request
     * @return
     */
    @RequestMapping("/searchMediaByKey.do")
    public ModelAndView searchMediaByKey(HttpServletRequest request, @RequestParam("search") String key){
        request.getSession().removeAttribute("searchMediaKey");
        request.getSession().setAttribute("searchMediaKey",key);
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/Media/media");
        return mv;
    }

    /**
     * Asynchronous upload media
     * @param request
     * @return json of status
     */
    @RequestMapping("/mediaUpload.do")
    @ResponseBody
    public Map<String, Object> mediaUpload(HttpServletRequest request, @RequestParam("courseType") String type){
        boolean transferSuccess = true;
        User user = null;
        String path;
        int flag = -1;
        Map<String, Object> modelMap = new HashMap<>();
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        MultipartFile multipartFile = multipartHttpServletRequest.getFile("inputFile");
        try{
            user = (User)request.getSession().getAttribute("user");
            path = request.getSession().getServletContext().getRealPath("/") + "media/" + multipartFile.getOriginalFilename();
            try {
                multipartFile.transferTo(new File(path));
            } catch (IOException e){
                e.printStackTrace();
                transferSuccess = false;
            }
        } catch (NullPointerException e){
            e.printStackTrace();
            logger.info("user is null");
        }
        if (transferSuccess){
            Media media = new Media();
            String tmp = multipartFile.getOriginalFilename();
            media.setName(tmp.substring(0, tmp.length() - 4));
            media.setType(type);
            media.setUploaderid(user.getId());
            media.setUrl("media/" + tmp);
            media.setRoot(user.getRoot());
            media.setDescription("no description");
            media.setPrice(123.0);
            media.setTime(new Date(System.currentTimeMillis()));
            flag = mediaService.insertSelective(media);
            if (flag > 0){
                modelMap.put("success", "true");
            } else {
                modelMap.put("success", "false");
            }
        }
        return modelMap;
    }
}
