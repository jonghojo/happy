<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>guestBook register</title>
</head>
<body>

	<div>Board Register</div>
		<div class="Board body">
			<form role="form" action="/invitation/register" method="post">
				<div class="form-group">
					<label>내용</label><textarea class="form-control" row="3" name="content"></textarea>
				</div>
				<div class="form-group">
					<label>작성자</label><input class="form-control" name="writer">
				</div>
				<div class="form-group">
					<label>비밀번호입력</label><input class="form-control" type="password" name="guestpw">
				</div>
				<button type="submit" class="btn btn-default">작성완료</button>
				<button type="reset" class="btn btn-default">다시 쓰기</button>
			</form>
		</div>

</body>
</html>