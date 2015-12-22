<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/18
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head >
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        var mediaId = "${mediaId}";
        var url;
        var description;
        window.onload = function load(){
            jQuery.ajax({
                url: "${ctx}/loadMedia.do",
                data: {mediaId:mediaId},
                type: "POST",
                success: function (data){
                    if(data && data.success == "true"){
                        if (data.media){
                            console.log(data.media);
                            $('#uploader').append("上传者:" + "<a>" + data.media.user.name + "</a>");
                            $('#description').append("<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + data.media.description + " <p>");
                            $('#loadMediaPlayer').append("<video width='100%' height='70%' controls> <source src='" + data.media.url + "' type='video/mp4' id='source1'>" +
                                            " <source src='" + data.media.url + "' type='video/ogg' id='source2'>" +
                                    " <source src='" + data.media.url + "' type='video/webm' id='source3'>" +
                                    " <object data='" + data.media.url + "' width='100%' height='70%' id='source4'>" +
                                    " <embed src='" + data.media.url + "' width='100%' height='70%' id='source5'> </object> </video>");
                            url = data.media.url;
                            $('#downloadUrl').attr("value", data.media.url);
                        }
                    }
                }
            });
        }
    </script>
    <title>MediaPlayer</title>
    <style type="text/css">
        .container {
            min-height: 89%;
        }

        .body {
            padding-bottom: 50px;
        }

        .footer {
            height: 50px;
            position: fixed;
            bottom: 0px;
            left: 0px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
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
                <li><a href="${ctx}/index.jsp">主页<span class="sr-only">(current)</span></a></li>
                <li><a href="${ctx}/PDFSkip.do">电子书</a></li>
                <li><a href="${ctx}/MediaSkip.do">视频</a></li>
                <li><a href="${ctx}/topicSkip.do">社区</a></li>
                <li><a href="${ctx}/about.do">关于</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${isLogin == 'hello'}">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.name}<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/homeSkip.do">个人中心</a></li>
                                <li><a href="${ctx}/homeEditSkip.do">修改资料</a></li>
                                <li><a href="${ctx}/homeEditPasswordSkip.do">修改密码</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${ctx}/logoutSkip.do">注销</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">登陆/注册<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/stuLoginSkip.do">学生登陆/注册</a></li>
                                <li><a href="${ctx}/teaLoginSkip.do">教师登陆/注册</a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>
<div class="container" style="background: white; ">
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-3">
            <form action="download.do" method="post" id="downloadMedia">
                <input type="hidden" name="downloadUrl" id="downloadUrl"/>
                <button class="btn btn-default" onclick="download()">download</button>
            </form>
        </div>
        <div class="col-md-3">
            <button class="btn btn-default" id="uploadMedia">我为社区出份力(我要上传)</button>
        </div>
        <div class="col-md-12">
            <div class="page-header">
                <h3>Example page header
                    <small>Subtext for header</small>
                </h3>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12" id="loadMediaPlayer">
        </div>
    </div>
    <div class="row">
        <div class="col-md-9">
        </div>
        <div class="col-md-3" id="uploader">
        </div>
        <div class="col-md-9">
            <h3>简介：</h3>
        </div>
        <div class="col-md-12" id="description">
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
    $('#uploadMedia').click(function (){
        window.location.href = "${ctx}/mediaUploadSkip.do"
    })

    function download(){
        $('#downloadMedia').submit();
    }
</script>