<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>【河南工业大学】校园校园二手市场</title>
    <link rel="icon" href="<%=basePath%>img/logo.jpg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>css/index.css"/>
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/materialize.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/index.bundle.js"></script>
    <link rel="stylesheet" href="<%=basePath%>css/materialize-icon.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/user.css"/>
    <link rel="stylesheet" href="<%=basePath%>css/homegoods.css"/>
    <script>
        function showLogin() {
            if ($("#signup-show").css("display") == 'block') {
                $("#signup-show").css("display", "none");
            }
            if ($("#login-show").css("display") == 'none') {
                $("#login-show").css("display", "block");
            } else {
                $("#login-show").css("display", "none");
            }
        }

        function showSignup() {
            if ($("#login-show").css("display") == 'block') {
                $("#login-show").css("display", "none");
            }
            if ($("#signup-show").css("display") == 'none') {
                $("#signup-show").css("display", "block");
            } else {
                $("#signup-show").css("display", "none");
            }
        }

        function ChangeName() {
            if ($("#changeName").css("display") == 'none') {
                $("#changeName").css("display", "block");
            } else {
                $("#changeName").css("display", "none");
            }
        }

        $(document).ready(function () {
            //注册异步验证
            $("#phone").blur(function () {
                var phone = $(this).val();
                $.ajax({
                    url: '<%=basePath%>user/register',
                    type: 'POST',
                    data: {phone: phone},
                    dataType: 'json',
                    success: function (json) {
                        if (json.flag) {
                            $("#errorPhone").html("账号已被注册，请重新输入!");
                            $("#register").attr("disabled", true);
                        } else {
                            $("#errorPhone").empty();
                            $("#register").attr("disabled", false);
                        }
                    },
                    error: function () {
                        alert('请求超时或系统出错!');
                    }
                });

            });

            $("#login_password").blur(function () {
                var phone = $("#login_phone").val();
                var password = $(this).val();
                $.ajax({
                    url: '<%=basePath%>user/password',
                    type: 'POST',
                    data: {phone: phone, password: password},
                    dataType: 'json',
                    success: function (json) {
                        if (json) {
                            if (json.flag == true&&json.success == true) {
                                $("#errorPassword").html("密码错误！");
                                $("#loginIn").attr("disabled", true);
                            }else if(json.flag == true&&json.success == false) {
                                $("#login_errorPhone").html("账号密码不能为空!");
                                $("#errorPassword").html("账号密码不能为空！");
                                $("#loginIn").attr("disabled", true);
                            }else if(json.flag == false&&json.success == true) {
                                $("#errorPassword").empty();
                                $("#loginIn").attr("disabled", false);
                            }else {
                                $("#login_errorPhone").html("账号不存在，请先注册!");
                                $("#loginIn").attr("disabled", true);
                            }
                        }
                    },
                    error: function (json) {
                        alert("系统出错啦");
                    }
                });

            });

        });


    </script>
<body ng-view="ng-view">
<!--
    描述：顶部
-->
<div ng-controller="headerController" class="header stark-components navbar-fixed ng-scope">
    <nav class="white nav1">
        <div class="nav-wrapper">
            <a href="<%=basePath%>goods/homeGoods" class="logo">
                <em class="em1">河南工业大学</em>
                <em class="em2">校园二手市场</em>
                <em class="em3"></em>
            </a>
            <div class="nav-wrapper search-bar">
                <form class="ng-pristine ng-invalid ng-invalid-required" action="<%=basePath%>goods/search">
                    <div class="input-field">
                        <input id="search" name="str" placeholder="搜点什么吧..." style="height: 40px;"
                               class="ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <input type="submit" class="btn" value="搜索"></input>
                        <label for="search" class="active">
                            <i ng-click="search()" class="iconfont"></i>
                        </label>
                    </div>
                </form>
            </div>
            <ul class="right">
                <c:if test="${empty cur_user}">
                    <li class="publish-btn">
                        <button onclick="showLogin()" data-toggle="tooltip"
                                title="您需要先登录哦！" class="red lighten-1 waves-effect waves-light btn">
                            我要发布
                        </button>
                    </li>
                </c:if>
                <c:if test="${!empty cur_user}">
                    <li class="publish-btn">
                        <button data-position="bottom" class="green lighten-1 waves-effect waves-light btn">
                            <a href="<%=basePath%>goods/publishGoods">我要发布</a>
                        </button>
                    </li>
                    <li>
                        <a href="<%=basePath%>user/allGoods">我发布的商品</a>
                    </li>
                    <li>
                        <a>${cur_user.username}</a>
                    </li>
                    <li class="changemore">
                        <a class="changeMoreVertShow()">
                            <i class="iconfont"></i>
                        </a>
                        <div class="more-vert">
                            <ul class="dropdown-content">
                                <li><a href="<%=basePath%>user/home">个人中心</a></li>
                                <li><a href="<%=basePath%>user/allFocus">我的关注</a></li>
                                <li><a onclick="ChangeName()">更改用户名</a></li>
                                <li><a href="<%=basePath%>admin" target="_blank">登录后台</a></li>
                                <li><a href="<%=basePath%>user/logout">退出登录</a></li>
                            </ul>
                        </div>
                    </li>
                </c:if>
                <c:if test="${empty cur_user}">
                    <li>
                        <a onclick="showLogin()">登录</a>
                    </li>
                    <li>
                        <a onclick="showSignup()">注册</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
