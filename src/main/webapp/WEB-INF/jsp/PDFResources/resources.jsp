<%--
  Created by IntelliJ IDEA.
  User: LJT
  Date: 2015/12/11
  Time: 10:03
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

    <title>电子书资源</title>
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
                <li class="active"><a href="${ctx}/PDFSkip.do">电子书</a></li>
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
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <form style="padding-top:1em" action="searchPDFByKey.do" method="post">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search for..." name="search"
                                   id="search"/>
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="formSubmit()">Go!</button>
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
        <div class="col-md-6" style="margin-bottom:1.4em; padding-top:.4em;">
            <span>最近热搜：</span>
            <a href="${ctx}/searchPDFByKey.do?search=Java"><span class="label label-primary" style="margin-right:.5em">Java</span></a>
            <a href="${ctx}/searchPDFByKey.do?search=Python"><span class="label label-info" style="margin-right:.5em">Python</span></a>
            <a href="${ctx}/searchPDFByKey.do?search=HTML5/CSS3"><span class="label label-danger" style="margin-right:.5em">HTML5/CSS3</span></a>
            <a href="${ctx}/searchPDFByKey.do?search=Algorithms"><span class="label label-success" style="margin-right:.5em">算法</span></a>

        </div>
        <div class="col-md-2">
            <button class="btn btn-default" type="button" id="uploadPDF">我为社区出份力(我要上传)</button>
        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div style="width:100%;height:1px; background:black;margin-left:auto; margin-right:auto;"></div>
            <br>
            <ul class="list-group" id="resultsList">
            </ul>
            <div class="col-md-12" id="buttonDiv">
                <button class="btn btn-default" style="margin-left:42%;margin-right:auto;    display: none;"
                        id="moreSearchPDF">查看更多
                </button>
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
    var x = 1;
    var y = 2;
    var searchKey = "${searchKey}";
    function load() {
        if (searchKey == null) {
            searchKey = "";
        } else {
            $('#search').attr("value", searchKey);
        }
        jQuery.ajax({
            url: "${ctx}/searchPDF.do",
            data: {index: x, key: searchKey},
            type: "POST",
            success: function (data) {
                if (data && data.success == "true") {
                    console.log(data.success);
                    console.log(data.pdf);
                    var i;
                    var addResults = "";
                    for (i = 0; i < data.pdf.length; i++) {
                        addResults += "<a href='${ctx}/RedirectPDFReader.do?pdfId=" + data.pdf[i].id + "'><li class='list-group-item'>";
                        addResults += "<span class='badge'>" + data.pdf[i].time + "</span>";
                        addResults += data.pdf[i].name + "</li></a> <br>";
                    }
                    console.log(addResults);
                    $('#resultsList').append(addResults);
                    var _hidden2 = document.getElementById("moreSearchPDF");
                    _hidden2.style.display = "inline-block";
                    if (i == 0 || i < 15) {
                        var _hidden = document.getElementById("moreSearchPDF");
                        _hidden.style.display = "none";
                        $('#buttonDiv').append("<span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    }
                    x += 1;
                } else {
                    alert("暂未收录相关资源");
                }
            }
        });
    }

    $('#moreSearchPDF').click(function () {
        jQuery.ajax({
            url: "${ctx}/searchPDF.do",
            data: {index: y, key: searchKey},
            type: "POST",
            success: function (data) {
                if (data && data.success == "true") {
                    console.log(data.success);
                    console.log(data.pdf);
                    var i;
                    var addResults = "";
                    for (i = 0; i < data.pdf.length; i++) {
                        addResults += "<a href='${ctx}/RedirectPDFReader.do?pdfId=" + data.pdf[i].id + "'><li class='list-group-item'>";
                        addResults += "<span class='badge'>" + data.pdf[i].time + "</span>";
                        addResults += data.pdf[i].name + "</li></a> <br>";
                    }
                    console.log(addResults);
                    $('#resultsList').append(addResults);

                    if (i == 0 || i < 15) {
                        var _hidden = document.getElementById("moreSearchPDF");
                        _hidden.style.display = "none";
                        $('#buttonDiv').append("<span style='text-align=center; margin-left: 45%;'>没有更多了</span>");
                    }
                    y += 1;
                } else {
                    alert("暂未收录相关资源");
                }
            }
        });
    });

    function formSubmit() {
        var form = document.forms[0];
        form.submit();
    }

    $('#uploadPDF').click(function () {
        window.location.href = "${ctx}/PDFUploadSkip.do";
    });
</script>