$(document).ready(function(){
  $('.select2').each(function(index, elem){
    $(elem).select2({
      placeholder: $(elem).attr('placeholder')
    });
  });
});
