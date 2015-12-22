package org.learncommunity.controller;

import org.apache.log4j.Logger;
import org.learncommunity.dao.CourseMapper;
import org.learncommunity.dao.CourseTypeMapper;
import org.learncommunity.entity.Course;
import org.learncommunity.entity.CourseType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

/**
 * Created by LJT on 2015/12/19.
 */
@Controller
public class CourseTypeController {

    private static Logger logger = Logger.getLogger(CourseTypeController.class);

    @Resource
    private CourseTypeMapper courseTypeMapper;

    @RequestMapping("/getCourseType.do")
    @ResponseBody
    public Map<String, Object> getCourseType(){
        Map<String, Object> modelMap = new HashMap<>();
        List<CourseType> courses = courseTypeMapper.selectAll();
        if (courses != null) {
            modelMap.put("success", "true");
            modelMap.put("courses", courses);
        } else {
            modelMap.put("success", "false");
        }
        return modelMap;
    }
}
