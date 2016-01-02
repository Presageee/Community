package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.entity.Resources;
import org.learncommunity.entity.User;
import org.learncommunity.service.ResourcesService;
import org.learncommunity.service.TopicService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
@RestController
@RequestMapping("/EBook")
public class ResourcesRESTController {

    private static Logger logger = Logger.getLogger(ResourcesRESTController.class);

    @Resource
    private ResourcesService resourcesService;

    @Resource
    private TopicService topicService;

    /**
     * Asynchronous request PDFList by key and page index
     * @param
     * @return
     */
    @RequestMapping(value = "/PDFs/key/{key}/index/{index}", method = RequestMethod.GET, headers = "Accept=application/json",
            produces = {"application/json;charset=UTF-8"})
    public List<Resources> searchPDF(@PathVariable String key, @PathVariable("index")Integer index){
        //Map<String, Object> modelMap = new HashMap<>();
        List<Resources> resourcesList = null;
        if (key.equals("default") || key.equals("")) {
            resourcesList = resourcesService.selectByNameOrType("", "", index, 15);
        } else {
            resourcesList = resourcesService.selectByNameOrType(key, key, index, 15);
        }
        return resourcesList;
    }


    /**
     * Asynchronous request load PDF
     * @param
     * @return json of PDF
     */
    @RequestMapping(value = "/PDFs/{pdfId}", method = RequestMethod.GET, headers = "Accept=application/json",
            produces = {"application/json;charset=UTF-8"})
    public Resources loadPDF(@PathVariable("pdfId") Integer pdfId){
        Resources resources = resourcesService.selectByPrimaryKey(pdfId);
        return resources;
    }

    /**
     * Asynchronous upload pdf and insert in database
     * @param request
     * @param response
     * @return json of status
     */
    @RequestMapping(value = "/PDFs/", method = RequestMethod.POST, headers = "Accept=application/json", produces = {"application/json;charset=UTF-8"})
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
