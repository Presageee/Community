<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/14
  Time: 23:31
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
    <title>资料编辑</title>
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
<div class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="list-group">
                <a href="${ctx}/homeSkip.do" class="list-group-item">
                    个人主页
                </a>
                <a href="${ctx}/homeEditSkip.do" class="list-group-item active"><strong>修改资料</strong></a>
                <a href="${ctx}/homePDFSkip.do" class="list-group-item">我的PDF</a>
                <a href="${ctx}/homeMediaSkip.do" class="list-group-item">我的视频</a>
                <a href="${ctx}/homeEditPasswordSkip.do" class="list-group-item">修改密码</a>
                <a href="${ctx}/homeReplySkip.do" class="list-group-item">我的回复</a>
                <a href="${ctx}/homeTopicSkip.do" class="list-group-item">我的提问</a>
            </div>
        </div>
        <div class="col-md-10" style="background-color: #eeeeee; min-height:86.5%">
            <form class="form-horizontal" enctype="multipart/form-data">
                <input type="hidden" id="id" value="${user.id}"/>
                <input type="hidden" id="imgSrc" value=""/>

                <div class="form-group" id="preview">
                    <br>
                    &nbsp
                    <img src="${user.photourl}" alt="..." class="img-thumbnail" id="picture"
                         style="width: 200px; height:200px; margin-left:17%;">
                </div>
                <div class="form-group">
                    <label for="inputFileButton" class="col-sm-2 control-label">File input:</label>
                    &nbsp
                    &nbsp
                    <input type="button" id="inputFileButton" class="btn btn-default" value="请选择文件"
                           onclick="inputFile.click()"/>
                    <input type="file" id="inputFile" name="inputFile" class="col-sm-3 control-label"
                           onchange="changeImage()"
                           style="position:absolute; filter:alpha(opacity=0);opacity:0;width:30px;" size="1">
                </div>
                <div class="form-group">
                    <label for="phone" class="col-sm-2 control-label">Phone:</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="phone" placeholder="11位" value="${user.phone}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-2 control-label">Address:</label>

                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="address" placeholder="城市或详细住址"
                               value="${user.address}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="goodAt" class="col-sm-2 control-label">Good at:</label>

                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="goodAt" placeholder="擅长的技术"
                               value="${user.goodat}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="educational" class="col-sm-2 control-label">Educational:</label>

                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="educational" placeholder="真实学历"
                               value="${user.educationalbackground}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="profile" class="col-sm-2 control-label">Profile:</label>

                    <div class="col-sm-10">
                        <textarea class="form-control" rows="3" id="profile" placeholder="这个人很懒，字都懒得打">${user.description}</textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" id="submit">提交</button>
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
    $(function () {
        $('#submit').click(function () {
            var id = $('#id').val();
            var imgSrc = $('#imgSrc').val();
            var phone = $('#phone').val();
            var address = $('#address').val();
            var goodAt = $('#goodAt').val();
            var educational = $('#educational').val();
            var profile = $('#profile').val();
            jQuery.ajax({
                data: {id: id, imgSrc: imgSrc, phone: phone, address: address, goodAt: goodAt,
                    educational: educational, profile: profile},
                url: "${ctx}/edit.do",
                type: "POST",
                success: function (data) {
                    if (data && data.success == "true"){
                        alert("修改成功");
                        window.location.href = "${ctx}/homeSkip.do";
                    } else {
                        alert("出现了不知名的bug上传失败");
                    }
                }
            });
        });
    });
</script>
<script>
    function changeImage() {
        var path = $('#inputFile').val();
        var fileName = path.substring(path.lastIndexOf('\\') + 1);
        console.log(fileName);
        console.log($('#picture').val());
        //$('#picture').attr("src", "${ctx}/fileUpload/temp/" + fileName);
        $.ajaxFileUpload({
            url: "${ctx}/imageUpload.do",
            secureuri: false,
            fileElementId: "inputFile",
            type: 'POST',
            success: function (data, status) {
                var str = $(data).find("body").text();
                var json = $.parseJSON(str);
                if (json && json.success == "true") {
                    $('#picture').attr("src", "${ctx}/image/" + fileName);
                    $('#inputFile').value = fileName;
                    $('#imgSrc').attr("value", "${ctx}/image/" + fileName);
                }
            }
        });
    }
</script>
