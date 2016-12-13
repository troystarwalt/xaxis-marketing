$(document).ready(function(){
  $('.headshot-image').on('click', function (e){
    var index = $(this).data('index');
    var headshot = gon.headshots[index];

    $('.hs-img').attr({
      src: headshot.image.large.url,
      alt: headshot.first_name,
      photo_id: headshot.id
      });
    $('#hsModal').modal('show');
    e.preventDefault();
  });

  $('#hsModal').on('hide.bs.modal', function(e){
    $('.hs-img').attr('src', '');
  })
});
