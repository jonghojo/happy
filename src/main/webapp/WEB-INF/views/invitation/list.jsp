<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>guestBook</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
@font-face {
	font-family: 'SDSamliphopangche_Outline';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Outline.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

h1 {
	font-family: 'SDSamliphopangche_Outline';
	text-align: center;
	margin-top: 20px;
}

@font-face {
	font-family: 'Uiyeun';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2105@1.1/Uiyeun.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

.card {
	font-family: 'Uiyeun';
	font-size: 25px;
	margin: 10px 10px;
}
</style>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<h1>
		축하메세지를 적어주세요~<br>
		<br>
	</h1>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<table class="card">
		<c:forEach items="${list}" var="message">
			<tr class="card border-warning mb-3" style="max-width: 13rem;">
				<td class="card-header"><c:out value="${message.writer}" /></td>
				<td class="card-body">
					<p class="card-text">
						<a href='#' class="content-link" data-mno="${message.mno}"
							data-content="${message.content}"
							data-guestpw="${message.guestpw}"><c:out
								value="${message.content}" /></a>
					</p>
				</td>
				<td class="card-footer"><fmt:formatDate pattern="yyyy-MM-dd"
						value="${message.regdate }" /></td>
			</tr>
		</c:forEach>
	</table>

	<button id="regBtn" type="button">작성하기</button>
	
		<!-- 수정 모달 (수정 버튼 클릭 후 표시) -->
	<div id="editModal" class="modal" tabindex="-1">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title">게시글 수정</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <!-- 수정할 내용을 텍스트 영역으로 표시 -->
	                <div>
	                    <label for="contentInput">수정할 내용을 입력해주세요:</label>
	                    <textarea id="contentInput" class="form-control" rows="5"></textarea>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                <button type="button" class="btn btn-primary" id="updateBtn">수정 완료</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- 수정 모달 끝 -->
	
	<!-- 비밀번호 모달 -->
	<div id="passwordModal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">비밀번호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<label for="passwordInput">비밀번호를 입력해주세요:</label> <input
						type="password" id="passwordInput" class="form-control" placeholder="비밀번호">
					<div class="text-danger" id="error-message" style="display: none;">비밀번호가 일치하지 않습니다.</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" id="submitPasswordBtn">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달창 끝 -->



	<!-- 모달창 -->
	<div id="actionModal" class="modal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">게시글 수정/삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="messageContent"></p>
					<div>
						<button class="btn btn-primary" id="editBtn"
							data-mno="${message.mno}" data-guestpw="${message.guestpw}">수정</button>
						<button id="deleteBtn" class="btn btn-danger">삭제</button>
						<button id="listBtn" class="btn btn-secondary">목록으로</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달창 끝 -->

<script>
    $(document).ready(function() { // (1) $(document).ready 함수 시작

        // 내용 클릭 시 모달을 띄움
        $(".content-link").click(function() { // (2) .content-link 클릭 이벤트 함수 시작
            var mno = $(this).data("mno");
            var content = $(this).data("content");
            var guestpw = $(this).data("guestpw");

            console.log("-------------------");
            console.log(mno);
            console.log(content);
            console.log(guestpw);
            console.log("-------------------");

            // 모달에 데이터 설정
            $("#messageContent").text(content);

            // 수정, 삭제 버튼에 게시글 번호 설정
            $("#editBtn").data("mno", mno);
            $("#editBtn").data("guestpw", guestpw);
            $("#editBtn").data("content", content);
            $("#deleteBtn").data("mno", mno);
            $("#deleteBtn").data("guestpw", guestpw);

            // 모달 표시
            $("#actionModal").modal("show");

            // 수정 버튼 클릭 시 동작
            $("#editBtn").click(function() { // (3) 수정 버튼 클릭 이벤트 함수 시작
                var mno = $(this).data("mno");    // 게시물 번호
                var guestpw = $(this).data("guestpw");    // 비밀번호
                var content = $(this).data("content"); // 기존 내용

                console.log("게시글 번호: " + mno);
                console.log("게시글 비밀번호: " + guestpw);

                // 비밀번호 확인 모달 띄우기
                $("#actionModal").modal("hide"); // 원래 모달 숨기기
                $("#passwordModal").modal("show"); // 비밀번호 모달 띄우기
                
				
                
                $("#submitPasswordBtn").off("click").on("click", function() { // (4) 비밀번호 확인 버튼 클릭 이벤트 함수 시작
                    var enteredPassword = $("#passwordInput").val(); // 입력된 비밀번호

                    console.log(enteredPassword);
                    console.log(guestpw);

                    // DB에서 guestpw 값을 가져오는 요청
                    $.ajax({
                        url: "/getGuestPwByMno",  // guestpw를 가져오는 URL
                        type: "GET",
                        data: { mno: mno, enteredPassword: enteredPassword },  // mno 전달
                        success: function(response) { // (5) AJAX 성공 콜백 함수 시작
                            var guestpwFromDb = response;  // 서버에서 가져온 guestpw 값
                            var guestpw = $(this).data("guestpw");
                            
                            console.log("DB에서 가져온 guestpw: " + guestpwFromDb);

                            // 비밀번호가 일치하는지 확인
                            if (enteredPassword === guestpwFromDb) { // (6) 비밀번호 일치 체크 시작
                                // 비밀번호가 맞으면 수정 폼을 띄움
                                $("#passwordModal").modal("hide"); // 비밀번호 모달 숨기기
                                $("#editBtn").modal("show"); 
                                
                                // 수정 가능한 텍스트 영역과 수정 완료 버튼 표시
                                $("#messageContent").html('<textarea id="contentInput" class="form-control" rows="5">' + content + '</textarea>');
                                $("#updateBtn").show(); // 수정 완료 버튼 표시
                                $("#contentInput").show(); // 수정 가능 textarea 표시

                                // 수정 완료 버튼 클릭 시 서버로 수정 요청
                                $("#updateBtn").off("click").on("click", function() { // (7) 수정 완료 버튼 클릭 이벤트 함수 시작
                                    var updatedContent = $("#contentInput").val(); // 수정된 내용 가져오기
                                    console.log("수정된 내용: " + updatedContent);

                                    // 수정된 내용 서버에 보내기
                                    $.ajax({
                                        url: "/invitation/modify", // 수정 요청 URL
                                        type: "POST",
                                        data: {
                                            mno: mno,               // 게시물 번호
                                            content: updatedContent  // 수정된 내용
                                        },
                                        success: function(response) { // (8) 수정 요청 성공 콜백 함수 시작
                                            if (response === "success") {
                                                alert("수정 완료!");
                                                location.reload(); // 페이지 새로 고침
                                            } else {
                                                alert("수정 실패!");
                                            }
                                        }, // (8) 수정 요청 성공 콜백 함수 끝
                                        error: function(xhr, status, error) { // (9) 수정 요청 실패 콜백 함수 시작
                                            console.log("AJAX 요청 실패: " + error);
                                        } // (9) 수정 요청 실패 콜백 함수 끝
                                    });
                                }); // (7) 수정 완료 버튼 클릭 이벤트 함수 끝
                            } else { // (6) 비밀번호 일치 체크 끝
                                // 비밀번호가 틀리면 에러 메시지 표시
                                $("#error-message").show();
                            }
                        }, // (5) AJAX 성공 콜백 함수 끝
                        error: function(xhr, status, error) { // (10) AJAX 실패 콜백 함수 시작
                            console.log("guestpw 요청 실패: " + error);
                        } // (10) AJAX 실패 콜백 함수 끝
                    });
                }); // (4) 비밀번호 확인 버튼 클릭 이벤트 함수 끝
            }); // (3) 수정 버튼 클릭 이벤트 함수 끝

            // 삭제 버튼 클릭 시 동작
            $("#deleteBtn").click(function() { // (11) 삭제 버튼 클릭 이벤트 함수 시작
                var mno = $(this).data("mno");
                var guestpw = $(this).data("guestpw");

                console.log(mno);
                console.log(guestpw);

                // 비밀번호 확인 모달 띄우기
                $("#actionModal").modal("hide"); // 원래 모달 숨기기
                $("#passwordModal").modal("show"); // 비밀번호 모달 띄우기

                // 비밀번호 확인 버튼 클릭 시
                $("#submitPasswordBtn").off("click").on("click", function() { // (12) 비밀번호 확인 버튼 클릭 이벤트 함수 시작
                    var enteredPassword = $("#passwordInput").val(); // 입력된 비밀번호

                    console.log(enteredPassword);
                    console.log(guestpw);

                    // 비밀번호가 일치하는지 확인
                    if (enteredPassword == guestpw) { // (13) 비밀번호 일치 체크 시작
                        // 비밀번호가 맞으면 삭제 요청
                        $.ajax({
                            url: "/invitation/remove",
                            type: "POST",
                            data: {
                                mno: mno,
                                enteredPassword: enteredPassword
                            },
                            success: function(response) { // (14) 삭제 요청 성공 콜백 함수 시작
                                if (response === "success") {
                                    alert("게시글이 삭제되었습니다.");
                                    location.reload(); // 페이지 새로 고침
                                } else {
                                    alert("삭제에 실패했습니다.");
                                }
                            }, // (14) 삭제 요청 성공 콜백 함수 끝
                            error: function(xhr, status, error) { // (15) 삭제 요청 실패 콜백 함수 시작
                                console.log("삭제 요청 실패: " + error);
                            } // (15) 삭제 요청 실패 콜백 함수 끝
                        });
                    } else { // (13) 비밀번호 일치 체크 끝
                        // 비밀번호가 틀리면 에러 메시지 표시
                        $("#error-message").show();
                    }
                }); // (12) 비밀번호 확인 버튼 클릭 이벤트 함수 끝
            }); // (11) 삭제 버튼 클릭 이벤트 함수 끝

            // 목록으로 버튼 클릭 시
            $("#listBtn").click(function() { // (16) 목록으로 버튼 클릭 이벤트 함수 시작
                window.location.href = "/invitation/list"; // 게시글 목록 페이지로 이동
            }); // (16) 목록으로 버튼 클릭 이벤트 함수 끝
        }); // (2) .content-link 클릭 이벤트 함수 끝

        // "작성하기" 버튼 클릭 시
        $("#regBtn").click(function() { // (17) 작성하기 버튼 클릭 이벤트 함수 시작
            window.location.href = "/invitation/register"; // 작성 페이지로 이동
        }); // (17) 작성하기 버튼 클릭 이벤트 함수 끝

    }); // (1) $(document).ready 함수 끝
</script>

</body>
</html>
