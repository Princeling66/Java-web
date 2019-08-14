// Title: COOLjsOutlookBarPRO FOR INTERNAL USE ON JAVASCRIPT.COOLDEV.COM
// YOU MAY NOT USE THIS SCRIPT
// URL: http://javascript.cooldev.com/scripts/outlookpro/
// Version: 1.0.1.internal
// Last Modify: 05 Feb 2003
// Notes: Registration needed to use this script on your web site.
// Author: Helena Nikitina
// Copyright (c) 2003 by CoolDev.Com
panel_obj=[];it_obj=[];arr_dn=[];arr_up=[];
var check_click=0;var show_n=-1;var down_p=1;
var clip_var=0;var clip_var1=0;var count_panel=0;var plus=0;
var widthscreen=0;var last_visible=0;y2=0;y_mov=0;no_pan=0;perez=0;

var bw=new Browser();//创建浏览器对象,如下
//左侧的滚动栏,这里的id 实际上是所谓的数组，在folders.js 文件里面定义
function COOLjsOutlookBar(id){ 
	this.id=id; 
	this.name=id; 
	this.init=function(){  
		height_panel=this.id.format.heightpanel; //一个面板的高度
		height_img=this.id.format.imageheight;//图像高度
		width_img=this.id.format.imagewidth; //图片的宽度
		height_cell=this.id.format.heightcell; //一个单元格的高度
		height_arr=this.id.format.arrowheight; // 箭头高度
		color_outlook=this.id.format.coloroutlook; //外观的颜色
		rollback_allowed=this.id.format.rollback;
		textclass_item_def=this.id.format.textCSS_item;  //文本的css样式
		arrows=[]; //箭头
		panel_bar=[]; //面板
		arrows[0]=this.id.format.img_arrows_up;   //向上的箭头
		arrows[1]=this.id.format.img_arrows_dn;   //向下的箭头
		arrange=this.id.format.arrange_text;   //文本对齐方式
		this.kol_count=this.id.panels.length; //面板的个数
		for(l=0;l<this.kol_count;l++){
			Items(0,height_panel*l+l,l);//设置每个面板的项
		}  
		sho(0); //显示第0个的面板
	}; 
	
	this.init();
}

