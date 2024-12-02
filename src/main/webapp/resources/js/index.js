$(function(){

	//account toggle
    $('.menu>li').click(function(){

      $('.sub').stop().slideUp();

      $(this).find('.sub').stop().slideToggle();

    });

	//fadeln 슬라이드
    let i = 0;

    function slide() {
        i++;

        if (i > $('.slide li:last').index()) {
            i = 0;
        }

        $('.slide li').eq(i).stop().fadeIn('slow', 'linear');  // 느리게 나타남
        $('.slide li').eq(i-1).stop().fadeOut(500, 'swing');    // 500ms 동안 부드럽게 사라짐
    }

    setInterval(slide, 3500);
    
      //a 태그 페이지 이동 막기
      $(".brideLink").on("click", function(event) {
      event.preventDefault();     
   	  });
   	  
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
                
                // 비밀번호 모달 초기화: 기존 값 초기화
                $("#passwordInput").val("");  // 비밀번호 입력 필드 초기화
                //$("#error-message").hide();   // 오류 메시지 숨기기

                $("#actionModal").modal("hide"); // 비밀번호 모달 띄우기

                $("#passwordModal").modal("show"); // 비밀번호 모달 띄우기
        
                
                $("#submitPasswordBtn").off("click").on("click", function() { // (4) 비밀번호 확인 버튼 클릭 이벤트 함수 시작
                    var enteredPassword = $("#passwordInput").val(); // 입력된 비밀번호

                    console.log(enteredPassword);
                    console.log(guestpw);

                    // DB에서 guestpw 값을 가져오는 요청
                    $.ajax({
                        url: "/invitation/getGuestPwByMno",  // guestpw를 가져오는 URL
                        type: "GET",
                        data: { mno: mno, enteredPassword: enteredPassword },  // mno 전달
                        success: function(response) { // (5) AJAX 성공 콜백 함수 시작
                            var guestpwFromDb = response;  // 서버에서 가져온 guestpw 값
                            var guestpw = $(this).data("guestpw");
                            
                            console.log("DB에서 가져온 guestpw: " + guestpwFromDb);

                            // 비밀번호가 일치하는지 확인
                            if (enteredPassword === guestpwFromDb) { // (6) 비밀번호 일치 체크 시작
                                // 비밀번호가 맞으면 수정 폼을 띄움
                                
                                console.log("-------");
                                
                                $("#passwordModal").modal("hide"); // 비밀번호 모달 숨기기
                                console.log("-------");
                                
                                $("#editModal").modal("show"); 
                                
                                // 수정 가능한 텍스트 영역과 수정 완료 버튼 표시
                                $("#messageContent").html('<textarea id="contentInput" class="form-control" rows="5">' + content + '</textarea>');
                                $("#updateBtn").show(); // 수정 완료 버튼 표시
                                $("#contentInput").show(); // 수정 가능 textarea 표시

                                // 수정 완료 버튼 클릭 시 서버로 수정 요청
                                $("#updateBtn").off("click").on("click", function() { // (7) 수정 완료 버튼 클릭 이벤트 함수 시작
                                   
                                   var updatedContent = $("#contentInput").val(); // 수정된 내용 가져오기
                                    var enteredPassword = $("#passwordInput").val(); // 비밀번호 가져오기
                                    //var mno = 15;
                                   console.log("-------");
                                   
                                    console.log("수정된 내용: " + updatedContent + mno);

                                    // 수정된 내용 서버에 보내기
                                    $.ajax({
                                        url: "/invitation/modify", // 수정 요청 URL
                                        type: "POST",
                                        
                                        data: ({
                                            mno: mno,  // 게시물 번호
                                            content: updatedContent,  // 수정된 내용
                                            guestpw: enteredPassword  // 입력한 비밀번호
                                        }),
                                        success: function(result) {
                                           console.log("response"+result);
                                           // (8) 수정 요청 성공 콜백 함수 시작
                                            if (result === "success") {
                                                alert("수정 완료!");
                                                location.reload(); // 페이지 새로 고침
                                            } else {
                                               
                                                alert("수정 실패!");
                                                location.reload();
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
            
            
            let actionForm = $("#actionForm");
            $(".paginate_button a").on("click", function(e){
               e.preventDefault();
               actionForm.find("input[name='pageNum']").val($(this).attr("href"));
               actionForm.submit();
            });
            
            let searchForm = $("#searchForm");
            $("#searchForm button").on("click", function(e){
               if(!searchForm.find("option:selected").val()){
                  alert("검색 종류를 선택하세요");
                  return false;
               }

               if(!searchForm.find("input[name='keyword']").val()){
                  alert("키워드를 입력하세요");
                  return false;
               }
               
               searchForm.find("input[name='pageNum']").val("1");   //검색은 항상 1페이지부터 시작
               e.preventDefault();
               searchForm.submit();
            })
            

            // 삭제 버튼 클릭 시 동작
            $("#deleteBtn").click(function() { // (11) 삭제 버튼 클릭 이벤트 함수 시작
                var mno = $(this).data("mno");
                var guestpw = $(this).data("guestpw");

                console.log(mno);
                console.log(guestpw);

             // 비밀번호 모달 초기화: 기존 값 초기화
                $("#passwordInput").val("");  // 비밀번호 입력 필드 초기화
                $("#error-message").hide();   // 오류 메시지 숨기기

                $("#actionModal").modal("hide"); // 비밀번호 모달 띄우기

             // 비밀번호 모달에 게시물 번호와 비밀번호 전달
                $("#hiddenMno").val(mno); // 숨겨진 게시물 번호 필드에 값 설정
                $("#hiddenGuestPw").val(guestpw); // 숨겨진 비밀번호 필드에 값 설정

                
                
                
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
        
        // "청첩장화면 돌아가기" 버튼 클릭 시
        $("#mainbutton").click(function() { // (18) 작성하기 버튼 클릭 이벤트 함수 시작
            window.location.href = "/invitation/wedding"; // 작성 페이지로 이동
        }); // (18) 작성하기 버튼 클릭 이벤트 함수 끝
   	 
    
});
