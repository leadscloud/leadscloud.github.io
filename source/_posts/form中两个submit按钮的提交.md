---
title: form中两个submit按钮的提交
id: 313563
categories:
  - HTML/CSS
date: 2013-02-22 08:45:24
tags:
---

  
<pre class="lang:xhtml decode:true " >&lt;form method="post"  id="form_1" action="javascript:;"&gt;
&lt;input type="submit" value="add" name="sub"/&gt;
&lt;input type="submit" value="envoi" name="sub"/&gt;
&lt;/form&gt;</pre> 

<pre class="lang:js decode:true " >$(function() {
  $('input[name=sub]').click(function(){
    var _data= $('#form_1').serialize() + '&amp;sub=' + $(this).val();
    $.ajax({
      type: 'POST',
      url: "php.php?",
      data:_data,
      success: function(html){
         $('div#1').html(html);
      }
    });
    return false;
  });
});</pre> 

 参考信息： [http://stackoverflow.com/questions/3275640/jquery-submit-ajax-form-with-2-submit-buttons](http://stackoverflow.com/questions/3275640/jquery-submit-ajax-form-with-2-submit-buttons)