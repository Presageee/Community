<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/9
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <title>扯旗学习社区</title>
</head>
<body onload="load()">
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
                <li><a href="${ctx}/PDFSkip.do">电子书</a></li>
                <li><a href="${ctx}/MediaSkip.do">视频</a></li>
                <li><a href="${ctx}/topicSkip.do">社区</a></li>
                <li><a href="${ctx}/about.do">关于</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${isLogin == 'hello'}">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">${user.name}<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/homeSkip.do">个人中心</a></li>
                                <li><a href="${ctx}/homeEditSkip.do">修改资料</a></li>
                                <li><a href="${ctx}/homeEditPasswordSkip.do">修改密码</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${ctx}/logoutSkip.do">注销</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false">登陆/注册<span class="caret"></span></a>
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
<div class="container">
    <div class="jumbotron">
        <h1>Hello, world!</h1>

        <p>你好，世界！加入我们，共创良好学习氛围。</p>

        <p><a class="btn btn-primary btn-lg" href="${ctx}/topicSkip.do" role="button">进入社区</a></p>
    </div>
    <div class="list-group" id="list">
        <a href="#" class="list-group-item active">
            PDF资源
        </a>
        <a href="${ctx}/searchPDFByKey.do?search=Java" class="list-group-item">Java</a>
        <a href="${ctx}/searchPDFByKey.do?search=Javascript" class="list-group-item">Javascript</a>
        <a href="${ctx}/searchPDFByKey.do?search=C++" class="list-group-item">C++</a>
        <a href="${ctx}/searchPDFByKey.do?search=HTML/CSS3" class="list-group-item">HTML5/CSS3</a>
        <a href="${ctx}/searchPDFByKey.do?search=Node.js" class="list-group-item">Node.js</a>
    </div>
    <div class="list-group">
        <a href="#" class="list-group-item active">
            视频教学
        </a>
        <a href="${ctx}/searchMediaByKey.do?search=PHP7" class="list-group-item">PHP7</a>
        <a href="${ctx}/searchMediaByKey.do?search=Android" class="list-group-item">Android</a>
        <a href="${ctx}/searchMediaByKey.do?search=Algorithms" class="list-group-item">Algorithms</a>
        <a href="${ctx}/searchMediaByKey.do?search=C#" class="list-group-item">C#</a>
        <a href="${ctx}/searchMediaByKey.do?search=Ruby" class="list-group-item">Ruby</a>
    </div>
    <div class="list-group">
        <a href="#" class="list-group-item active">
            社区交流
        </a>
        <a href="#" id="a1" class="list-group-item">CentOS6.5</a>
        <a href="#" id="a2" class="list-group-item">How to build hellowrold</a>
        <a href="#" id="a3" class="list-group-item">人生苦短，我用python</a>
        <a href="#" id="a4" class="list-group-item">spring大法好</a>
        <a href="#" id="a5" class="list-group-item">ganganganmeizi</a>
    </div>
</div>
<footer style="background:#003443; color:gray">
    <div class="container" style="text-align:center; padding: 10px 0;">
        <span>&copy;Copyright 2015 by Presage</span>
    </div>
</footer>
</body>
</html>
<script>
    function load() {
        jQuery.ajax({
            url: "${ctx}/searchTopic.do",
            data: {searchTopicKey: "", index: 1},
            success: function (data) {
                if (data && data.success == "true") {
                    $('#a1').attr("href", "${ctx}/topicPages.do?topicId=" + data.topics[0].id);
                    $('#a2').attr("href", "${ctx}/topicPages.do?topicId=" + data.topics[1].id);
                    $('#a3').attr("href", "${ctx}/topicPages.do?topicId=" + data.topics[2].id);
                    $('#a4').attr("href", "${ctx}/topicPages.do?topicId=" + data.topics[3].id);
                    $('#a5').attr("href", "${ctx}/topicPages.do?topicId=" + data.topics[4].id);
                }
            }
        })
    }
</script>