//px:x坐标,py：y坐标，pn:序号
function Items(px,py,pn){ 
	len_item=OutlookBar.panels[pn].items.length; //item项的数目
	text_pan=OutlookBar.panels[pn].text; //text文本
	class_pan=OutlookBar.panels[pn].panelCSS;//面板css 
	textclass_pan=OutlookBar.panels[pn].textCSS; //文本css
	arrangement=(arrange=="top"||arrange=="bottom")?"center":(arrange=="left")?"left":"right"; //文本对齐凡是
	panel=!bw.ns4? '<table id='+"pan"+pn+' width="100%" cellpading=0 cellspacing=0 class='+class_pan+' align=center height='+height_panel+' onclick="sho('+pn+')" onmousedown="change_stpan_md(this.id)" onmouseup="change_stpan_mout(this.id)" onmouseout="change_stpan_mout(this.id)">'+'<tr><td align=center>'+'<a onclick="this.blur()" href="#" class='+textclass_pan+' target="_self">'+text_pan+'</a></td></tr></table>': '<table width="100%" border="1" class='+class_pan+' align=center height='+height_panel+'>'+'<tr><td align=center><a onclick="this.blur()" target="_self" href="javascript:'+'sho('+pn+')"><font class='+textclass_pan+'>'+text_pan+'</font></a></tr></td></table>';
	//绘制面板的html代码
	objimg=[];objank=[];it=[]; 
	//设置每个item的属性
	for (i=0;i<len_item;i++){ 
		name_img='it'+pn+i; //某个item的图标
		name_aimg='ita'+pn+i; //鼠标移过的图标
		var item = OutlookBar.panels[pn].items[i]; 
		textclass_item = item.textCSS||textclass_item_def; //text css
		img_class=item.classCSS; //item的图片css
		img_item=item.image;  //item的图片
		url_item=item.url; //item 链接
		text_item=item.text; //item文本
		arrange_item=(arrange=="left")?"left":(arrange=="right")?"absmiddle":''; //对齐方式
		text_arrange_bl=(arrange=="left"||arrange=="bottom")?(bw.ie||bw.ns6)?(arrange!="bottom")?'<br />'+text_item:text_item:text_item:''; 
		text_arrange_tr=(arrange=="right"||arrange=="top")?(arrange!="top")?text_item:text_item+'<br />':''; objimg[i]=bw.ns4?   '<span><a onclick="this.blur()"  href="'+url_item+'" class='+textclass_item+' onmouseover="change_style_ns('+name_img+',\''+img_item+'\')" onmouseout="change_style_ns1('+name_img+',\''+img_item+'\')" name='+name_aimg+' id='+name_aimg+'>'+text_arrange_tr+'<img border="0" src="'+img_item+'" name='+name_img+' id='+name_img+' align='+arrange_item+' hspace=3 vspace=10 height='+height_img+' width='+width_img+'><br />'+text_arrange_bl+'</a></span>':   bw.operaOld?  '<a onclick="this.blur()" href="'+url_item+'" class='+textclass_item+'>'+text_arrange_tr+'&nbsp;<img border="0" src="'+img_item+'" class='+img_class+' name="'+name_img+'" id="'+name_img+'" onmouseover=change_style_opmd("'+name_img+'","'+img_item+'") onmouseout=change_style_opmout("'+name_img+'","'+img_item+'") onmousedown=change_style_opmd("'+name_img+'","'+img_item+'") onmouseup=change_style_opmout("'+name_img+'","'+img_item+'") align='+arrange_item+' hspace=0 vspace=0 height='+height_img+' width='+width_img+'><br />'+text_arrange_bl+'</a>':   '<a onclick="this.blur()" href="'+url_item+'" class='+textclass_item+' onmouseover=change_style_md("'+name_img+'","'+img_item+'") onmouseout=change_style_mout("'+name_img+'","'+img_item+'") onmousedown=change_style_md("'+name_img+'","'+img_item+'") onmouseup=change_style_mout("'+name_img+'","'+img_item+'")>'+text_arrange_tr+'&nbsp;<img border="0" src="'+img_item+'" class='+img_class+' name="'+name_img+'" id="'+name_img+'" align='+arrange_item+' hspace=1 vspace=8 height='+height_img+' width='+width_img+'><br />'+text_arrange_bl+'</a>'; it[i]='<table width="100%" align='+arrangement+' border=0 cellpading=0 cellspacing=0><tr><td align='+arrangement+' valign=top>'+objimg[i]+'</td></tr></table>'; 
	}  
		//每一个面板 向下箭头名
		var name_ard="arrdn"+pn;  
		var name_aru="arrup"+pn;  //每一个面板 向上箭头名
		arrow_dn=bw.ns4?'<a onclick="this.blur()" href="javascript:show_last('+pn+')" target="_self"><img border="0" src="'+arrows[1]+'" name="arrdn" id="arrdn" height='+height_arr+'></a>':   '<a onclick="this.blur()" href="#" target="_self" onmousedown=chang_arrd("'+name_ard+'") onmouseup=chang_arru("'+name_ard+'")><img border="0" src="'+arrows[1]+'" name="'+name_ard+'" id="'+name_ard+'" onclick="show_last('+pn+');" height='+height_arr+'></a>'; arrow_up=bw.ns4?'<a onclick="this.blur()" href="javascript:show_prev('+pn+')" target="_self"><img border="0" src="'+arrows[0]+'" name="arrup" id="arrup" height='+height_arr+'></a>':   '<a onclick="this.blur()" href="#" target="_self"><img border="0" onmousedown=chang_arrd("'+name_aru+'") onmouseup=chang_arru("'+name_aru+'") src="'+arrows[0]+'" name="'+name_aru+'" id="'+name_aru+'" onclick="show_prev('+pn+')" height='+height_arr+'></a>'; 
		panel_obj[pn]=new DHTMLObject('p_o'+pn); 
		panel_obj[pn].draw(px,py,height_panel,color_outlook,1,3,class_pan,panel); 
		panel_obj[pn].init();
		//属性
	  it_obj[pn]=[]; 
		ppy=py+height_panel+pn; 
	//绘制item
		for (i=0;i<len_item;i++){ 
			img_class=OutlookBar.panels[pn].items[i].classCSS; 
			it_obj[pn][i]=new DHTMLObject('it_o'+pn+i);  
			it_obj[pn][i].draw(px,ppy,height_cell,color_outlook,0,1,'',it[i]); 
			it_obj[pn][i].init(); 
			ppy+=height_cell+6; 
	} 
	//设置按钮的
		arr_dn[pn]=new DHTMLObject('arr_obj_dn'+pn); 
		arr_dn[pn].draw(px,py+height_cell,height_arr,color_outlook,0,1,'',arrow_dn); 
		arr_dn[pn].init(); 
		arr_up[pn]=new DHTMLObject('arrup'+pn); 
		arr_up[pn].draw(px,py,height_arr,color_outlook,0,1,'',arrow_up);
		arr_up[pn].init(); 
		count_panel++;
}

