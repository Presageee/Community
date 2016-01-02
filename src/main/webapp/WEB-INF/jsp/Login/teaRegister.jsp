<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/10
  Time: 1:34
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
        height: 415px;
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
    <title>teacher Register</title>
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
                    <legend>教师注册</legend>
                    <div class="form-group">
                        <label>email</label>
                        <input type="text" class="form-control" required name="email" id="email">

                        <div class="message content">email不能为空</div>
                    </div>
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" class="form-control" required name="name" id="name">

                        <div class="message content">用户名不能为空</div>
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" class="form-control" required name="password" id="password">

                        <div class="message content">密码不能为空</div>
                    </div>
                    <div class="form-group">
                        <label>重新输入密码</label>
                        <input type="password" class="form-control" requied name="repeatPassword" id="repeatPassword">

                        <div class="message content">与上面密码不一致</div>
                    </div>
                    <button type="button" class="btn btn-primary pull-left" id="submit">注册</button>
                    <a href="${ctx}/api/teaLoginSkip.do">
                        <button type="button" class="btn btn-primary pull-right">登陆</button>
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
        var email = $('#email').val();
        var name = $('#name').val();
        var password = $('#password').val();
        var correctEmail = "false";
        var correctName = "false";
        var correctPw = "false";
        var correctRpw = "false";
        $('#email').blur(function () {
            email = $(this).val();
            if ($(this).val() != '') {
                jQuery.ajax({
                    data: {email: email},
                    type: 'GET',
                    url: '${ctx}/api/emailIsExists/',
                    success: function (data) {
                        if (data && data.success == "true") {
                            $('#email').next().removeClass('open');
                            correctEmail = "true";
                        } else {
                            correctEmail = "false";
                            $('#email').next().text("email已被使用");
                            $('#email').next().addClass('open');
                        }
                    }
                });
            } else {
                correctEmail = "false";
                $(this).next().text("email不能为空");
                $(this).next().addClass('open');
            }
        });

        $('#name').blur(function () {
            name = $(this).val();
            if ($(this).val() != '') {
                jQuery.ajax({
                    data: {name: name},
                    type: 'GET',
                    url: '${ctx}/api/nameIsExists/',
                    success: function (data) {
                        if (data && data.success == "true") {
                            $('#name').next().removeClass('open');
                            correctName = "true";
                        } else {
                            correctName = "false";
                            $('#name').next().text("name已被使用");
                            $('#name').next().addClass('open');
                        }
                    }
                });
            } else {
                correctName = "false";
                $(this).next().text("name不能为空");
                $(this).next().addClass('open');
            }
        });

        $('#password').blur(function () {
            password = $(this).val();
            if ($(this).val() != '') {
                correctPw = "true";
                $(this).next().removeClass('open');
                if ($(this).val() != $('#repeatPassword').val()) {
                    correctRpw = "false";
                    $('#repeatPassword').next().addClass('open');
                } else {
                    correctRpw = "true";
                    $('#repeatPassword').next().removeClass('open');
                }
            } else {
                correctPw = "false";
                $(this).next().addClass('open');
            }
        });

        $('#repeatPassword').blur(function () {
            if ($(this).val() == $('#password').val()) {
                correctRpw = "true";
                $(this).next().removeClass('open');
            } else {
                correctRpw = "false";
                $(this).next().addClass('open');
            }
        });

        $('#submit').click(function () {
            if (correctEmail == "true" && correctName == "true" &&
                    correctPw == "true" && correctRpw == "true"){
                jQuery.ajax({
                    data: {email: email, name: name, password: password},
                    type: 'POST',
                    url: '${ctx}/api/teaRegister/',
                    success: function (data) {
                        if (data && data.success == "true") {
                            window.location.href="${ctx}/teaLogin.do";
                        } else {
                            alert("注册失败");
                        }
                    }
                });
            }
        });
    });
</script>
