/*=============================================================================
#     FileName: course_note.js
#         Desc: 笔记模块
#       Author: panwf
#   LastUpdate: 2015-10-09 16:57:12
=============================================================================*/
define(function(require, exports, module) {

    require('common');

    //编辑框内光标
    $.fn.setCursorPosition = function(position) {
        if (this.lengh == 0) return this;
        return $(this).setSelection(position, position);
    }

    //把光标移到到最后
    $.fn.setSelection = function(selectionStart, selectionEnd) {
        if (this.lengh == 0) return this;
        input = this[0];
        if (input.createTextRange) {
            var range = input.createTextRange();
            range.collapse(true);
            range.moveEnd('character', selectionEnd);
            range.moveStart('character', selectionStart);
            range.select();
        } else if (input.setSelectionRange) {
            input.focus();
            input.setSelectionRange(selectionStart, selectionEnd);
        }
        return this;
    };

    $.fn.focusEnd = function() {
        this.setCursorPosition(this.val().length);
    };

    var countLength=function(){
        var len = $.trim($('#js-note-textarea-edit').val()).length;
            if(len > 1000) {
                $(this).addClass('space-fake-error');
                $('#js-note-limit').addClass('limit-overflow');
            }
            else{
                $(this).removeClass('space-fake-error');
                $('#js-note-limit').removeClass('limit-overflow');
            }
            $('#js-note-limit').text(len);
    }
    //绑定事件 编辑 保存 删除
    $(document).on('click','.editnote',
       function(e) {
            if(window.thePlayer && window.thePlayer.getState()!="PAUSED"&& window.thePlayer.getState()!="IDLE"){
                thePlayer.pause();
            }
           e.preventDefault();
            $('#js-note-input-edit').remove();
            $('.sava_btn').hide();
            $('.mynote').show();

            $('.editnote').show();
            $('.delnote').show();
            $('.editordel').hide();

            var hookTxt = $(this).closest('.js-find-txt');
            var oldhtml = hookTxt.find('textarea').val();

            $(this).hide().closest('.js-find-txt').find('.mynote').hide().after('<div class="space-note-input" id="js-note-input-edit">\
            <textarea placeholder="请输入笔记内容..." name="" class="js-placeholder" id="js-note-textarea-edit">' + oldhtml + '</textarea>\
            <p class="space-note-text-counter"><span id="js-note-limit">0</span>/1000</p>\
            </div>');
           countLength();

           //   <textarea class="edit-area"></textarea>
           hookTxt.find('textarea').focus().focusEnd();
           hookTxt.find('.sava_btn').show();


       });

    //第一次输入笔记字数限制显示
    $('#js-note-input-fake').on('keyup', '#js-note-textarea', function() {
        countLength();
    });
    
    //笔记框
    $(document).on({
        focusin: function() {
            $(this).addClass('space-fake-focus')
        },
        focusout: function() {
            $(this).removeClass('space-fake-focus');
        },
        keyup: function() {
            countLength();
        }
    },'#js-note-input-edit');

    $(document).on('click','.sava_btn',
        function(e) {
            e.preventDefault();

            var $this=$(this)
            if($this.hasClass("submit-loading")) return ;

            var findTxt = $this.closest('.js-find-txt');
            var noteId = findTxt.attr('noteId');//获取笔记id
            var courseId = findTxt.attr('courseId'); //获取课程id
            var newhtml = $.trim(findTxt.find('#js-note-textarea-edit').val());

            var coverlay='<div class="contain-coverLayer"></div>';

            if(!newhtml.length){
                layer.msg('请输入内容', 2, -1);
                return;
            }
            if(newhtml.length>0 && newhtml.length < 3){
                layer.msg('输入不能小于3个字符', 2, -1);
                return;
            }
            if(newhtml.length > 1000){
                layer.msg('输入不能超过1000个字', 2, -1);
                return;
            }

        var popsucc='<div id="js-pop-del" class="pop-deleting"><div class="deleting-bd"></div><div class="deleting-btm">笔记保存成功</div></div>';


          $this.addClass("submit-loading");
          $this.val("保存中...")
          $.ajax({
              url: "/u/"+OP_CONFIG.userInfo.uid+"/note/"+noteId,

              type: "post",
              data: {
                  course_id: courseId, //传递课程id
                  content: newhtml
              },
              dataType: "json",
              success: function(res) {
                $this.removeClass("submit-loading");
                  if(res.result==0){
                        $("body").append(popsucc).append(coverlay);
                        //layer.msg('保存成功',1,1);
                        $this.hide().closest('.js-find-txt').find('#js-note-input-edit').remove();
                        var str=$("<div>").text(newhtml).html().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g,"$1<br>$2");
                        $this.closest('.js-find-txt').find('.mynote p').html(str).parent(".mynote").show();
                        $this.closest('.js-find-txt').find('.editnote').show();
                        $this.closest('.js-find-txt').find('textarea').val(newhtml);
                        setTimeout(function(){
                            $("#js-pop-del").remove();
                            $(".contain-coverLayer").remove();
                        },1000);
                        $this.val("保存");

                        if(window.thePlayer && window.thePlayer.getState()=="PAUSED"){
                            thePlayer.play();
                        }
                  }
                  else {
                    var poperror=$(popsucc);
                        poperror.find(".deleting-bd").addClass("pop-error").end().find(".deleting-btm").html("笔记保存失败");
                        $("body").append(poperror);
                        setTimeout(function(){
                            $("#js-pop-del").remove();
                            $(".contain-coverLayer").remove();
                        },1000);

                        layer.msg('保存失败');

                        if(window.thePlayer && window.thePlayer.getState()=="PAUSED"){
                            thePlayer.play();
                        }
                    }

              },
              error:function() {
                $this.removeClass("submit-loading");
                $this.html("保存");
              }
          });

});
$(document).on('click', '.delnote',
     function(e) {
        if(window.thePlayer && window.thePlayer.getState()!="PAUSED"&& window.thePlayer.getState()!="IDLE"){
            thePlayer.pause();
        }
        e.preventDefault();
        var toRemove = $(this).closest('.js-find-txt');
        var noteId = $(this).closest('.js-find-txt').attr('noteId');
        var count = $(this).parents('.js-find-txt').find('.report').attr('data');
        var ajaxing=0;
        $.confirm("您确定删除这条笔记吗？",{
            info:'笔记删除将无法恢复',
            callback:function (){
                if(ajaxing){
                    return;
                }
                ajaxing=1;
                $.ajax({
                    url: "/u/"+OP_CONFIG.userInfo.uid+"/note/"+noteId,
                    type: "DELETE",
                    dataType: "json",
                    success: function(res) {
                        if(res.result==0){
                            toRemove.remove();
                            $.prompt("删除成功",{icon:'success'})
                            
                            //删除一条笔记左边数字减1
                            var $el, num;
                            $el = $('.js-count-note .got-num');
                            if ($el.length) {
                                num = parseInt($el.text(), 10);
                                num--;
                                if (num <= 0 ) {
                                    num = 0;
                                }
                                $el.text(num);
                            }
                           
                            if(window.thePlayer && window.thePlayer.getState()=="PAUSED"){
                                thePlayer.play();
                            }
                        } else {
                            $.prompt("删除失败去，请重试",{icon:'error'})
                            ajaxing=0;

                            if(window.thePlayer && window.thePlayer.getState()=="PAUSED"){
                                thePlayer.play();
                            }
                        }
                    }
                });
            }
            
        });

        $('.popl-no').on('click',function(){
            $("#js-popl-wrap").remove();
            $(".contain-coverLayer").remove();

            if(window.thePlayer && window.thePlayer.getState()=="PAUSED"){
                thePlayer.play();
            }
        })
    });
});