function sho(ppn){ 
	var razmer=new ScreenSize(); 
	var myheight=razmer.height; 
	var mywidth=razmer.width; 
	
	check_click=rollback_allowed?(check_click>0&&show_n==ppn)?0:1:1; 
	if ( check_click==1){ 
		if(show_n!=-1) arr_dn[show_n].hide(); 
		for(ii=ppn;ii>=0;ii--){  
			u=(ii==0)?0:ii;  
			panel_obj[ii].slide(panel_obj[ii].x,u*height_panel+ii,200,10,1);  
			pp_y=u*height_panel+height_panel+6;  
			for (k=0;k<it_obj[ii].length;k++){  
				it_obj[ii][k].slide(it_obj[ii][k].x,pp_y,500, 1,1);  
				pp_y+=height_cell;  
			}  
		} 
		nextppn=ppn+1; 
		down_p=nextppn;  
		yy=height_panel+1;  
		kol_mov_p=count_panel-ppn-1; 
		no_pan=ppn; counter=1; 
		for(i=count_panel-1;i>=nextppn;i--){  
			ypan=myheight-height_panel*counter-counter;  
			panel_obj[i].slide(panel_obj[i].x,ypan,200,10,1);  
			counter++;  plus+=3; 
		} 
		if(nextppn<count_panel)   
			y2=ypan; 
		else{  
			hscreen=new ScreenSize();  
			y2=hscreen.height; 
		} 
		if(show_n!=-1) 
			for(i=0;i<it_obj[show_n].length;i++) 
				it_obj[show_n][i].hide();
			for(i=0;i<it_obj[ppn].length;i++){  
				it_obj[ppn][i].show();  
				clip_var=(it_obj[ppn][i].y+height_cell)<=y2?0:i;
			}if(clip_var!=0){  
				arr_dn[ppn].slide(mywidth-height_arr-4,y2-height_arr-4,1000,1000,1);   
				arr_dn[ppn].show();  
			} else   
				arr_dn[ppn].hide();  
				if(show_n!=-1) arr_up[show_n].hide(); 
		}else{ 
			for(i=0;i<it_obj[ppn].length;i++) 
				it_obj[ppn][i].hide(); 
			for(kk=ppn;kk<count_panel;kk++){  
				if(kk<=count_panel){  
					u=kk;  panel_obj[kk].slide(panel_obj[kk].x,u*height_panel+kk, 200,10,1); 
		 } 
	  } arr_dn[ppn].hide();  arr_up[ppn].hide();  
	 } 
	 show_n=ppn; opend_visible=0;
}

function show_last(porn){ 
	var razmer=new ScreenSize(); 
	var myheight=razmer.height; var mywidth=razmer.width; 
	for(i=0;i<it_obj[porn].length;i++){ 
		y_obj=it_obj[porn][i].y; y_up=y_obj-height_cell; 
		it_obj[porn][i].slide(it_obj[porn][i].x ,y_up-2,height_panel,100, 1); 
		it_obj[porn][i].show(); yyy=it_obj[porn][i].y+height_cell-height_panel; 
		if(yyy<=y2&&it_obj[porn][i].y<=panel_obj[porn].y+height_cell){  
			arr_up[porn].slide(mywidth-height_arr-4,panel_obj[porn].y+height_panel+3,200,1,1);   
			arr_up[porn].show();  
		} 
		last=it_obj[porn].length-1; 
		if(it_obj[porn][last].y+height_cell-height_panel*2<=y2)arr_dn[porn].hide();  
	}
}

