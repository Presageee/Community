<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/10
  Time: 1:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap.min.css"/>">
<link rel="stylesheet" type="text/css" href="<c:url value="/css/bootstrap-combined.min.css"/>">
<script src="<c:url value="/js/jquery.min.js"/>" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value="/js/bootstrap.min.js"/>"></script>
<style type="text/css">
    .loginfuckcontainer {
        max-width: 1080px;
        min-height: 85%;
        height: auto;
        padding-top: 5%;
        padding-bottom: 60px;
        margin-left: auto;
        margin-right: auto;
    }

    .loginfuckhead {
        max-width: 1080px;
        height: 10%;
        margin-left: auto;
        margin-right: auto;
    }

    .loginfuckhead h1 {
        font-size: 20px;
        text-align: right;
    }

    #loginfuckfooter {
        width: 100%;
        position: fixed;
        bottom: 0px;
        margin-left: auto;
        margin-right: auto;
        background-color: #003443;
        color: gray;
    }

    .loginfuckfooter h1 {
        font-size: 10px;
        padding: 10px 0;
        text-align: center;
    }

    .fuckform {
        max-width: 330px;
        height: 310px;
        margin-left: auto;
        margin-right: auto;
        padding-top: 20px;
        background-color: white;
        border-radius: 25px;
        border: 1px solid;
        -moz-border-radius: 25px;
        opacity: 0.8;
    }

    .fuckbtn {
        border: 1px solid transparent;
        border-radius: 25px;
        -moz-border-radius: 25px;
        -moz-user-select: none;
        background-image: none;
        cursor: pointer;
        display: inline-block;
        white-space: nowrap;
        text-align: center;
        line-height: 1.42857;
        font-size: 14px;
        margin-bottom: 0px;
        padding: 6px 12px;
        margin-top: 5%;
        margin-left: 90%;
        opacity: 0.8;
    }

    body {
        height: 100%;
        background-color: #eeeeee;
    }

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
<head>
    <title>student Login</title>
</head>
<body>
<div class="loginfuckhead">
    <a href="${ctx}/index.jsp">
        <button class="fuckbtn">返回主页</button>
    </a>
</div>
<div class="loginfuckcontainer">
    <div class="fuckform">
        <div class="span3">
            <form>
                <fieldset>
                    <legend>学生登陆</legend>
                    <div class="form-group">
                        <label>email</label>
                        <input type="text" class="form-control" required name="email" id="email">

                        <div class="message content">用户名不能为空</div>
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" class="form-control" required name="password" id="password">

                        <div class="message content">请输入正确的密码</div>
                    </div>
                    <span class="help-block">这里填写帮助信息.</span>
                    <button type="button" class="btn btn-primary pull-left" id="submit">登陆</button>
                    <a href="${ctx}/api/stuRegisterSkip.do">
                        <button type="button" class="btn btn-primary pull-right">注册</button>
                    </a>
                </fieldset>
            </form>
        </div>
    </div>
</div>
<footer id="loginfuckfooter">
    <div class="container" style="text-align:center; padding: 10px 0;">
        <span>&copy;Copyright 2015 by Presage</span>
    </div>
</footer>
</body>
</html>
<script>
    $(function () {
        $('#name').blur(function () {
            if ($(this).val() != '') {
                $(this).next().removeClass('open');
            } else {
                $(this).next().addClass('open');
            }
        });

        $('#password').blur(function () {
            if ($(this).val() != '') {
                $(this).next().removeClass('open');
            } else {
                $(this).next().addClass('open');
            }
        });
    });
</script>
<script type="text/javascript">
    $(function () {
        $('#submit').click(function () {
            var email = $('#email').val();
            var pw = $('#password').val();
            jQuery.ajax({
                data: {email: email, password: pw},
                type: 'GET',
                url: '${ctx}/api/stuLogin/',
                success: function (data) {
                    if (data && data.success == "true") {
                        window.location.href = "${ctx}/index.jsp";
                    } else {
                        alert("email或密码不正确");
                    }
                }
            });
        });
    });
</script>