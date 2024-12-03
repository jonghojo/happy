<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연아 ♡ 우림 모바일 청첩장</title>

     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

     <!-- css -->
     <link href="/resources/css/style.css" rel="stylesheet">
     
     <!-- js -->
     <script src="/resources/js/index.js"></script>

</head>
<body>

<div id="wrap">

        <div class="bg_g">
            <div id="main">
                                               
                <div id="slidewrap">
                    <h1 class="title">Wedding Invitation</h1>
                    
                    <ul class="slide">     
                       <li><img src="/resources/img/wedding11.jpg" alt="wedding"></li>           
                       <li><img src="/resources/img/wedding3.jpg" alt="wedding"></li>           
                       <li><img src="/resources/img/wedding16.jpg" alt="wedding"></li>
                    </ul>
                    
                </div>
                <p class="notice">2025/01/17 <br>
                    서울신라호텔 다이너스티</p>
            </div>
    
            <div class="ment">
    
                <p class="date">2025/01/17</p>
    
                <div class="line">
                    <h3>결혼합니다.</h3>
                </div>
                
                <p>새로이 시작하는 작은 사랑이 <br>
                    보다 크고 깊은 사랑이 되려고 합니다.<br>
                    함께 자리하여 축복해 주시면<br>
                    더 없는 기쁨이겠습니다.
                </p>
            </div>
        </div>
     
        <div class="calender">
            <img src="/resources/img/january.png" alt="calender">
        </div>

        <div class="pictorial">
            <img src="/resources/img/wedding5.jpg" alt="wedding">
            <img src="/resources/img/wedding6.jpg" alt="wedding">
            <img src="/resources/img/wedding7.jpg" alt="wedding">
            <img src="/resources/img/wedding12.jpg" alt="wedding">
        </div>

        <div class="maps">

            <h3>오시는 길</h3>
            <img src="/resources/img/maps.png" alt="maps">
            <p>서울신라호텔 주소 : 서울시 중구 동호로 249</p>
            <img src="/resources/img/maps2.png" alt="">
        </div>

        <div id="account">

            <div class="line">
                <h4>마음 전하실 곳</h4>
            </div>

            <p class="count">참석이 어려워 직접 축하를 전하지 못할  <br> 
                분들을 위해 계좌번호를 남겼습니다.</p>
            
            <ul class="menu">

               <li><a href="#" class="brideLink">신랑 - 고우림</a>
                    <ul class="sub">
                        <li><a href="#" class="brideLink">우리은행 1000-1234-567890</a></li>
                    </ul>
                </li>
               
               <li><a href="#" class="brideLink">신부 - 김연아</a>
                    <ul class="sub">
                        <li><a href="#" class="brideLink">국민은행 100-12340-567890</a></li>
                    </ul>
                </li>
            </ul>

        </div>

        <div id="comments">

            <div class="btn_c">
                <p>"새로운 출발을 앞둔 부부에게 <br>
                    응원과 축하의 메세지를 남겨주세요~"
                </p>

                <form action="/invitation/list" method="get">
                <button type="submit" class="btn">메세지 남기러 가기!</button>
            </form>
            </div>

        </div>

        <footer>
            <p>thank you !</p>
        </footer>

    </div>

</body>
</html>