function show_prev(porn){ 
	var razmer=new ScreenSize(); 
	var myheight=razmer.height; 
	var mywidth=razmer.width; first=it_obj[porn].length; 
	for(i=it_obj[porn].length-1;i>=0;i--){ 
		y_obj=it_obj[porn][i].y; y_up=y_obj+height_cell; 
		it_obj[porn][i].slide(it_obj[porn][i].x,y_up+2, height_panel,100,1); 
		it_obj[porn][i].show(); 
		if(it_obj[porn][i].y+height_cell>panel_obj[porn].y){  
			if((it_obj[porn][i].y+height_cell+height_panel*2)>y2){  
				arr_up[porn].slide(mywidth-height_arr-4,panel_obj[porn].y+height_panel+3,200,1,1);   
				arr_up[porn].show();   arr_dn[porn].slide(mywidth-height_arr-4,y2-height_arr-3,10,200,1,1);  
				arr_dn[porn].show();   
		}  
		if(it_obj[porn][0].y+height_cell-height_panel>panel_obj[porn].y) 
		arr_up[porn].hide();  
		} 
	}
}

function cs(id,css){var obj=new DHTMLObject(id);obj.init();obj.el.className=css;}

function ci(id,src,over){var obj=new DHTMLObject(id);obj.init();var npic=new Image();var prestr=src.substring(0,src.indexOf(".gif"));npic.src=prestr+(over?'_a':'')+'.gif';obj.el.src=npic.src;} 

function ci_ns(idd,imsrc,over){pos=imsrc.indexOf(".gif");prestr=imsrc.substring(0,pos);this.npic=new Image();this.npic.src=prestr+(over?'_a':'')+".gif";idd.src=this.npic.src;} 

function change_stpan_md(idd){cs(idd,'panel_click')}

function change_stpan_mout(idd){cs(idd,'panel')}

function change_style_md(idd){cs(idd,'imgstyle_over')} 

function change_style_mout(idd){cs(idd,'imgstyle')} 

function change_style_opmd(idd,idsrc){ci(idd,idsrc,1)} 

function change_style_opmout(idd,idsrc){ci(idd,idsrc,0)} 

function change_style_ns(idd,imsrc){ci_ns(idd,imgsrc,1)} 

function change_style_ns1(idd,imsrc){ci_ns(idd,imgsrc,0)} 

function chang_arrd(idd){cs(idd,'arrowclick')} 

function chang_arru(idd){cs(idd,'arrow')} 

function ScreenSize(){ 
	//拿到窗口的大小
	this.width=(bw.ie&&document.body.offsetWidth)||window.innerWidth||0; 
	this.height=(bw.ie&&document.body.offsetHeight)||window.innerHeight||0; 
	return this;
}

function opend_thefirst(){sho(0);}

