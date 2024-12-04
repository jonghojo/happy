<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"></script>

   <!-- css -->
   <link rel="stylesheet" href="/resources/css/list.css"> 
 

   <!-- js -->
   <script src="/resources/js/index.js"></script>
   
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   
</head>
<body>
<div id="wrap">
   <h2 id="list_title">축하메세지를 적어주세요~</h2>
   
   
      <div class="r_btn">
          <sec:authorize access="isAuthenticated()">
              <a href="/customLogout" class="Logout_B">로그아웃</a>
          </sec:authorize>
          <sec:authorize access="!isAuthenticated()">
              <button id="regBtn" type="button" >작성하기</button>
          </sec:authorize>
      </div>

      <c:forEach items="${list}" var="message">
         <div class="card_m">

            <div class="card_tr">
               <div class="card_head">
                  <p class="writer">
                     <c:out value="${message.writer}" />
                  </p>
                  <p class="date">
                     <fmt:formatDate pattern="yyyy-MM-dd" value="${message.regdate }" />
                  </p>
               </div>
               <div class="card_body">
                  <p class="card_text">
                     <a href='#' class="content-link" data-mno="${message.mno}"
                        data-content="${message.content}"
                        data-guestpw="${message.guestpw}"><c:out
                           value="${message.content}" /></a>
                  </p>
               </div>
            <div class="card_footer">
                  <sec:authorize access="isAuthenticated()">
                   <div style="text-align: right;">
                       <button type="button" class="comment" id="addcommentsBtn">답글 작성</button>
                   </div>
               </sec:authorize>
               </div>
            </div>
         </div>
         <ul id="comments-${message.mno}" class="comments-list"></ul>
      </c:forEach>
   

         <!-- 페이지 버튼 클릭시 동작 -->
         <form id="actionForm" action="/invitation/list" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.viewlist.pageNum}"> 
            <input type="hidden" name="amount" value="${pageMaker.viewlist.amount}"> 
            <input type="hidden" name="type" value="${pageMaker.viewlist.type}">
            <input type="hidden" name="keyword" value="${pageMaker.viewlist.keyword}">
         </form>


         <!-- 페이징 처리 시작 -->
         <nav aria-label="...">
            <ul class="pagination">

               <!-- 이전 페이지 버튼 -->
               <c:if test="${not empty pageMaker and pageMaker.prev}">
                  <li class="page-item paginate_button">
                  <a class="page-link" href="?page=${pageMaker.startPage - 1}">Previous</a></li>
               </c:if>

               <!-- 페이지 번호 -->
                  
               
                  <c:if test="${not empty pageMaker}">
                     <!-- startPage와 endPage가 없을 경우 기본값 설정 -->
                     <c:if
                        test="${pageMaker.startPage == null or pageMaker.endPage == null}">
                        <c:set var="pageMaker.startPage" value="1" />
                        <c:set var="pageMaker.endPage" value="1" />
                     </c:if>
   
                     <!-- startPage가 음수일 경우 1로 설정 -->
                     <c:if test="${pageMaker.startPage lt 1}">
                        <c:set var="pageMaker.startPage" value="1" />
                     </c:if>
   
                     <!-- endPage가 startPage보다 작을 경우 startPage로 설정 -->
                     <c:if test="${pageMaker.endPage lt pageMaker.startPage}">
                        <c:set var="pageMaker.endPage" value="${pageMaker.startPage}" />
                     </c:if>
                  

                     <!-- 페이지 번호가 표시될 범위 설정 -->
                     <c:forEach begin="${pageMaker.startPage}"
                        end="${pageMaker.endPage}" var="num">
                        <li class="page-item paginate_button ${pageMaker.viewlist.pageNum == num ? 'active' : ''}" >
                        <a href="?page=${num}">${num}</a></li>
                     </c:forEach>
                  </c:if>
               

               <!-- 다음 페이지 버튼 -->
               <c:if test="${not empty pageMaker and pageMaker.next}">
                  <li class="page-item paginate_button">
                  <a class="page-link" href="?page=${pageMaker.endPage + 1}">Next</a></li>
               </c:if>

            </ul>
         </nav>
         
         <!-- 페이징 처리 끝 -->

         <!-- 검색 조건 시작 -->
         <div class="row">
            
               <form action="/invitation/list" method="get" id="searchForm">
                  <select name="type" class="search_W">
                     <option value="CW" ${pageMaker.viewlist.type eq 'TCW' ? 'selected' : '' }>검색하기</option>

                     <option value="C" ${pageMaker.viewlist.type eq 'C' ? 'selected' : '' }>내용</option>
                     <option value="W" ${pageMaker.viewlist.type eq 'W' ? 'selected' : '' }>작성자</option>


                     <%-- <option value="CW" ${pageMaker.viewlist.type eq 'TCW' ? 'selected' : '' }>내용 or 작성자</option> --%> 
                  </select> 
                  <div class="search-box"> 
                     <input class="search-txt" type="text" name="keyword" value="${pageMaker.viewlist.keyword}"> 
                     <input type="hidden" name="pageNum" value="${pageMaker.viewlist.pageNum}"> 
                     <input type="hidden" name="amount" value="${pageMaker.viewlist.amount}">
                     <button class="search-btn" type="submit">
                  <i class="fas fa-search"></i>                  
                     </button>
                  </div>               
               </form>
            
         </div>
         <!-- 검색 조건 끝 -->


         <div class="m_btn">
            <button id="mainbutton" type="button">청첩장 화면 돌아가기</button>
         </div>
         
         <footer>
            <p><a href="/customLogin">소중한 추억으로 간직하겠습니다.</a></p>
              
         </footer>

         <!-- 수정 모달 (수정 버튼 클릭 후 표시) -->
         <div id="editModal" class="modal" tabindex="-1">
            <div class="modal-dialog">
               <div class="modal-content wit">
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
                     <button type="button" class="btn btn-secondary"
                        data-bs-dismiss="modal">취소</button>
                     <button type="button" class="btn btn-primary" id="updateBtn"
                        data-mno="${message.mno}">수정 완료</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- 수정 모달 끝 -->

         <!-- 비밀번호 모달 -->
         <div id="passwordModal" class="modal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content wit">
                  <div class="modal-header">
                     <h5 class="modal-title">비밀번호 입력</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                     <label for="passwordInput">비밀번호를 입력해주세요:</label> 
                     <input type="password" id="passwordInput" class="form-control" placeholder="비밀번호">
                     
                     <div class="text-danger" id="error-message"
                        style="display: none;">비밀번호가 일치하지 않습니다.</div>
               
                  <!-- 게시물 번호와 비밀번호를 숨겨서 전달 -->
                       <input type="hidden" id="hiddenMno">
                       <input type="hidden" id="hiddenGuestPw">
                  
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary"
                        data-bs-dismiss="modal">취소</button>
                     <button type="button" class="btn btn-primary"
                        id="submitPasswordBtn">확인</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- 모달창 끝 -->



         <!-- 모달창 -->
         <div id="actionModal" class="modal" tabindex="-1">
            <div class="modal-dialog">
               <div class="modal-content wit">
                  <div class="modal-header">
                     <h5 class="modal-title">게시글 수정/삭제</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                     <p id="messageContent"></p>
                     <div style="text-align: center;">
                        <button class="btn btn-primary" id="editBtn" data-mno="${message.mno}" data-guestpw="${message.guestpw}">수정</button>
                        <button id="deleteBtn" class="btn btn-danger">삭제</button>
                        <button id="listBtn" class="btn btn-secondary">목록으로</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- 모달창 끝 -->
         
         <!-- 답글 관련 모달창 -->
   <!-- 답글 작성 모달 -->
   <div id="mymodal" class="modal" tabindex="-1">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <h5 class="modal-title">답글 남기기</h5>
         </div>
         <div class="modal-body">
         <div class="form-group">
            <label>답글내용</label>
            <input class="form-control" name="Comments" value="New Comments!!">
         </div>
         <div class="form-group">
            <label>신랑*신부이름</label>
            <input class="form-control" name="Writer" value="New Writer!!" >
         </div>
         <div class="form-group">
            <label>답글 날짜</label>
            <input class="form-control" name="Comments Date" id="commentDate" value="" readonly>
         </div>
         </div>
         <div class="modal-footer">
            <sec:authorize access="isAuthenticated()">
              <button type="button" class="btn btn-primary" id="modalModBtn">수정하기</button>
              <button type="button" class="btn btn-danger" id="modalRemoveBtn">삭제하기</button>
           </sec:authorize>
              <button type="button" class="btn btn-info" id="modalRegisterBtn">등록하기</button>
              <button type="button" class="btn btn-default" id="modalCloseBtn" data-bs-dismiss="modal">닫기</button>
         </div>
       </div>
     </div>
   </div>
            
