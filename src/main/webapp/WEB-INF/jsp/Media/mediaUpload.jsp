<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/19
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/ajaxfileupload.js"></script>
    <style type="text/css">
        .container{min-height:89%;}
        .body{padding-bottom:50px;}
        .footer{height:50px;position:fixed;bottom:0px;left:0px;}
    </style>
    <title>上传视频</title>
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
<div class="container" >
    <div class="row" >
        <div class="col-md-12">
            <div class="jumbotron" style="background:white">
                <h1>上传视频</h1>
                <p>共享学习资源，促进大家共同成长</p>
            </div>
        </div>
        <div class="col-md-5"></div>
        <div class="col-md-4">
            <form class="form-horizontal" enctype="multipart/form-data">
                <div class="form-group">

                    <label for="inputFileButton" class="col-sm-2 control-label">File:</label>
                    &nbsp
                    &nbsp
                    <input type="button" id="inputFileButton" class="btn btn-default" value="请选择文件"
                           onclick="inputFile.click()"/>
                    <input type="file" id="inputFile" name="inputFile" class="col-sm-3 control-label"
                           onchange="uploadMedia()"
                           style="position:absolute; filter:alpha(opacity=0);opacity:0;width:30px;" size="1">
                    <select id="courseType"></select>
                </div>
            </form>
        </div>
        <div class="col-md-2"></div>
        <div class="col-md-12" style="text-align:center;display:none;" id="progress1">
            <h2>正在上传</h2>
            <div class="progress" >
                <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100% ">
                    <span class="sr-only">45% Complete</span>

                </div>
            </div>
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
    function uploadMedia(){
        var path = $('#inputFile').val();
        var fileName = path.substring(path.lastIndexOf('\\') + 1);
        console.log(fileName);
        //$('#picture').attr("src", "${ctx}/fileUpload/temp/" + fileName);
        var p = document.getElementById("progress1");
        p.style.display = "block";
        var select = $('#courseType').val();
        console.log(select);
        $.ajaxFileUpload({
            url: "${ctx}/mediaUpload.do",
            secureuri: false,
            fileElementId: "inputFile",
            data: {courseType: select},
            type: 'POST',
            success: function (data, status) {
                var str = $(data).find("body").text();
                var json = $.parseJSON(str);
                if (json && json.success == "true") {
                    p.style.display = "none";
                    alert("上传成功!");
                    window.location.href = "${ctx}/MediaSkip.do";
                } else {
                    p.style.display = "none";
                    alert("文件过大或网络原因上传失败!");
                }
            },
            error: function (){
                p.style.display = "none";
                alert("文件过大或网络原因上传失败!");
            }
        });
    }

    window.onload = function load(){
        jQuery.ajax({
            url: "${ctx}/getCourseType.do",
            success: function (data){
                if (data && data.success == "true"){
                    console.log(data.courses);
                    var j;
                    for(j = 0; j < data.courses.length; j++){
                        var o = document.createElement("option");
                        o.value = data.courses[j].name;
                        o.text = data.courses[j].name;
                        $('#courseType')[0].options.add(o);
                    }
                }
            }
        })
    }
</script>