function checkResize() {  //移动的时候 要重画
	if (bw.ie4 || bw.ie5 || bw.ie6 || bw.ie7 || bw.ns6 ||bw.ns4||bw.opera) { 
		prev_pan=down_p-1; 
		var ssize=new ScreenSize(); 
		main_height=ssize.height; 
		main_width=ssize.width; 
		y_nextpan=down_p>(count_panel-1)?main_height:panel_obj[down_p].y; 
		y_pan=panel_obj[prev_pan].y+10; 
		if(check_click==1){  
			 if(old_height!=main_height||old_width!=main_width){  
			 	for(i=down_p;i<=count_panel;i++){   
			 		if(down_p<=(count_panel-1)&&i!=count_panel){    
			 			razn_h=Math.abs(old_height-panel_obj[i].y);   
			 			if(bw.opera)     panel_obj[i].move(0,main_height-razn_h);   
			 			else     panel_obj[i].slide(0,main_height-razn_h,1000,1,1);   
			 		}    
			 		for(jj=0;jj<it_obj[prev_pan].length;jj++){    
			 			last_visible=0;    
			 			if(bw.opera){     
			 				it_obj[prev_pan][jj].move(0,it_obj[prev_pan][jj].y);   
			 				if((it_obj[prev_pan][0].y+height_cell-height_panel)<=panel_obj[prev_pan].y+height_panel)     
			 					arr_up[prev_pan].show();    
			 				else     
			 					arr_up[prev_pan].hide();   
			 		}     
			 		it_obj[prev_pan][jj].show();    
			 		y_nextpan=down_p>(count_panel-1)?y_nextpan=main_height:panel_obj[down_p].y;    
			 		y_it=it_obj[prev_pan][jj].y+height_cell;    
			 		if(bw.opera) arr_dn[prev_pan].move(main_width-height_arr-4,y_nextpan-height_arr-3);    
			 		if((it_obj[prev_pan][jj].y+height_cell-height_panel)<y_nextpan){    
			 			if((it_obj[prev_pan][jj].y+height_cell)>(panel_obj[prev_pan].y+height_panel)){      
			 				last_visible=jj;     
			 				if_v=0;     
			 				}    
			 			}else    
			 				if_v=jj;   
			 		}   
			 		y2=y_nextpan;   
			 		if((last_visible+1)==it_obj[prev_pan].length)    
			 		arr_dn[prev_pan].hide();   
			 		else    
			 			arr_dn[prev_pan].show();  
			 			}  
			 	} 
		} 
		y2=down_p>(count_panel-1)?y2=main_height:panel_obj[down_p].y; 
		if(bw.opera){   
			arr_dn[prev_pan].move(main_width-height_arr-4,y2-height_arr-3);  
			arr_up[prev_pan].move(main_width-height_arr-4,panel_obj[prev_pan].y+10+height_arr+3); 
		}else{  
			arr_dn[prev_pan].slide(main_width-height_arr-4,y2-height_arr-3,1000,1,1);  
			arr_up[prev_pan].slide(main_width-height_arr-4,panel_obj[prev_pan].y+10+height_arr+3,1000,1,1); 
	  } 
  } 
	old_height=main_height; 
	if(bw.operaOld) 
		if (window.reloading) return; 
		if(window.operaResizeTimer)  
			clearTimeout(window.operaResizeTimer); 
		if (new Browser().operaOld)  
		window.operaResizeTimer=setTimeout('checkResize()',1000);
}

//窗口装载过程
function winLoad() { 
	var ssize=new ScreenSize(); 
	old_height=ssize.height; 
	old_width=ssize.width; 
	main_height=old_height; 
	widthscreen=ssize.width; 
	if(bw.operaOld){  
		var nsize=new ScreenSize(); 
		new_height=nsize.height; 
		new_width=nsize.height; 
		checkResize(); 
	}
}
//判断 设置当前的浏览器
function Browser(){
	this.ver=navigator.appVersion;//判断客户端浏览器类型和版本
	this.agent=navigator.userAgent;//获取从客户端向服务器发送的HTTP协议用户代理头的值 如ie 或mozila
	this.dom=document.getElementById?1:0;//是否支持getElementById
	this.opera5=this.agent.indexOf("Opera 5")>-1;//是否支持opera5
	this.ie5=(this.ver.indexOf("MSIE 5")>-1 && this.dom && !this.opera5)?1:0;
	this.ie6=(this.ver.indexOf("MSIE 6")>-1 && this.dom && !this.opera5)?1:0;
	this.ie7=(this.ver.indexOf("MSIE 7")>-1 && this.dom && !this.opera5)?1:0;
	this.ie4=(document.all && !this.dom && !this.opera5)?1:0;
	this.ie=this.ie4||this.ie5||this.ie6||this.ie7;
	this.mac=this.agent.indexOf("Mac")>-1;
	this.ns6=(this.dom && parseInt(this.ver) >= 5) ?1:0;
	this.ns4=(document.layers && !this.dom)?1:0;
	this.bw=(this.ie7||this.ie6||this.ie5||this.ie4||this.ns4||this.ns6||this.opera5);
	this.opera7=((this.agent.toLowerCase().indexOf('opera 7')>-1) || (this.agent.toLowerCase().indexOf('opera/7')>-1));this.opera=window.opera?1:0;
	this.operaOld=this.opera&&!this.opera7;
	return this
};



