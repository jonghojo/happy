console.log("Reply Module..........");

let replyService = (function(){

    //add start
    function add(reply, callback, error){
        console.log("reply.........");

        $.ajax({
            type: 'post',
            url: '/replies/new',
            data: JSON.stringify(reply), //js객체 -> json변환
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
    function getList(param, callback, error){
        console.log("js getList.........." );
        let bno = param.bno;
        let page = param.page || 1;

		console.log("------------------------");		
        console.log(bno, ", ", page);

        $.ajax({
            type: 'get',
            url: "/replies/pages/" + bno + "/" + page,
            success: function(data, status, xhr){
                if(callback){
                    callback(data.replyCnt, data.list);
                }
            },
            error: function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    }
    //getList end

    //remove start
    function remove(rno, replyer, callback, error){        
    	
    	console.log("remove-----------------");
    	console.log(rno);
    	console.log(replyer);
    	
    	
        $.ajax({
            type: 'delete',
            url: '/replies/' + rno,
            data: JSON.stringify({rno:rno, replyer:replyer}),
            contentType: "application/json; charset=utf-8",
            success: function(deleteReuslt, status, xhr){
                if(callback){
                    callback(deleteReuslt);
                }
            },
            error: function(xhr, status,er){
                error(er);
            }
        })
    }
    //remove end 

    //update start
    function update(reply, callback, error){
        $.ajax({
            type: 'put',
            url: '/replies/'+ reply.rno,
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function(result, status,xhr){
                if(callback){
                    callback(result);
                }
            },
            error: function(xhr, status,er){
                if(error){
                    error(er);
                }
            }
        });
    }
    //update end

    //get start
    function get(rno, callback, error){
        $.ajax({
            type: 'get',
            url: '/replies/' + rno,
            success: function(replyVO, status,xhr){
                if(callback){
                    callback(replyVO);
                }
            },
            error: function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    };
    //get end

    function displayTime(timeValue){

        let  today = new Date();
        let gap = today.getTime() - timeValue;

        let dateObj = new Date(timeValue);
        let str = "";

        if(gap < (1000 * 60*60*24)){
            let hh = dateObj.getHours();
            let mi = dateObj.getMinutes();
            let ss = dateObj.getSeconds();

            return [ (hh>9 ? '' : '0') +hh, ':', (mi>9? '' : '0') + mi , ':', (ss>9 ? '' : '0')+ss].join('');
        }else{
            let yy = dateObj.getFullYear();
            let mm = dateObj.getMonth()+1 ;  //1월 : 0, 2월:1 => 1월 : 0+1
            let dd = dateObj.getDate();

            return [ yy, '/' , ( mm > 9? '' : '0') + mm, '/', (dd>9 ? '' : '0') +dd ].join('');
        }

    } // end displayTime
    return {
        add: add,
        getList: getList,
        remove: remove,
        update: update,
        get: get,
        displayTime: displayTime
    };
})();