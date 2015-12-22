package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.Resources;
import org.learncommunity.entity.Topic;
import org.learncommunity.entity.User;
import org.learncommunity.service.ResourcesService;
import org.learncommunity.service.TopicService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LJT on 2015/12/11.
 */
@Controller
@RequestMapping("/")
public class ResourcesController {

    private static Logger logger = Logger.getLogger(ResourcesController.class);

    @Resource
    private ResourcesService resourcesService;

    @Resource
    private TopicService topicService;

    /**
     * Asynchronous request PDFList by key and page index
     * @param request
     * @return
     */
    @RequestMapping("/searchPDF.do")
    @ResponseBody
    public Map<String, Object> searchPDF(@RequestParam("key")String key, @RequestParam("index")Integer index){
        Map<String, Object> modelMap = new HashMap<>();
        List<Resources> resourcesList = resourcesService.selectByNameOrType(key, key, index, 15);
        if (resourcesList != null){
            modelMap.put("success", "true");
            modelMap.put("pdf", resourcesList);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * redirectPDFReader
     * @param request
     * @param
     * @throws IOException
     */
    @RequestMapping(value = "/RedirectPDFReader.do")
    public ModelAndView RedirectPDFReader(HttpServletRequest request, Model model, @RequestParam("pdfId")Integer id) throws IOException{
        ModelAndView mv = new ModelAndView();
        model.addAttribute("pdfId", id);
        logger.info("ididid   " + id);
        mv.setViewName("/PDFResources/PDFPages");
        return mv;
    }


    /**
     * Asynchronous request load PDF
     * @param
     * @return json of PDF
     */
    @RequestMapping("/loadPDF.do")
    @ResponseBody
    public Map<String, Object> loadPDF(@RequestParam("pdfId")Integer id){
        Map<String, Object> modelMap = new HashMap<>();
        Resources resources = resourcesService.selectByPrimaryKey(id);
        if (resources != null){
            modelMap.put("success", "true");
            modelMap.put("pdf", resources);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }

    /**
     * skip to resources.jsp and set key
     * @param request
     * @return
     */
    @RequestMapping("/searchPDFByKey.do")
    public ModelAndView searchPDFByKey(HttpServletRequest request, @RequestParam("search")String key){
        request.getSession().removeAttribute("searchKey");
        request.getSession().setAttribute("searchKey", key);
        logger.info(key);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/PDFResources/resources");
        return modelAndView;
    }

    /**
     * Asynchronous upload pdf and insert in database
     * @param request
     * @param response
     * @return json of status
     */
    @RequestMapping("/PDFUpload.do")
    @ResponseBody
    public Map<String, Object> PDFUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam("courseType")String type){
        User user = null;
        boolean transferSuccess = true;
        String path;
        int flag = -1;
        Map<String, Object> modelMap = new HashMap<>();
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        logger.info(type);
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        MultipartFile multipartFile = multipartHttpServletRequest.getFile("inputFile");
        logger.info(multipartFile);
        logger.info("uploading");
        try{
            user = (User)request.getSession().getAttribute("user");
            path = request.getSession().getServletContext().getRealPath("/") + "pdf/" + multipartFile.getOriginalFilename();
            try {
                multipartFile.transferTo(new File(path));
            } catch (IOException e){
                e.printStackTrace();
                transferSuccess = false;
            }
        }catch (NullPointerException e){
            e.printStackTrace();
            logger.info("user is null");
        }
        if (transferSuccess){
            String tmp = multipartFile.getOriginalFilename();
            Resources resources = new Resources();
            resources.setName(tmp.substring(0, tmp.length() - 4));
            resources.setRoot(user.getRoot());
            resources.setUploaderid(user.getId());
            resources.setTime(new Date(System.currentTimeMillis()));
            resources.setType(type);
            resources.setUrl("pdf/" + multipartFile.getOriginalFilename());
            resources.setDescription("no description");
            resources.setPrice(123.0);
            flag = resourcesService.insertSelective(resources);
            logger.info(flag);
        }
        if (flag > 0)
            modelMap.put("success", "true");
        else
            modelMap.put("success", "false");
        return modelMap;
    }
}
