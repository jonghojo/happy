console.log("Reply Module.....");

let commentsService = (function(){
    
    function add(comments, callback, error) {
	
	    let commenter = comments.commenter || "Anonymous"; // 기본값 설정
	
	    comments.commenter = commenter; // commenter 설정
	    
	    $.ajax({
	        type: 'post',
	        url: '/comments/new',
	        data: JSON.stringify(comments),
	        contentType: "application/json; charset=utf-8",
	        success: function(result, status, xhr){
	            if(callback){
	                callback(result);
	            }
	        },
	        error: function(xhr, status, er){
	            if(error){
	                error(er);
	            }
	        }
	    });
	}

    
//getList start
    function getList(param, callback, error){
    
    	let mno = param.mno;
    	
    
        console.log("mno:", mno);  // mno 값 확인
    	

         $.ajax({
	        type: 'get',
	        url: "/comments/list/" + mno,  // 페이지 번호를 URL에 포함
	        success: function(data, status, xhr) {
			    console.log("data:", data);
				    if (Array.isArray(data)) {
				        callback(data);  // 데이터가 배열인 경우
				    } else if (data.list) {
				        callback(data.list);  // list 속성이 있는 객체인 경우
				    } else {
				        console.error("Unexpected data structure:", data);
				    }
			},
	        error: function(xhr, status, er){
	            if(error){
	                error(er);
	            }
	        }
	    });
    }
    // getList end

    //remove start
    function remove(cno, commenter, callback, error){   
        $.ajax({
            type: 'delete',
            url: '/comments/' + cno,
            data: JSON.stringify({cno : cno, commenter: commenter}),
            contentType: "application/json; charset=utf-8",
            success: function(response){
                if(callback) callback(response);
            },
            error: function(xhr, status,er){
               if (error){
                error(er);
                }
            }
        })
    }
    //remove end

    //update start
    function update(comments, callback, error){
	    if (!comments.commenter) {
	        return error("댓글 작성자가 없습니다.");
	    }
        $.ajax({
            type: 'put',
            url: "/comments/" + comments.cno,
            data: JSON.stringify(comments),
            contentType: "application/json; charset=utf-8",
            success: function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            error: function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    }
    //update end

    //get satrt
    function get(cno, callback, error){
        $.ajax({
            type: 'get',
            url: "/comments/detail/" + cno,
            success: function(commentsVO, status, xhr){
                if(callback){
                    callback(commentsVO);
                }
            },
            error: function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    }
    //get end
    
     return {
        add: add,
        getList: getList,
        remove: remove,
        update: update,
        get: get
    };
})();
