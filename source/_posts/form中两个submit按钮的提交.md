---
title: form中两个submit按钮的提交
id: 313563
categories:
  - HTML/CSS
date: 2013-02-22 08:45:24
tags:
---

  
```
<form method="post"  id="form_1" action="javascript:;">
  <input type="submit" value="add" name="sub"/>
  <input type="submit" value="envoi" name="sub"/>
</form>
```

```
$(function() {
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
});
```

 参考信息： [http://stackoverflow.com/questions/3275640/jquery-submit-ajax-form-with-2-submit-buttons](http://stackoverflow.com/questions/3275640/jquery-submit-ajax-form-with-2-submit-buttons)