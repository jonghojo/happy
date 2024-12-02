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
         <button id="regBtn" type="button">작성하기</button>
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
                  <button class="comment">댓글</button>
               </div>
            </div>
         </div>
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
            <!-- <p><a href="/invitation/customLogin">소중한 추억으로 간직하겠습니다.</a></p> -->
            <div class="a_btn">
            <button id="adminbutton" type="button">
            	소중한 추억으로 간직하겠습니다.
            </button>
         </div>
              
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
                     <div>
                        <button class="btn btn-primary" id="editBtn" data-mno="${message.mno}" data-guestpw="${message.guestpw}">수정</button>
                        <button id="deleteBtn" class="btn btn-danger">삭제</button>
                        <button id="listBtn" class="btn btn-secondary">목록으로</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- 모달창 끝 -->
            
</div>

</body>
</html>
