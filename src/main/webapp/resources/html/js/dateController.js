class PlaceDate {
	constructor(arr = []) {}

	// 오픈일 선택시
	setOpenDate(e) {
		var openDate = new Date(e.value);
		// min 날짜를 설정
		this.setMinDate(openDate);
		// 마감일 보다 큰 날짜를 선택했는지 체크
		this.checkOverDate(openDate);
	}
	
	// 마감일 보다 큰 날짜를 선택했는지 체크
	checkOverDate(date) {
		var openDate = date;
		var closeDate = new Date($("input[name=placeCloseDate]").val())
		
		if(closeDate <= openDate) {
			alert("마감 날짜보다 클 수는 없습니다. 다시 선택해주세요.");
			
			$("input[name=placeOpenDate]").val(this.getDateFormat(new Date()));
		}
	}
	
	// min 날짜를 설정
	setMinDate(date) {
		var date_ = new Date();
			date_.setDate(date.getDate()+1)
		var nextDate = this.getDateFormat(date_)
		
		$("input[name=placeCloseDate]").attr("min", nextDate);
	}
	
	// 숫자형 날짜 데이터를 포멧에 맞게 변환
	getDateFormat(date) {
		var yyyy_mm_dd;
		
		var year = date.getFullYear();
		var month = ("0" + (1 + date.getMonth())).slice(-2);
		var day = ("0" + date.getDate()).slice(-2);
		
		yyyy_mm_dd = year + "-" + month + "-" + day;
		
		return yyyy_mm_dd;
	}
	
	getDateDiff(start, end) {
    	var dateDiff = Math.ceil((end.getTime()- start.getTime())/(1000*3600*24));
    	
    	return dateDiff;
	}

}