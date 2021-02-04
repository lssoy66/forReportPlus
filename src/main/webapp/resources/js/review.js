console.log("reviewService Module...");

var reviewService = (function(){
	
	/**  list에서 사용하기 위해 댓글수, 평균 별점만 가져오기 */
	function getTotalAndAvgRate(pronum, callback, error){
		
		console.log("리스트에서 보여주기 위한 댓글, 별점 가져오기");
		console.log(pronum);
		
		$.getJSON("/review/forList/" + pronum ,
				function(data){
					if(callback){
						callback(data.reviewTotal, data.avgRate);
					}
				}). fail(function(xhr, status, err){
					if(error){
						error(err);
					}
				})
	}
	
	/** 리뷰 전체 가져오기 */
	function getReviewList(param, callback, error){
		
		var pronum = param.pronum;
		var pageNum = param.pageNum || 1;
		
		$.getJSON("/review/get/pronum/" + pronum +"/"+pageNum+".json",
			function(data){ // data -> 성공했을때 서버에서 날라오는 데이터
				if(callback){
					callback(data.reviewTotal, data.reviewList, data.avgRate, data.reviewCriteria, data.rateOne, data.rateTwo, data.rateThree, data.rateFour, data.rateFive);
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});			
	}
	
	
	
	/** 리뷰 시간 처리하기 */
	function displayTime(timeValue){
		
		var today = new Date();
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		// 리뷰 작성 후 24시간이 안 지난 경우
		if(gap < (1000 * 60 * 60 * 24)){
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			// []: 배열
			// join(): 배열의 원소들을 연결하여 하나의 값으로 만든다.
			return [(hh > 9 ? '':'0')+hh, ':', (mi>9?'':'0')+mi, ':', (ss>9?'':'0')+ss].join('');
		} else {
			
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; // getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '':'0')+mm, '/', (dd > 9 ? '':'0')+dd].join('');			
		}
	}
	
		
	/** 리뷰 등록하기 */
	function add(review, header, token, callback, error){
		
		console.log("리뷰 등록하기");
		
		$.ajax({
			type: 'post',
			url: '/review/new',
			beforeSend : function(xhr)
            {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다 -> null체크 필수*/
				if(token && header){
					xhr.setRequestHeader(header, token);
				}
				
            },
			data: JSON.stringify(review), // 서버로 데이터를 전송할 때 사용하는 옵션
			contentType: "application/json; charset=utf-8", // 서버로 데이터 전송할 때 보네는 content-type 헤더 값
			success: function(result, status, xhr){
				if(callback){
					// ==> if(callback)의 경우 callback은 false에 해당하지 않기 때문에 참이다.
					// 그래서 서버로부터 값을 받아오는게 성공할 경우 if(callback)을 처리하고 callback은 참이기 때문에
					// 처리가 진행된다.
					
					callback(result);
				}
			},
			error: function(xhr, stauts, er){
				if(error){
					error(er)
				}
			}
		})
	}
	
	/** 리뷰 삭제하기 -> 시큐리티 토큰 추가*/
	function remove(reviewNum, header, token, callback, error){
		
		console.log("js.header: " + header);
		console.log("js.token: " + token);
		
		console.log("리뷰 삭제하기");
		console.log(typeof(reviewNum));
		console.log("reviewNum: " + reviewNum);
					
		$.ajax({
			type: 'delete',
			url: '/review/delete/' + reviewNum,
			beforeSend : function(xhr)
            {   
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다 -> null체크 필수*/
				if(token && header){
					xhr.setRequestHeader(header, token);
				}
				
            },
			data: JSON.stringify(reviewNum), // 서버로 데이터를 전송할 때 사용하는 옵션
			contentType: "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					console.log("안녕");
					callback(result);
				}
			}, error: function(xhr, stauts, er){
				if(error){
					console.log("실패");
					error(er);
				}
			}
		}) /** ajax 끝 */
	}
	
	
	return {
		getReviewList : getReviewList, // 리스트 전체 얻기
		displayTime : displayTime, // 시간 표현
		add : add, // 댓글 추가
		remove : remove, // 댓글 삭제
		getTotalAndAvgRate : getTotalAndAvgRate // 리스트용 댓글 개수 + 별점
	};
	
})();