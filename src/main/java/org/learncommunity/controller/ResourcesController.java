package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by LJT on 2016/1/2.
 */
@Controller
@RequestMapping("/EBook")
public class ResourcesController {
    private static Logger logger = Logger.getLogger(ResourcesController.class);

    /**
     * skip to resources.jsp and set key
     * @param request
     * @return
     */
    @RequestMapping(value = "/PDFs/", method = RequestMethod.GET)
    public ModelAndView searchPDFByKey(HttpServletRequest request, @RequestParam("search")String key){
        request.getSession().removeAttribute("searchKey");
        request.getSession().setAttribute("searchKey", key);
        logger.info(key);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/PDFResources/resources");
        return modelAndView;
    }
}
