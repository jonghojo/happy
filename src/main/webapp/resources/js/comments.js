
let commentsService = (function(){
    
    function add(comments, callback, error){
        console.log("comments.....");

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
        })
    } // add end

    
//getList start
    function getList(mno, callback, error){
        console.log(mno);

        $.ajax({
            type: 'get',
            url: "/comments/" + mno,  // 
            success: function(data, status, xhr){
                console.log("data");
                if(callback){
                    callback(data);  // 전체 댓글 리스트만 반환
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
    function remove(cno, writer, callback, error){   
        $.ajax({
            type: 'delete',
            url: '/comments/' + cno,
            data: JSON.stringify({cno:cno, writer:writer}),
            contentType: "application/json; charset=utf-8",
            success: function(deleteReuslt, status, xhr){
                if(callback){
                    callback(deleteReuslt);
                }
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
            url: "/comments/" + cno,
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
});