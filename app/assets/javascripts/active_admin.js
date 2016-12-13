//= require active_admin/base
//= require tagsinput.min
//= require select2
//= require multiselect
//= require tagsinputter

$('.admin_namespace').ready(function() {
  var form_files = $('form input[type=file]');
  form_files.each(function() {
    var this_id = $(this)[0].id;
    getFileUploadIds(this_id)
  })

  function getFileUploadIds(id) {
    $('#' + id).bind('change', function () {
      var specificFileInput = $('#' + id);
      var get_data_type = specificFileInput.data("type");
      var data_types = {ppt: 100,
                        pdf: 5,
                        png: 5,
                        large_png: 10,
                        bank: 300
                      }
      var max_size_of_file_upload = data_types[get_data_type];
      addTextInput(specificFileInput, max_size_of_file_upload);
    })
  }

  function addTextInput(file_id, megabyteLimit) {
    // var element_check = $('.file-size-alert');
    var size_is_good = "All Good",
        size_is_big = `Way too big. Try again. Max ${megabyteLimit}mb`,
        maxSize = (megabyteLimit * (1024 * 1024)),
        file_size_alert = $(file_id).next('.inline-hints');
    if (file_id[0].files[0].size > maxSize){
      file_size_alert.toggleClass('size-bad', true).text(size_is_big);
    }
    else {
      file_size_alert.toggleClass('size-bad', false).text(size_is_good);
    };
  };
});




  //   $('#global_accessory_file').bind('change', function () {
  //     var gAF = $('#global_accessory_file');
  //     var element_check = $('.file-size-alert');
  //     var size_is_good = "All Good";
  //     var size_is_big = "Way too big. Try again.";
  //     var maxSize = (300 * (2 * 1024));
  //     if ( element_check[0] ) {
  //       addTextInput();
  //     }
  //     else {
  //       console.log('does not exist');
  //       console.log(gAF);
  //       gAF.next('.inline-hints').append("<p class='file-size-alert'></p>");
  //       addTextInput();
  //     };
  //     function addTextInput() {
  //       if (gAF[0].files[0].size > maxSize){
  //         var file_size_alert = $('.file-size-alert');
  //         file_size_alert.toggleClass('size-bad', true).text(size_is_big);
  //
  //       }
  //       else {
  //         var file_size_alert = $('.file-size-alert');
  //         file_size_alert.toggleClass('size-bad', false).text(size_is_good);
  //       };
  //     };
  //   });
  // });
