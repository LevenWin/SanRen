define(function(require,exports){
	//require('/static/css/course_note.css');
	require("/static/lib/dot/1.0.0/doT.js");
	var tpl=require("/static/template/note-list.tpl");
	var page=require("/static/component/base/util/paging.js");
	// 图片全屏预览模块
    var picViewer = require('/static/component/base/util/picViewer');
	var settings,
		pageRander,
		$itemContainer,
		$pageContainer,
		myExports;
	//console.log(tplDef)

	/*
	options:
	{
		container:"selector",
		onBeforeLoad:"function",
		onLoaded:"function",
		params:{server params},
		def:{doT template def},
		onFinish:"function" //fired after render the content
	}*/

	function note(options){
		if(myExports) return myExports;
		var $ctn=$(options.container);
		settings=options;
		settings.params||(settings.params={});
		($itemContainer=$("<div id='course_note' class='course_note'></div>")).appendTo($ctn);
		($pageContainer=$("<div class='page note-list-page'></div>")).appendTo($ctn);


		tpl=doT.template(tpl,null,settings.def||tplDef);

		pageRander=page.setup({
			container:$pageContainer,
			delegate:'.note-list-page a',
			pageClick:function(e){
			var newSort=$(".js-all-state .active").attr("data-sort");
			var newOwer=$(".js-course-menu").attr("data-ower");
				load($(this).attr("data-page"),newSort,newOwer)
			}
		});

		//笔记js
		$("#course_note").delegate(".js-toggle-notelist","mouseenter",function(){
	        if(!$(this).hasClass("hover")){
	            $(this).addClass("hover");
	            $(this).find('.slider-door').animate({
					margin: 0
				}, 300);
	        }
	    }).delegate(".js-toggle-notelist","mouseleave",function(){
	        if($(this).hasClass("hover")){
	            $(this).removeClass("hover");
	            $(this).find('.catch-pic').animate({
					marginLeft: '-50%'
				}, 300);
				$(this).find('.catch-video').animate({
					marginRight: '-50%'
				}, 300);
	        }
	    }).delegate('.js-catch-pic','click',function(e) {
	    	if($(this).hasClass('js-catch-pic')){
	    		var picSrc = $(this).closest('.js-toggle-notelist').find('img').data('src');
				picViewer.create(picSrc);
	    	}
	    })

		$(document).off("click.shownotecode").on("click.shownotecode",".js-show-node-code",function(){
			var id=$(this).attr("data-id");
			require.async('./view_code',function(ViewCode){
				ViewCode.init('/course/viewnotecode',id,{})
			});
		});

		$(document).on("click",".Jpraise",function(e){
			e.preventDefault();
			var $this=$(this),
				f,id;
			if (!OP_CONFIG.userInfo) {
			    require.async('login_sns',function(login) {
	                login.init();
	            });
				return
		    }
			f=$this.hasClass("on");
			id=$this.attr("data-id");
			$.ajax({
				url:"/course/"+(f?"cancelpraise":"praisenote"),
				data:{
					id:id,
					mid:pageInfo.mid
				},

				dataType:"json",
				success:function(data){
					if(data.result==0){
						var num =+$this.text();
						$this.find("em").text(num+(f? -1:1));
						//$this.removeClass('J_PraiseNum');
						$this[f?"removeClass":"addClass"]('on').attr(f?"取消赞":"赞");
						$this.find('span')[f?"removeClass":"addClass"]('on praise-anim');
					}
				},
				error:function(){

				}
			});
		});

		$(document).on("click",".Jcollect",function(e){
			e.preventDefault();
			var $this=$(this),ids;
			if($this.hasClass("on")) return ;
			if (!OP_CONFIG.userInfo) {
			    require.async('login_sns',function(login) {
	                login.init();
	            });
				return
		    }


		    ids=$this.attr("data-id").split("|");
		    if(OP_CONFIG.userInfo&&OP_CONFIG.userInfo.uid==ids[1]){
		    	alert("亲亲\""+(OP_CONFIG.userInfo.nickname||"")+"\"，别采集自己的笔记哟~！");
		    	return ;
		    }
		    $.ajax({
		    	url:"/course/collectnote",
		    	data:{
		    		id:ids[0],
		    		mid:pageInfo.mid
		    	},
				dataType:"json",
				success:function (data){
					if(data.result==0){
						var $em = $this.find("em");
						$em.text(+$em.text()+1);
						$this.find("i").text('已采集');
						$this.addClass('on').attr('title', '已采集').find("span").addClass('on icon-star-revert praise-anim');
					}
				}

		    });
		})

		//tab new
		var owerEle=settings.params.ower||$(".js-course-menu");
		var sortEle=settings.params.sort||$(".js-course-menu").attr("data-sort");
		$itemContainer.before("<div class='course-tool-bar clearfix js-select-state'>\
			<div class='tool-left l js-all-state'>\
		        <a href='javascript:;' class='sort-item active' data-sort='last'>最新</a>\
		        <a href='javascript:;' class='sort-item' data-sort='sugg'>点赞</a>\
	        </div>\
	        <div class='tool-right r'>\
		        <span class='tool-item'>\
		        	<a href='javascript:;' class='js-ower hide-learned tool-chk' data-sort='"+sortEle+"'>只看我的</a>\
		        </span>\
		    </div>\
		</div>");
		
		$(document).on("click",".js-all-state a",function(e){

			e.preventDefault();
			var $this = $(this),
				cls = "active";
			if($this.hasClass(cls)) {
				return ;
			}
			$this.siblings("."+cls).removeClass(cls).end().addClass(cls);

			load(1,owerEle.attr("data-ower"),$this.attr("data-sort"));
		});

		$(document).on("click",".js-ower",function(e){

			e.preventDefault();
			var $this = $(this),
				cls = "checked";
			var newSort=$(".js-all-state .active").attr("data-sort");
			if($this.hasClass(cls)) {
				$this.removeClass(cls);
			}else{
				$this.addClass(cls);
			}

			if(owerEle.attr("data-ower")=="all"){
				owerEle.attr("data-ower","my");
			}else{
				owerEle.attr("data-ower","all");
			}
			load(1,owerEle.attr("data-ower"),newSort);
		})

		return myExports={
			load:function(page,ower,sort){
				load(+page);
			}
		}
	}
	// this hook
	//
	function loaded(data){
		if(data.page_total==0&&(!data.list||!data.list.length)){
			$itemContainer.html("<div class='unnote'><span class='icon-note'></span><p>此节暂无同学记录过笔记</p></div>");
			$(".note-list-page").empty();
			return false;
		}
	}

	function load(page,ower,sort){
		var data=$.extend({},settings.params);

		data.page=page||1;
		data.r=Math.random();
		data.ower=ower;
		data.sort=sort;
		$.ajax({
			url:"/course/mynote",
			dataType:"json",
			data:data,
			success:function(data){
				if(data.result===0){
					data=data.data;
					//console.log(tpl(data))
					//data.list=[];
					//data.page_total=0;
					if(loaded(data)===false) return;
					$(data.list).each(function(index,obj){
						data.list[index].content=(obj.content.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g,"$1<br>$2"));
					})
					$itemContainer.html(tpl(data));
					//$(".js-course-menu")
					pageRander(+data.page_current,+data.page_total);
				}


			},
			error:function(){
				//alert(" 服务器错误，稍后重试");
			}
		})
	}

	return note;
});
