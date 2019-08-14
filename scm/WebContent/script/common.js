String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

function OMO(event) {
		//mozila里面 event 是以匿名参数形式传递的,在调用的时候给过来的参数
		if(event.srcElement){ //如果为ie浏览器，返回一个元素
			event = window.event;
			if (event.srcElement.tagName == "IMG")
	        event.srcElement.parentElement.className="T";
	  	else
	        event.srcElement.className="T";
		}else{ //mozila 浏览器
			var trg = event.target;
				if (trg.tagName == "IMG")
	        trg.parentNode.className="T";//mozila返回的是一个节点
	  	else
	        trg.className="T";
		}
		
}

function OMOU(event) {
		if(event.srcElement){ //如果没有参数，为ie浏览器
			event = window.event;
			if (event.srcElement.tagName == "IMG")
	        event.srcElement.parentElement.className="T";
	  	else
	        event.srcElement.className="P";
		}else{ //mozila
			var trg = event.target;
				if (trg.tagName == "IMG")
	        trg.parentNode.className="T";
	  	else
	        trg.className="P";
		}
}
//需要传递event参数过来
function OMO1(event) {
		if(event.srcElement){ //如果没有参数，为ie浏览器
	    	event.srcElement.style.cursor="hand";
		}else{ //mozila
			var trg = event.target;
	        trg.style.cursor="hand";
		}
}

function openWindow(URL, Name, Width, Height) {
	window.open(URL, Name, "width=" + Width + ",height=" + Height +
				",left=" + (window.screen.width - Width)/2 +
				",top=" + (window.screen.height - Height)/2 +
				",resizable=no,scrollbars=yes,toolbar=no,location=no," +
				"directories=no,status=no,menubar=no");	
}