function DHTMLObject(id){  
	this.id=id;
	if(!bw.bw) return; 
	this.name='DHTMLObject_'+this.id; 
	this.init=function(ns4p){
		this.el=bw.dom?document.getElementById(this.id):bw.ie4?document.all[this.id]:bw.ns4?eval((ns4p?nsp4:'')+"document.layers."+this.id):0;
		if(!this.el) return alert('Error: '+this.id+' layer not found!');
		this.css=bw.dom||bw.ie4?this.el.style:this.el;
		this.doc=bw.dom||bw.ie4?document:this.css.document;
		this.x=parseInt(this.css.left)||this.css.pixelLeft||this.el.offsetLeft||0;
		this.y=parseInt(this.css.top)||this.css.pixelTop||this.el.offsetTop||0;
		this.w=this.el.offsetWidth||this.css.clip.width||this.doc.width||this.css.pixelWidth||0;
		this.h=this.el.offsetHeight||this.css.clip.height||this.doc.height||this.css.pixelHeight||0;
	}; 
	this.move = function(x,y){
		this.css.left=this.x=x;this.css.top=this.y=y
	}; 
	this.moveBy = function(x,y){
		this.css.left=this.x+=x;this.css.top=this.y+=y
	}; 
	this.show = function(){
		this.css.visibility="visible";
	}; 
	this.hide = function(){
		this.css.visibility="hidden";
	}; 
	this.slide = function(toX,toY,step,speed,execDone){
		if(!this.inWay){
			var newX=toX-this.x;var newY=toY-this.y;
			var num=Math.sqrt(Math.pow(newX,2)+Math.pow(newY,2))/step;
			var stepX=newX/num;var stepY=newY/num;this.inWay=1;
			this.slideInt(stepX,stepY,toX,toY,speed,execDone);
		}
	};
	this.slideInt = function(stepX,stepY,toX,toY,speed,execDone){
		function fabs(v){
			return Math.floor(Math.abs(v))
		};
		if(this.inWay&&(fabs(stepX)<fabs(toX-this.x)||fabs(stepY)<fabs(toY-this.y))){
			this.moveBy(stepX,stepY);
			setTimeout("DHTMLObject_"+this.id+".slideInt("+stepX+","+stepY+","+toX+","+toY+","+speed+",'"+execDone+"')",speed);
		}else{
			this.inWay = 0;this.move(toX,toY);if(execDone)eval(execDone);
		}
	}; 
	eval(this.name+'=this'); 
	return this;
}
DHTMLObject.prototype.draw=function(x,y,h,bg,v,z,css,code){
	if(bw.ns4){
		if(this.id.indexOf("p_o")>-1) 
			document.write(bw.ns4?'<layer id="'+this.id+'" z-index='+z+' left='+x+' width="100%" top='+y+' height='+h+(!v?' visibility=hidden':'')+(bg!=""?' bgcolor="'+bg+'"':'')+'>'+code+'</layer>':'<div id="'+this.id+'" style="position:absolute;z-index:'+z+';left:'+x+'px;top:'+y+'px;'+'px;height:'+h+'px;'+(!v?'visibility:hidden;':'')+(bg!=""?''+(bw.ns4?'layer-':'')+'background-color:'+bg+';':'')+'"'+(css!=''?' class="'+css+'"':'')+'>'+code+'</div>');
			else document.write(bw.ns4?'<layer id="'+this.id+'" z-index='+z+' left='+x+' width="100%" top='+y+' height='+h+(!v?' visibility=hidden':'')+(bg!=""?' bgcolor="'+bg+'"':'')+(css!=''?' class="'+css+'"':'')+'>'+code+'</layer>':'<div id="'+this.id+'" style="position:absolute;z-index:'+z+';left:'+x+'px;top:'+y+'px;'+'px;height:'+h+'px;'+(!v?'visibility:hidden;':'')+(bg!=""?''+(bw.ns4?'layer-':'')+'background-color:'+bg+';':'')+'"'+(css!=''?' class="'+css+'"':'')+'>'+code+'</div>');
	}else 
		document.write('<div id="'+this.id+'" style="position:absolute;z-index:'+z+';left:'+x+'px;top:'+y+'px;height:'+h+'px;'+(!v?'visibility:hidden;':'')+(bg!=""?''+(bw.ns4?'layer-':'')+'background-color:'+bg+';':'')+'"'+(css!=''?' class="'+css+'"':'')+'>'+code+'</div>');
}
