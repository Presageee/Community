package org.learncommunity.controller;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;

/**
 * Created by LJT on 2015/12/19.
 */
@Controller
@RequestMapping("/")
public class DownloadController {

    private static Logger logger = Logger.getLogger(DownloadController.class);

/*    @RequestMapping("/download.do")
    public ResponseEntity<byte[]> download(HttpServletRequest request) throws Exception{
        String url = request.getParameter("downloadUrl");
        String tmp = url.substring(url.lastIndexOf('/') + 1, url.length());
        logger.info(tmp);
        url = request.getSession().getServletContext().getRealPath("\\") + url;
        logger.info("downfile location: " + url);
        File file = new File(url);
        logger.info(file.length());
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        httpHeaders.setContentDispositionFormData("attachment", URLEncoder.encode(tmp, "UTF-8"));
        logger.info(FileUtils.readFileToByteArray(file).length);
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), httpHeaders, HttpStatus.OK);
    }*/

    /**
     * download file(pdf or media)
     * @param request
     * @return ResponseEntity
     * @throws IOException
     */
    @RequestMapping("/download.do")
    public ResponseEntity<byte[]> download(@RequestParam("downloadUrl")String url, HttpServletRequest request) throws Exception{
        String tmp = url.substring(url.lastIndexOf('/') + 1, url.length());
        logger.info(tmp);
        url = request.getSession().getServletContext().getRealPath("\\") + url;
        logger.info("downfile location: " + url);
        File file = new File(url);
        InputStream is = new FileInputStream(file);
        byte[] a = new byte[is.available()];
        is.read(a);
        is.close();
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-Type", "application/octet-stream");//octet-stream is default all file
        httpHeaders.add("Content-Length", "" + a.length);
        httpHeaders.add("Content-Disposition", "attachment;filename=" +  URLEncoder.encode(tmp, "UTF-8"));//prevent chinese garbled
        ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(a, httpHeaders, HttpStatus.OK);
        return entity;
    }
}
