package org.learncommunity.interceptor;

import org.apache.log4j.Logger;
import org.learncommunity.entity.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by LJT on 2015/12/22.
 */
public class LoginInterceptor implements HandlerInterceptor {

    private static Logger logger = Logger.getLogger(LoginInterceptor.class);

    /**
     * Intercept requests and determine whether user is exists
     * intercept is not intercept asynchronous request
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String url = httpServletRequest.getRequestURI().replace(httpServletRequest.getContextPath(), "");
        logger.info(url);
        HttpSession session = null;
/*        logger.info(httpServletRequest.getHeader("x-requested-with"));
        if (httpServletRequest.getHeader("x-requested-with") != null && httpServletRequest.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
            logger.info("is ajax request");
            session = httpServletRequest.getSession();
            User user = (User) session.getAttribute("user");
            if (user == null || user.equals("")) {
                logger.info("plz login");
                httpServletRequest.getRequestDispatcher("error.jsp").forward(httpServletRequest, httpServletResponse);
                return false;
            }
        } else {*/
            if (url.equals("/stuLogin.do") || url.equals("/stuRegister.do")
                    || url.equals("/teaLogin.do") || url.equals("/teaRegister.do")) {
                return true;
            } else {
                session = httpServletRequest.getSession();
                User user = (User)session.getAttribute("user");
                if (user == null || user.equals("")) {
                    httpServletResponse.sendRedirect("error.jsp");
                }
            }
/*        }*/
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
