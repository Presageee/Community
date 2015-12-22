<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/14
  Time: 23:45
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
    <title>我的回复</title>
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
<div class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${ctx}/homeSkip.do" class="list-group-item">
                    个人主页
                </a>
                <a href="${ctx}/homeEditSkip.do" class="list-group-item">修改资料</a>
                <a href="${ctx}/homePDFSkip.do" class="list-group-item">我的PDF</a>
                <a href="${ctx}/homeMediaSkip.do" class="list-group-item">我的视频</a>
                <a href="${ctx}/homeEditPasswordSkip.do" class="list-group-item">修改密码</a>
                <a href="${ctx}/homeReplySkip.do" class="list-group-item active"><strong>我的回复</strong></a>
                <a href="${ctx}/homeTopicSkip.do" class="list-group-item">我的提问</a>
            </div>
        </div>
        <div class="col-md-10" style="background-color: #eeeeee; min-height:86.5%">
            <input type="hidden" id="userId" value="${user.id}"/>
            <h3>我的回复共有${user.replycnt}个</h3>
            <table class="table table-striped" id="tb">
                <thead>
                <tr>
                    <th class="col-md-2" style="text-align: center;">id</th>
                    <th class="col-md-5" style="text-align: center;">content</th>
                    <th class="col-md-5" style="text-align: center;">time</th>
                </tr>
                </thead>
            </table>
            <div class="col-md-12" id="buttonDiv">
                <button class="btn btn-default" style="margin-left: 45%;margin-right: auto;" id="addReply">查看更多</button>
            </div>
        </div>
    </div>
</div>
<footer style="background:#003443; color:gray; position: fixed; bottom: 0px; width: 100%">
    <div class="container" style="text-align:center; padding: 10px 0;">
        <span>&copy;Copyright 2015 by Presage</span>
    </div>
</footer>
</body>
</html>
<script>
    var x = 1;
    var y = 2;
    var tb = $('#tb');
    var userId = $('#userId').val();

    function load() {
        jQuery.ajax({
            url: "${ctx}/moreReply.do",
            type: "POST",
            data: {index: x, id: userId},
            success: function (data) {
                var addReply = "";
                var i = 0;
                var tb = $('#tb');
                if (data && data.success == "true"){
                    for(i = 0; i < data.replies.length; i++){
                        addReply += "<tr>";
                        addReply += "<th scope='row' class='col-md-2' style='text-align: center;'>" + data.replies[i].id + "</td>";
                        addReply += "<td class='col-md-5' style='text-align: center;'><a href='${ctx}/topicPages.do?topicId=" + data.replies[i].topicId + "'>" + data.replies[i].content + "</a></td>";
                        addReply += "<td class='col-md-5' style='text-align: center;'>" + data.replies[i].time + "</td>";
                        addReply += "</tr>";
                    }
                    $('#tb').append(addReply);
                    if(i < 16){
                        var _hidden = document.getElementById("addReply");
                        _hidden.style.display="none";
                        $('#buttonDiv').append("<span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    }
                    x += 1;
                }else {
                    alert("ajax请求失败");
                }
            }
        });
    }

    $('#addPDF').click(function() {
        jQuery.ajax({
            url: "${ctx}/moreReply.do",
            type: "POST",
            data: {index: y, id: userId},
            success: function (data) {
                var addReply = "";
                var i = 0;
                var tb = $('#tb');
                if (data && data.success == "true"){
                    for(i = 0; i < data.replies.length; i++){
                        addReply += "<tr>";
                        addReply += "<th scope='row' class='col-md-2' style='text-align: center;'>" + data.replies[i].id + "</td>";
                        addReply += "<td class='col-md-5' style='text-align: center;'><a href='${ctx}/topicPages.do?topicId=" + data.replies[i].topicId + "'>" + data.replies[i].content + "</a></td>";
                        addReply += "<td class='col-md-5' style='text-align: center;'>" + data.replies[i].time + "</td>";
                        addReply += "</tr>";
                    }
                    $('#tb').append(addReply);
                    if(i < 16){
                        var _hidden = document.getElementById("addReply");
                        _hidden.style.display="none";
                        $('#buttonDiv').append("<span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    }
                    y += 1;
                }else {
                    alert("ajax请求失败");
                }
            }
        });
    });
</script>
