<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/20
  Time: 13:38
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

    <title>社区</title>
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
<body onload="load()">
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
                <li class="active"><a href="${ctx}/topicSkip.do">社区</a></li>
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
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <form style="padding-top:1em" action="searchTopicByKey.do" method="post">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for..." name="search" id="search"/>
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" id="searchTopic" onclick="formSubmit()">Go!</button>
      </span>
                        </div><!-- /input-group -->
                    </div><!-- /.col-lg-6 -->
                </div><!-- /.row -->
            </form>

        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-10">
            <button class="btn btn-default" type="button" style="margin-bottom:1em;" onclick="jump()">发起新话题</button>
            <br>
        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div style="width:100%;height:1px; background:black;margin-left:auto; margin-right:auto;"></div>
            <br>
            <ul class="list-group" id="topicListView">

            </ul>
            <div class="col-md-12" id="buttonDiv">
                <button class="btn btn-default" style="margin-left:42%;margin-right:auto; margin-bottom:1em;"
                        id="moreSearchTopic">查看更多
                </button>
                <div style="width:100%;height:1px; background:black;margin-left:auto; margin-right:auto;"></div>
                <br>
            </div>
            <div class="col-md-12">
                <form class="form-horizontal">
                    <div class="form-group">
                        <h3>发表新话题</h3>
                    </div>
                    <div class="form-group">
                        <label for="title" class="col-sm-1 control-label">标题:</label>

                        <div class="col-sm-9">
                            <input type="text" name="title" class="form-control" id="title" placeholder="标题" />
                        </div>
                        <div class="col-sm-2">
                            <select id="courseType"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <!-- 加载编辑器的容器 -->
                        <script id="topicContent" name="content" type="text/plain">
                        </script>
                    </div>
                    <div class="form-group">
                        <div class="col-md-11"></div>
                        <div class="col-md-1">
                            <button class="btn btn-default" type="button" id="createTopic">发表</button>
                        </div>
                    </div>
                </form>
                <!-- 配置文件 -->
                <script type="text/javascript" src="ueditor1_4_3/ueditor.config.js"></script>
                <!-- 编辑器源码文件 -->
                <script type="text/javascript" src="ueditor1_4_3/ueditor.all.js"></script>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">
                    var ue = UE.getEditor('topicContent');
                </script>
            </div>
        </div>
        <div class="col-md-1"></div>
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
    $('#createTopic').click(function (){
        var html = UE.getEditor('topicContent').getContent();
        var title = $('#title').val();
        var type = $('#courseType').val();
        var user = "${user.name}"
        console.log(user);
        if (user || user != "") {
            jQuery.ajax({
                url: "${ctx}/createTopic.do",
                data: {content: html, courseType: type, title: title},
                success: function (data){
                    if (data && data.success == "true"){
                        alert("发表成功");
                        window.location.href = "${ctx}/topicSkip.do";
                    } else {
                        if (data.message) {
                            alert(data.message);
                        } else {
                            alert("发表失败，请重试");
                        }
                    }
                }
            });
        } else {
            window.location.href = "${ctx}/error.jsp"
        }
    });

    var x = 1;
    var searchTopicKey = "${searchTopicKey}";
    function load(){
        if (searchTopicKey == null){
            searchTopicKey = "";
        } else {
            $('#search').attr("value", searchTopicKey);
        }
        jQuery.ajax({
            url: "${ctx}/searchTopic.do",
            data: {searchTopicKey: searchTopicKey, index: x},
            success: function (data){
                if (data && data.success == "true") {
                    console.log(data.success);
                    var i;
                    var addResults = "";
                    for(i = 0; i < data.topics.length; i++){
                        addResults += "<a href='${ctx}/topicPages.do?topicId=" + data.topics[i].id + "'><li class='list-group-item'>";
                        addResults += "<span class='badge'>" + data.topics[i].lastreplytime + "</span>";
                        addResults += "<span class='badge'>" + data.topics[i].user.name + "</span>";
                        addResults += "<span class='badge'>" + data.topics[i].type + "</span>";
                        addResults += "<span class='badge'>" + data.topics[i].replycnt + "</span>";
                        addResults +=  data.topics[i].title + " </li></a> <br>";
                    }
                    //console.log(addResults);
                    $('#topicListView').append(addResults);
                    if (i == 0 || i < 15){
                        var _hidden = document.getElementById("moreSearchTopic");
                        _hidden.style.display="none";
                        $('#buttonDiv').append("<br><span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    } else {
                        var _hidden2 = document.getElementById("moreSearchTopic");
                        _hidden2.style.display="inline-block";
                    }
                    x += 1;
                }
            }
        });
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
        });
    }

    $('#moreSearchTopic').click(function () {
        jQuery.ajax({
            url: "${ctx}/searchTopic.do",
            data: {searchTopicKey: searchTopicKey, index: x},
            success: function (data){
                console.log(data.success);
                var i;
                var addResults = "";
                for(i = 0; i < data.topics.length; i++){
                    addResults += "<a href='${ctx}/topicPages.do?topicId=" + data.topics[i].id + "'><li class='list-group-item'>";
                    addResults += "<span class='badge'>" + data.topics[i].lastreplytime + "</span>";
                    addResults += "<span class='badge'>" + data.topics[i].user.name + "</span>";
                    addResults += "<span class='badge'>" + data.topics[i].type + "</span>";
                    addResults += "<span class='badge'>" + data.topics[i].replycnt + "</span>";
                    addResults +=  data.topics[i].title + " </li></a> <br>";
                }
                console.log(addResults);
                $('#topicListView').append(addResults);
                if (i == 0 || i < 15){
                    var _hidden = document.getElementById("moreSearchTopic");
                    _hidden.style.display="none";
                    $('#buttonDiv').append("<br><span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                }
                x += 1;
            }
        });
    });

    function formSubmit() {
        var form = document.forms[0];
        form.submit();
    }

    function jump(){
        window.location.href = "#title";
    }
</script>