<!--
    描述：登录
-->
<div ng-controller="loginController" class="ng-scope">
    <div id="login-show" class="login stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showLogin()">
                    <div class="col s12 title"></div>
                </a>
                <form action="<%=basePath%>user/login" method="post" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="login_phone" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机&nbsp;&nbsp;<div id="login_errorPhone" style="color:red;display:inline;"></div>
                        </label>
                    </div>
                    <div class="input-field col s12">
                        <input type="password" id="login_password" name="password" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码&nbsp;&nbsp;<div id="errorPassword" style="color:red;display:inline;"></div>
                        </label>
                        <!--   <a ng-click="showForget()" class="forget-btn">忘记密码？</a> -->
                    </div>
                    <button type="submit" id="loginIn" class="waves-effect waves-light btn login-btn blue lighten-1">
                        <i class="iconfont left"></i>
                        <em>登录</em>
                    </button>
                    <div class="col s12 signup-area">
                        <em>没有账号？赶快</em>
                        <a onclick="showSignup()" class="signup-btn">注册</a>
                        <em>吧！</em>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--

    描述：注册
-->
<div ng-controller="signupController" class="ng-scope">
    <div id="signup-show" class="signup stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <a onclick="showSignup()">
                    <div class="col s12 title"></div>
                </a>
                <form action="<%=basePath%>user/addUser" method="POST" role="form" id="signup_form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>昵称</label>
                    </div>
                    <div class="input-field col s12">
                        <input type="text" name="phone" id="phone" required="required" pattern="^1[0-9]{10}$"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>手机&nbsp;&nbsp;<div id="errorPhone" style="color:red;display:inline;"></div>
                        </label>

                    </div>
                    <div class="input-field col s12">
                        <input type="password" name="password" required="required"
                               class="validate ng-pristine ng-untouched ng-empty ng-invalid ng-invalid-required"/>
                        <label>密码</label>
                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button type="submit" id="register"
                                class="waves-effect waves-light btn verify-btn blue lighten-1">
                            <i class="iconfont left"></i>
                            <em>点击注册吧</em>
                        </button>
                    </div>
                    <div ng-show="checkTelIsShow" class="login-area col s12">
                        <em>已有账号？去</em>
                        <a onclick="showLogin()">登录吧</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--更改用户名-->
<div ng-controller="changeNameController" class="ng-scope">
    <div id="changeName" class="change-name stark-components">
        <div class="publish-box z-depth-4">
            <div class="row">
                <div class="col s12 title">
                    <h1>修改用户名</h1>
                </div>
                <form action="<%=basePath%>user/changeName" method="post" role="form">
                    <div class="input-field col s12">
                        <input type="text" name="username" required="required"
                               class="validate ng-pristine ng-empty ng-invalid ng-invalid-required ng-valid-pattern ng-touched"/>
                        <label>修改用户名</label>

                    </div>
                    <div ng-show="checkTelIsShow" class="col s12">
                        <button class="waves-effect waves-light btn publish-btn red lighten-1">
                            <i class="iconfont left"></i>
                            <em>确认</em>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--
    描述：左侧导航条
