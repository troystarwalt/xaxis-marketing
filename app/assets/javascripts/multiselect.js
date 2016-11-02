$(document).ready(function(){
  $('.select2').each(function(index, elem){
    console.log(elem)
    $(elem).select2({
      placeholder: $(elem).attr('placeholder')
    });
  });
});