</div>

<script src="/resources/js/comments.js"></script>



<script>

/* comments */
$(document).ready(function(){
   
   // 페이지 로드 시 각 게시물에 대해 댓글을 자동으로 로드
   $(".card_m").each(function() {
        let mnoValue = $(this).find(".content-link").data("mno");  // 게시물의 mno 값 가져오기
        console.log("mnoValue:", mnoValue);  // 확인
        showList(mnoValue);  // 해당 mno에 맞는 댓글 로드 함수 호출
    });
   
   // 댓글 로드 함수
   function showList(mnoValue) {
      let commentsUL = $("#comments-" + mnoValue); // 특정 mno에 해당하는 UL 선택
      console.log("commentsUL: ", commentsUL);
      commentsUL.empty();
      
       // 댓글 데이터를 서버에서 가져오는 부분 (예시)
        commentsService.getList({ mno: mnoValue }, function(data) {
           console.log("댓글 데이터: ", data);
           if (data && data.length > 0) {
                // 댓글 데이터가 성공적으로 로드되면, 댓글을 표시
                data.forEach(function(comment) {
                    let str = "<li class='left clearfix' data-cno='" + comment.cno + "'>";
                    str += "<div class='header' style='display: flex; flex-direction: column;'>";
                    str += "<strong class='primary-font'>" + comment.commenter + "</strong>";  // 작성자
                    str += "</div>";
                    str += "<p>" + comment.c_content + "</p>";  // 댓글 내용
                    str += "</li>";
                    commentsUL.append(str);  // 댓글 항목을 UL에 추가
                });
            } 
        }, function(error) {
            console.error("댓글 가져오기 실패:", error);
        });
    }
   
    let modal = $("#mymodal");
    let modalInputComment = modal.find("input[name='Comments']");
    let modalInputCommenter = modal.find("input[name='Writer']");
    
    let modalRegisterBtn = $("#modalRegisterBtn");
    let modalModBtn = $("#modalModBtn");
    let modalRemoveBtn = $("#modalRemoveBtn");

    var commenter = $("#commenter").val();  // 서버에서 넘겨받은 commenter 값

   <sec:authorize access="isAuthenticated()">
      commenter = '<sec:authentication property="principal.username"/>';
   </sec:authorize>
   
   
   
    // new comment 팝업창
    $("body").on("click", "#addcommentsBtn", function () {
       var mno = $(this).closest('.card_m').find('.content-link').data("mno");
        console.log("게시글 번호(mno):", mno);// 게시글 번호 가져오기
        
        $("#mymodal").data("mno", mno);
        
        
        $("#mymodal").modal("show"); // 모달 열기
        function decodeHtmlEntity(str) {
           var doc = new DOMParser().parseFromString(str, 'text/html');
           return doc.documentElement.textContent || doc.body.textContent;
       }
        
       // commenter 값을 디코딩해서 설정
        let decodedCommenter = decodeHtmlEntity(commenter);

        modal.find("input").val(""); // 입력 필드 초기화
       // 작성자 설정
         modal.find("input[name='Writer']").val(decodedCommenter);
        modal.find("button[id!='modalCloseBtn']").hide();  // 수정, 삭제 버튼 숨기기
        modalRegisterBtn.show();  // 등록 버튼 표시

       
   });
    

    // 댓글 등록
    modalRegisterBtn.on("click", function () {
       
       var mnoValue = $('#mymodal').data('mno');
        console.log("MNO:", mnoValue);
       
        let comments = {
           c_content: modalInputComment.val(),
           commenter: modalInputCommenter.val(),
            mno: mnoValue,
            c_date: new Date() // 현재 날짜와 시간을 댓글 작성 날짜로 설정
        };
        
        console.log("댓글 내용:", comments);

        commentsService.add(comments, function (result) {
            alert("답글이 등록되었습니다.");

            modal.find("input").val("");
            modal.modal("hide");
            
            let mnoValue = $('#mymodal').data('mno');
            console.log("댓글 추가 후 mnoValue:", mnoValue);  // mnoValue 확인

            showList(mnoValue);
        });
    });
    
    // 수정 및 삭제 시작
   // 답글 클릭 시 모달 창 표시
   $(".comments-list").on("click", "li", function() {
    let cno = $(this).data("cno");  // 클릭된 댓글의 cno
    var mno = $(this).closest('.card').find('.content-link').data("mno");
    let c_date = $(this).data("c_date");
    
    console.log("mno : " + mno);
    console.log("cno : " + cno);
    
    // 댓글 데이터를 가져오는 부분
    commentsService.get(cno, function(comment) {
        modal.find("input[name='Comments']").val(comment.c_content);
        modal.find("input[name='Writer']").val(comment.commenter);
        modal.find("input[name='cno']").val(comment.cno);  // cno도 모달에 담기
        
        // c_date를 Date 객체로 변환하고 포맷
        let formattedDate = new Date(comment.c_date).toLocaleDateString('ko-KR', {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
        });
        
        // 마지막 점(.) 제거
        if (formattedDate.endsWith('.')) {
            formattedDate = formattedDate.slice(0, -1); // 마지막 문자 제거
        }
        
        // Comments Date 입력 필드에 날짜 설정
        modal.find("input[name='Comments Date']").val(formattedDate); // 포맷된 날짜를 모달에 담기
        
        modal.data("cno", comment.cno);  // cno 데이터를 모달에 저장
        modal.data("mno", mno);  // mno도 모달에 저장
        
        console.log("mno : " + mno);
        console.log("cno : " + cno);
        console.log("c_date : " + formattedDate); // 포맷된 날짜 출력
        
        // 수정, 삭제 버튼 보이기
        modalModBtn.show();
        modalRemoveBtn.show();
        modalRegisterBtn.hide();  // 등록 버튼 숨기기
        
        // 모달 열기
        modal.modal("show");
    }, function(error) {
        console.error("댓글 데이터 가져오기 실패:", error);
    });
});
   // 댓글 수정 처리
    modalModBtn.on("click", function() {
        let comments = {
            cno: modal.data("cno"),
            c_content: modalInputComment.val(),
            commenter: modalInputCommenter.val(),
            c_date:new Date()
        };
      
        if(!commenter){
          alert("로그인후 수정이 가능합니다.");
          return;
       }
        
        commentsService.update(comments, function(result) {
            alert("댓글이 수정되었습니다.");
            modal.find("input").val("");  // 입력 필드 초기화
            modal.modal("hide");

            var mnoValue = modal.data('mno');
            showList(mnoValue);  // 댓글 목록 갱신
        });
    });
   
    // 댓글 삭제 처리
    modalRemoveBtn.on("click", function(response) {
       let cno = modal.data("cno");  // 삭제할 댓글의 cno
       let commenter = modal.data("commenter");

        if (!cno) {
            alert("삭제할 댓글이 없습니다.");
            return;
        }
  /*       
        if(!admin_id){
          alert("로그인후 삭제가 가능합니다.");
          return;
       } */
        
        console.log("cno : "+cno);
        if (confirm("정말 삭제하시겠습니까?")) {
            commentsService.remove(cno, commenter,function(success) {
               console.log("----------");
                alert("댓글이 삭제되었습니다.");
                modal.modal("hide");
                
                var mnoValue = modal.data('mno');
                showList(mnoValue);  // 댓글 목록 갱신
            }, function(error) {
               console.log("-----"+cno)
               alert("댓글 삭제 실패")
               modal.modal("hide");
            });
        }
    });
    
    $("body").on("click", "#addcommentsBtn", function() {
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = (today.getMonth() + 1).toString().padStart(2, '0'); // 월을 2자리로 맞추기
        var dd = today.getDate().toString().padStart(2, '0'); // 일을 2자리로 맞추기
        var currentDate = yyyy + '-' + mm + '-' + dd; // yyyy-MM-dd 형식

        // 댓글 작성 모달의 날짜 필드에 현재 날짜 입력
        $("#commentDate").val(currentDate);
    });
});
</script>

</body>
</html>
