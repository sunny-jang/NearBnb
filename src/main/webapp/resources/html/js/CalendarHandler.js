/* jshint esversion: 6 */
class CalendarHandler {
	constructor(arr = []) {
		this.cDate = new PlaceDate;
	}

	// 예약가능날짜와 모든 예약정보 리스트 생성
	async getFullEvents(oDate, cDate, pId) {
		var today = new Date();
		var dateRange = today.getFullYear() + '-'+ (today.getMonth()+1);
		console.log(dateRange)
		var events_ = await this.getEventList(pId, dateRange);
		events_.unshift(
			{
	          title: '예약 가능 날짜',
	          start: oDate,
	          end: cDate,
	        }
		)
		return events_;
	}
	
	// pId를 파라미터로 받아 모든 예약정보 리스트 조회
	async getEventList(pId, dateRange) {
		var eList = await fetch('bookList.do?pId='+pId+'&dateRange=' +dateRange).then(res=>res.json());
		
		console.log(eList);
		var result = eList.map((item,i)=> {
			return {
				id: 'bookId-'+i,
				title: decodeURIComponent(item.title).replaceAll('+',' '),
				start: item.start.substring(0,10),
				end: item.end.substring(0,10),
				color: 'red',
			}
		})
		
		return result;
	}
	
	// 이미 예약된 날짜와 중복되는지 체크
	checkDupEvent(newEvent, events) {
		// 예약기간 구함
		var dateDiff = this.cDate.getDateDiff(newEvent.start, newEvent.end);
		
		//날짜 데이터를 스트링으로 변환
		var argS = this.cDate.getDateFormat(newEvent.start);
		var argE = this.cDate.getDateFormat(newEvent.end);
		
		//예약된 날짜들 Array로 생성
		let eventArray =  this.getBookedDates(events);
		
		//기간을 입력받아 예약된 날짜가 포함되어있는지 체크 
		let isBooked = this.isBookedDate(argS, argE, eventArray);
		if(isBooked) {
			return true;
		}
		
		return false;
	}
	// 예약가능 날짜 사이에 있는지 여부
	isAvailable(newEvent, oDate, cDate) {
		var argS = this.cDate.getDateFormat(newEvent.start);
		var argE = this.cDate.getDateFormat(newEvent.end);
		if(oDate <= argS && cDate >= argE) {
			return true;
		}else {
			alert("예약 가능 날짜 안에서 선택해주세요.");
			return false;
		}
	}
	// 이벤트 추가
	addEvent(calendar, newEvent) {
		//날짜 데이터를 스트링으로 변환
		var argS = this.cDate.getDateFormat(newEvent.start);
		var argE = this.cDate.getDateFormat(newEvent.end);
		var diffDate = this.cDate.getDateDiff(newEvent.start, newEvent.end);
		
		calendar.addEvent(newEvent);
	    calendar.unselect();
	   	return {argS: argS, argE: argE, diffDate:diffDate};
	};
	
	// 예약된 날짜들 배열로 생성
	getBookedDates (events) {
		let eventArray = [];
		
		for(let i = 1;i<events.length;i++) {
			const es = new Date(events[i].start);
			const ee = new Date(events[i].end);
			const diffDate = this.cDate.getDateDiff(es, ee);
			
			for(let j=0;j<diffDate;j++) {
				const es = new Date(events[i].start);
				eventArray.push(new Date(es.setDate(es.getDate()+j)));
			};
		}
		return eventArray;
	}
	
	// 선택된 날짜가 예약된 기간 내 있는지 체크
	isBookedDate(argS, argE, eventArray) {
		var eventArray = eventArray ? eventArray : [];
		var argE_ = this.cDate.addDays(new Date(argE),-1);
		
		for(let i=0; i<eventArray.length; i++) {
			if(argS == this.cDate.getDateFormat(eventArray[i]) || argE_ == this.cDate.getDateFormat(eventArray[i])) {
				alert("예약할 수 없는 날짜입니다. 다시 선택해주세요.");
				return true;
			}
		}
		return false;
	}
}