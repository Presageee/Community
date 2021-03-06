<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/11
  Time: 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap.min.css" />">
    <script src="<c:url value="/js/jquery.min.js"/>" type="text/javascript"></script>
    <script type="text/javascript" src="<c:url value="/js/bootstrap.min.js" />"></script>
    <script type='text/javascript' src="<c:url value="/js/pdfobject.js"/>"></script>
    <script type='text/javascript'>
        window.onload = function load(){
            var pdfId = "${pdfId}";
            jQuery.ajax({
                url: "${ctx}/api/EBook/PDFs/" + pdfId,
                type: "GET",
                success: function (data) {
                    if (data){
                        //var json = jQuery.parseJSON(data);
                        $('#downloadUrl').attr("value", data.url);
                        var myPDF = new PDFObject({
                            url: "${ctx}/" + data.url,
                            pdfOpenParams:{
                                navpanes: 1,
                                view: "FitV",
                                pagemode: "thumbs"
                            }
                        }).embed("pdf");
                    } else {
                        alert("系统繁忙，请重试");
                    }
                }
            });
        }
    </script>
    <style type="text/css">
        .container{min-height:89%;}
        .body{padding-bottom:50px;}
        .footer{height:50px;position:fixed;bottom:0px;left:0px;}
    </style>
    <title>PDFReader</title>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${ctx}/index.jsp">CheQi</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="${ctx}/index.jsp">主页<span class="sr-only">(current)</span></a></li>
                <li><a href="${ctx}/api/EBook/">电子书</a></li>
                <li><a href="${ctx}/api/MediaSkip.do">视频</a></li>
                <li><a href="${ctx}/api/topic">社区</a></li>
                <li><a href="${ctx}/api/about.do">关于</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${isLogin == 'hello'}">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">${user.name}<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/api/homeSkip.do">个人中心</a></li>
                                <li><a href="${ctx}/api/homeEditSkip.do">修改资料</a></li>
                                <li><a href="${ctx}/api/homeEditPasswordSkip.do">修改密码</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${ctx}/api/logoutSkip.do">注销</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">登陆/注册<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/api/stuLoginSkip.do">学生登陆/注册</a></li>
                                <li><a href="${ctx}/api/teaLoginSkip.do">教师登陆/注册</a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div class="container" style="background: #eeeeee;">
    <div class="row" >

        <div class="col-md-12">
            <div class="col-md-4"></div>
            <div class="col-md-2">
                <br>
                <form action="download.do" method="post" id="downloadPDF">
                    <input type="hidden" name="downloadUrl" id="downloadUrl"/>
                    <button class="btn btn-default" onclick="download()">download</button>
                </form>
            </div>
            <div class="col-md-3">
                <br>
                <button class="btn btn-default" type="button" id="uploadPDF">我为社区出份力(我要上传)</button>
            </div>
            <div class="col-md-3"></div>
        </div>
        <div class="col-md-12">
            <div style="width:60%;height:1px; background:black;margin-left:auto; margin-right:auto;"></div>
            <br>
        </div>
        <div class="col-md-12" style="background: #eeeeee;">
            <div id="pdf" style="height:84%; width:80%; margin-left:auto; margin-right:auto;"></div>
        </div>
    </div>
</div>
<footer style="background:#003443; color:gray">
    <div class="container1" style="text-align:center; padding: 10px 0;">
        <span>&copy;Copyright 2015 by Presage</span>
    </div>
</footer>
</body>
</html>
<script>
    $('#uploadPDF').click(function () {
        window.location.href = "${ctx}/PDFUploadSkip.do";
    });
    function download(){
        $('#downloadPDF').submit();
    }
</script>