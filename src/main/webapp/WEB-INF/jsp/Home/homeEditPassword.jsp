<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/14
  Time: 23:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap.min.css"/>">
    <script src="<c:url value="/js/jquery.min.js"/>" type="text/javascript"></script>
    <script type="text/javascript" src="<c:url value="/js/bootstrap.min.js"/>"></script>
    <title>修改密码</title>
</head>
<style>
    input + .message,
    textarea + .message {
        position: absolute;
        right: -8em;
        bottom: 0;

        border-radius: .4em;
        padding: .5em;
        max-width: 16em;

        font-size: .8em;
        background: #fed;
        box-shadow: .05em .2em .6em rgba(0, 0, 0, .2);

        transition: .5s cubic-bezier(.25, .1, .3, 1.5) transform;
        transform: scale(0);
    }

    input + .message:before,
    textarea + .message:before {
        position: absolute;
        top: calc(50% - .35em);
        left: -.35em;

        border: inherit;
        border-right: 0;
        border-bottom: 0;
        padding: .35em;

        background: inherit;
        transform: rotate(45deg);

        content: "";
    }

    .form-group {
        position: relative;
    }

    .message.open {
        transform: scale(1);
        transform-origin: 1.4em -.4em;
    }

    .message.content {
        color: #000000;
        background: red;
    }
</style>
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
                <li><a href="${ctx}/api/PDFSkip.do">电子书</a></li>
                <li><a href="${ctx}/api/MediaSkip.do">视频</a></li>
                <li><a href="${ctx}/api/topicSkip.do">社区</a></li>
                <li><a href="${ctx}/about.jsp">关于</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <c:choose>
                        <c:when test="${isLogin == 'hello'}">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">${user.name}<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="${ctx}/api/homeSkip.do">个人中心</a></li>
                                <li><a href="${ctx}/api/homeEditSkip.do">修改资料</a></li>
                                <li><a href="${ctx}/api/homeEditPasswordSkip.do">修改密码</a></li>
                                <li role="separator" class="divider"></li>
                                <li><a href="${ctx}/api/logoutSkip.do">注销</a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">登陆/注册<span class="caret"></span></a>
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
<div class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${ctx}/api/homeSkip.do" class="list-group-item">
                    个人主页
                </a>
                <a href="${ctx}/api/homeEditSkip.do" class="list-group-item active"><strong>修改资料</strong></a>
                <a href="${ctx}/api/homePDFSkip.do" class="list-group-item">我的PDF</a>
                <a href="${ctx}/api/homeMediaSkip.do" class="list-group-item">我的视频</a>
                <a href="${ctx}/api/homeEditPasswordSkip.do" class="list-group-item">修改密码</a>
                <a href="${ctx}/api/homeReplySkip.do" class="list-group-item">我的回复</a>
                <a href="${ctx}/api/homeTopicSkip.do" class="list-group-item">我的提问</a>
            </div>
        </div>
        <div class="col-md-10" style="background-color: #eeeeee; min-height:86.5%">
            <form class="form-horizontal">
                <h3>修改密码真的好吗</h3>
                <br>
                <input type="hidden" value="${user.id}" id="id">
                <input type="hidden" value="put" id="method"/>
                <div class="form-group">
                    <label for="oldPassword" class="col-sm-2 control-label">old password:</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="oldPassword" placeholder="11位">
                        <div class="message content">必须为8-16位字母数字</div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="newPassword" class="col-sm-2 control-label">new password:</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="newPassword" placeholder="11位">
                        <div class="message content">必须为8-16位字母数字</div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="repeatPassword" class="col-sm-2 control-label">repeat password:</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="repeatPassword" placeholder="重新输入新密码">
                        <div class="message content">与新密码不一致</div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" id="submit" class="btn btn-default">Submit</button>
                    </div>
                </div>
            </form>
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
    $(function() {
        var id = $('#id').val();
        var oldPassword = $('#oldPassword').val();
        var newPassword = $('#newPassword').val();
        var repeatPassword = $('#repeatPassword').val();
        var isNPwOk = "false";
        var isRPwOk = "false";
        $('#newPassword').blur(function (){
            newPassword = $(this).val();
            if (newPassword != ''){
                isNPwOk = "false";
                $(this).next().removeClass('open');
                if (newPassword != $('#repeatPassword').val()){
                    isNPwOk = "false";
                    $('#repeatPassword').next().addClass('open');
                }else {
                    isNPwOk = "true";
                    isRPwOk = "true";
                    $('#repeatPassword').next().removeClass('open');
                }
            }else {
                isNPwOk = "false";
                $('#newPassword').next().addClass('open');
            }
        });

        $('#repeatPassword').blur(function () {
           repeatPassword = $(this).val();
            if (repeatPassword != $('#newPassword').val()){
                isRPwOk = "false";
                $('#repeatPassword').next().addClass('open');
            }else {
                isRPwOk = "true";
                isNPwOk = "true";
                $('#repeatPassword').next().removeClass('open');
            }
        });

        $('#submit').click(function () {
            oldPassword = $('#oldPassword').val();
            newPassword = $('#newPassword').val();
            repeatPassword = $('#repeatPassword').val();
            var method = $('#method').val();
            console.log(isNPwOk + " " + isRPwOk);
            if(isNPwOk == "true" && isRPwOk == "true"){
                jQuery.ajax({
                    data: {id: id, oldPassword: oldPassword, newPassword: newPassword, repeatPassword: repeatPassword, _method: method},
                    url: "${ctx}/api/user/password/",
                    type: "POST",
                    success: function (data) {
                        if(data && data.success == "true"){
                            alert("修改成功");
                            window.location.href = "${ctx}/api/homeSkip.do";
                        } else {
                            alert("a shit bug!");
                        }
                    }
                });
            }
        })
    });
</script>