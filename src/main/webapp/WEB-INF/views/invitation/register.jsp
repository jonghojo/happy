<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestBook register</title>

<link rel="stylesheet" href="/resources/css/list.css">

</head>
<body>

   <div id="wrap_reg">
   
      <div class="regT_box">
         <h2 class="reg_title">축하메세지 작성하기</h2>
      </div>
      
      <div class="list_body">
         <form class="form_wit" role="form" action="/invitation/register" method="post" >
            <div class="form-group">
               <label>내용</label> <br>
               <textarea class="form-control text_a" name="content" placeholder="메세지를 작성해주세요."></textarea>
            </div>
            <div class="form-group">
               <label>작성자</label><br>
               <input class="form-control input_form" name="writer">
            </div>
            <div class="form-group">
               <label>비밀번호입력</label><br>
               <input class="form-control input_form" type="password" name="guestpw" placeholder="수정,삭제 시 필요합니다.">
            </div>
            
            <div class="btn_box">
               <button type="reset" class="btn btn-default">다시 쓰기</button>
               <button type="button" class="btn btn-default" onclick="location.href='/invitation/list';">목록가기</button>
               <button type="submit" class="btn btn-default" >작성완료</button>
            </div>
            
         </form>
      </div>
   
   </div>
   

</body>


</html>