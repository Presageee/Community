<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/21
  Time: 17:23
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
    <title>${topic.title}</title>
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
    <div class="row">
        <div class="col-md-12">
            <div class="page-header">
                <h1>${topic.title}
                    <small>发起者：${topic.user.name}</small>
                    <small>发起时间：${topic.time}</small>
                </h1>
                <input type="hidden" id="topicId"/>
            </div>
        </div>
        <div class="col-md-12">
            <div style="min-height: 15%; min-width:100%">
                <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${topic.content}</p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12" id="replyListView">

            </div>
        </div>
        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-2" id="buttonDiv">
                <button class="btn btn-default" type="button" id="moreReply">查看更多</button>
            </div>
            <div class="col-md-5"></div>
            <div class="col-md-12">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="form-group">
                            <div class="col-md-1"></div>
                            <div class="col-md-11">
                                <h3>发表新回复</h3>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <!-- 加载编辑器的容器 -->
                                <script id="replyContent" name="content" type="text/plain">
                                </script>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-10"></div>
                            <div class="col-md-1">
                                <button class="btn btn-default" type="button" id="createReply">发表</button>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                </form>
                <!-- 配置文件 -->
                <script type="text/javascript" src="ueditor1_4_3/ueditor.config.js"></script>
                <!-- 编辑器源码文件 -->
                <script type="text/javascript" src="ueditor1_4_3/ueditor.all.js"></script>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">
                    var ue = UE.getEditor('replyContent');
                </script>
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
    var x = 1;
    var y = 2;
    var topicId = "${topic.id}";
    function load() {
        $('#topicId').attr("value", topicId);
        jQuery.ajax({
            url: "${ctx}/loadReply.do",
            data: {topicId: topicId, index: x},
            success: function (data) {
                if (data && data.success == "true") {
                    console.log(data);
                    var i;
                    var addReply = "";
                    for (i = 0; i < data.replies.length; i++) {
                        addReply += "<br>";
                        addReply += "   <div style='width:80%;height:1px; background:black;margin-left:auto; margin-right:auto;'></div>";
                        addReply += "<br>";
                        addReply += "<div class='media'>";
                        addReply += "<div class='media-left media-middle'>";
                        addReply += "<a href='#'>";
                        addReply += "<img class='media-object' src='" + data.replies[i].user.photourl + "' alt='" + data.replies[i].user.name + "' style='width:100px;height:100px;'>";
                        addReply += "</a>";
                        addReply += "</div>";
                        addReply += "<div class='media-body'>";
                        addReply += "<h4 class='media-heading'>" + data.replies[i].user.name + "<small>&nbsp;&nbsp;时间: " + data.replies[i].time + "</small></h4>";
                        addReply += "<span>" + data.replies[i].content + "</span></div></div>";
                    }
                    $('#replyListView').append(addReply);
                    if (i == 0 || i < 15) {
                        var _hidden = document.getElementById("moreReply");
                        _hidden.style.display = "none";
                        $('#buttonDiv').append("<br><span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    } else {
                        var _hidden2 = document.getElementById("moreReply");
                        _hidden2.style.display = "inline-block";
                    }
                    x += 1;
                } else {
                    //console.log(data);
                }
            }
        });
    }
        $('#moreReply').click(function () {
            jQuery.ajax({
                url: "${ctx}/loadReply.do",
                data: {topicId: topicId, index: x},
                success: function (data) {
                    if (data && data.success == "true") {
                        console.log(data);
                        var j;
                        var addReply = "";
                        for (j = 0; j < data.replies.length; j++) {
                            addReply += "<br>";
                            addReply += "   <div style='width:80%;height:1px; background:black;margin-left:auto; margin-right:auto;'></div>";
                            addReply += "<br>";
                            addReply += "<div class='media'>";
                            addReply += "<div class='media-left media-middle'>";
                            addReply += "<a href='#'>";
                            addReply += "<img class='media-object' src='" + data.replies[j].user.photourl + "' alt='" + data.replies[j].user.name + "' style='width:100px;height:100px;'>";
                            addReply += "</a>";
                            addReply += "</div>";
                            addReply += "<div class='media-body'>";
                            addReply += "<h4 class='media-heading'>" + data.replies[j].user.name + "</h4>" + "<h5>" + data.replies[j].time + "</h5>"
                            addReply += "<span>" + data.replies[j].content + "</span></div></div>";
                        }
                        console.log(addReply);
                        $('#replyListView').append(addReply);
                        if (j == 0 || j < 15) {
                            var _hidden = document.getElementById("moreReply");
                            _hidden.style.display = "none";
                            $('#buttonDiv').append("<br><span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                        } else {
                            var _hidden2 = document.getElementById("moreReply");
                            _hidden2.style.display = "inline-block";
                        }
                        y += 1;
                    }
                }
            });
        });

        $('#createReply').click(function () {
            var content = UE.getEditor('replyContent').getContent();
            var user = "${user.name}"
            console.log(user);
            if (user || user != "") {
                jQuery.ajax({
                    url: "${ctx}/createReply.do",
                    data: {content: content, topicId: topicId},
                    success: function (data) {
                        if (data && data.success == "true") {
                            alert("回复成功");
                            window.location.href = "${ctx}/topicPages.do?topicId=" + topicId;
                        } else {
                            alert("服务器忙,回复失败");
                        }
                    }
                });
                } else {
                 window.location.href = "${ctx}/error.jsp"
                }
        });
</script>
