define(function(require){function a(){OP_CONFIG.userInfo&&$.ajax({url:"/u/loading",dataType:"json",success:function(a){0==a.result&&(a.data.remind>0?$(".msg_remind").show():$(".msg_remind").hide())}})}function c(){h=$(window).height(),t=$(document).scrollTop(),t>=768?($("#backTop").show(),$("#js-elevator-weixin").removeClass("no-goto")):($("#backTop").hide(),$("#js-elevator-weixin").addClass("no-goto"))}require("jquery"),require("/static/component/base/util/string"),require("/static/moco/v1.0/dist/js/moco.min.js"),require("/static/component/logic/common/userinfo.js");var g=require("../../base/util/cookie.js"),v=require("/static/component/base/suggest/suggest"),b=require("store");require.async("chat",function(){$.chat.init()}),$(document).delegate(".js-closeBindHint","click",function(){g.set("bindHintNotShow","true",{expires:1}),$(".js-bindHintBox").hide()}),$("body").delegate(".js-refresh","click",function(){window.location.reload()}),$(function(){var a=$('[data-search="top-banner"]'),c=new v(a),h=$(".search-area"),g=$(".showhide-search"),b=$(".search-input"),k=function(){g.attr("data-show","yes"),h.show(1,function(){h.removeClass("min")})};$("#nav").on("click",".search-input",function(){$(".searchTags").hide()}),$("#nav").on("blur",".search-input",function(a){0==$(a.currentTarget).val().length&&$(".searchTags").show()}),$("#nav").on("click",".showhide-search",function(a){$(".searchTags").hide();var h=$(this).attr("data-show");return"no"==h?(k(),b.focus()):""==b.val()?y():c.search(b.val()),a.stopPropagation(),!1}),$("#nav").on("click",".search-area",function(a){return a.stopPropagation(),!1}),$(document).on("click",function(){""==b.val()&&y()});var y=function(){}}),$(function(){"code"==OP_CONFIG.page&&$("#J_GotoTop").hide(),a(),c(),$('[action-type="my_menu"],#nav_list').on("mouseenter",function(){$('[action-type="my_menu"]').addClass("hover"),$("#nav_list").show()}),$('[action-type="my_menu"],#nav_list').on("mouseleave",function(){$('[action-type="my_menu"]').removeClass("hover"),$("#nav_list").hide()}),$("#set_btn").click(function(){location.href="/space/course"}),$("#js-signin-btn").on("click",function(e){e.preventDefault(),require.async("../../logic/login/login-regist",function(a){a.init()})}),$("#js-signup-btn").on("click",function(e){e.preventDefault(),require.async("../../logic/login/login-regist",function(a){a.signup()})}),$("#nav-item a:eq(0)").click(function(){b.remove("lange_id"),b.remove("pos_id"),b.remove("tab_id"),b.remove("is_easy"),b.remove("sort")}),$("#backTop").click(function(){$("html,body").animate({scrollTop:0},200)}),$(window).scroll(function(){c()}),$(document).on("keydown",function(e){13==e.keyCode&&e.ctrlKey&&($(document).trigger("submit.imooc"),e.preventDefault())})}),!function(){var a,c,h;if(c=window.navigator.userAgent,h=/;\s*MSIE (\d+).*?;/.exec(c),h&&+h[1]<9){if(a=document.cookie.match(/(?:^|;)\s*ic=(\d)/),a&&a[1])return;$("body").prepend(["<div id='js-compatible' class='compatible-contianer'>","<p class='cpt-ct'><i></i>您的浏览器版本过低。为保证最佳学习体验，<a href='/static/html/browser.html'>请点此更新高版本浏览器</a></p>","<div class='cpt-handle'><a href='javascript:;' class='cpt-agin'>以后再说</a><a href='javascript:;' class='cpt-close'><i></i></a>","</div>"].join("")),$("#js-compatible .cpt-agin").click(function(){var d=new Date;d.setTime(d.getTime()+2592e6),document.cookie="ic=1; expires="+d.toGMTString()+"; path=/",$("#js-compatible").remove()}),$("#js-compatible .cpt-close").click(function(){$("#js-compatible").remove()})}}(),$(".js-show-menu").on("click",function(e){return $("html").addClass("holding"),$("body").addClass("slide-left"),$(".slide-left-opa")[0]||$("body").append('<div class="slide-left-opa" style="position: absolute; top: 0; right: 130px; left: 0;bottom: 0; background: rgba(0 ,0,0,0.3); z-index: 2000;"></div>'),document.getElementsByClassName("slide-left-opa")[0].addEventListener("touchstart",function(){return $("html").removeClass("holding"),$("body").removeClass("slide-left"),$(".slide-left-opa").remove(),!1},!1),e.stopPropagation(),!1}),$("body").on("click",".slide-left-opa",function(){$("html").removeClass("holding"),$("body").removeClass("slide-left"),$(".slide-left-opa").remove()}),!function(){$(document).on("click","[data-ast]",function(){$.get("/index/adclick",{ast:$(this).attr("data-ast"),r:(new Date).getTime()})}).on("click","[data-track]",function(){$.get("/index/clickuserlog",{track:$(this).attr("data-track"),r:(new Date).getTime()})})}()}),function(){var a={includejs:function(a){var s=document.createElement("script");s.type="text/javascript",s.src=a,document.getElementsByTagName("body")[0].appendChild(s)}};a.includejs("/visitlog/index/user?v="+(new Date).getTime()),a.includejs("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js")}();