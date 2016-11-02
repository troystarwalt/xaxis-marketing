$(document).ready(function(){
  $('.tagsinput').each(function(index, elem){
    $(elem).tagsInput({
      'defaultText': $(elem).attr('placeholder')
    });
  });
});