-->
<div ng-controller="sidebarController" class="sidebar stark-components ng-scope">
    <li ng-class="{true: 'active'}[isAll]">
        <a href="<%=basePath%>goods/catelog" class="index">
            <img src="<%=basePath%>img/new.png">
            <em>最新出炉</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isDigital]">
        <a href="<%=basePath%>goods/catelog/1" class="digital">
            <img src="<%=basePath%>img/digital.png"/>
            <em>数码设备</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isRide]">
        <a href="<%=basePath%>goods/catelog/2" class="ride">
            <img src="<%=basePath%>img/bicycle.png"/>
            <em>骑行设备</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isCommodity]">
        <a href="<%=basePath%>goods/catelog/3" class="commodity">
            <img src="<%=basePath%>img/kettle.png"/>
            <em>家用电器</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isBook]">
        <a href="<%=basePath%>goods/catelog/4" class="book">
            <img src="<%=basePath%>img/book.png"/>
            <em>二手书籍</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isMakeup]">
        <a href="<%=basePath%>goods/catelog/5" class="makeup">
            <img src="<%=basePath%>img/coat.png"/>
            <em>衣物饰品</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSport]">
        <a href="<%=basePath%>goods/catelog/6" class="sport">
            <img src="<%=basePath%>img/sport.png"/>
            <em>棋牌球类</em>
        </a>
    </li>
    <li ng-class="{true: 'active'}[isSmallthing]">
        <a href="<%=basePath%>goods/catelog/7" class="smallthing">
            <img src="<%=basePath%>img/ticket.png"/>
            <em>杂货市场</em>
        </a>
    </li>
    <div class="info">
        <a href="#">关于我们</a><em>-</em>
        <a href="#">联系我们</a>
        <p>©2020 河南工业大学校园二手市场</p>
    </div>
</div>
<!--

    描述：右侧显示部分
-->
<div class="main-content">
    <!--

        描述：右侧banner（图片）部分
    -->
    <div class="slider-wapper">
        <div class="slider"
             style="height: 440px; touch-action: pan-y; -webkit-user-drag: none; -webkit-tap-highlight-color: rgba(0, 0, 0, 0);">
            <ul class="slides" style="height: 400px;">
                <li class="active" style="opacity: 1;">
                    <a href="<%=basePath%>goods/homeGoods">
                        <div class="bannerimg">
                            <ul class="bannerul">
                                <p class="text1">Hello：</p>
                                <p class="text2">欢迎来到【河南工业大学】校园二手市场。</p>
                                <p class="text3">临近毕业季，你是否有闲置物品同校友分享？</p>
                                <p class="text4">为了追求更好的校园服务，请到校园平台——<span>河南工业大学校园二手市场</span></p>
                                <p class="text5">这里有更多的闲置分享你想要的，都在这里。</p>
                                <p class="text6">加入河南工业大学校园二手市场，你的大学，应更精彩。</p>
                            </ul>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <!--

        描述：最新出炉
    -->
    <div class="index-title">
        <a href="">最新出炉</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：数码设备
    -->
    <div class="index-title">
        <a href="">数码设备</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods1}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <!--

        描述：骑行设备
    -->
    <div class="index-title">
        <a href="">骑行设备</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods2}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">家用电器</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods3}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">二手书籍</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods4}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">衣物饰品</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods5}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">棋牌球类</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods6}">
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="index-title">
        <a href="">杂货市场</a>
        <hr class="hr1">
        <hr class="hr2">
    </div>
    <div class="waterfoo stark-components row">
        <div class="item-wrapper normal">
            <c:forEach var="item" items="${catelogGoods7}">//
                <div class="card col">
                    <a href="<%=basePath%>goods/goodsId/${item.goods.id}">
                        <div class="card-image">
                            <img src="<%=basePath%>upload/${item.images[0].imgUrl}"/>
                        </div>
                        <div class="card-content item-price"><c:out value="${item.goods.price}"></c:out></div>
                        <div class="card-content item-name">
                            <p><c:out value="${item.goods.name}"></c:out></p>
                        </div>
                        <div class="card-content item-location">
                            <p>河南工业大学</p>
                            <p><c:out value="${item.goods.startTime}"></c:out></p>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>