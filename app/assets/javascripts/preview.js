$(document).on('turbolinks:load', function(){
  $('.preview_file').on('change', function(){
    var $file = this.files[0];
    var reader = new FileReader();
    var preview = $(this).parent();

    reader.onloadend = function(){
      preview.css('background-image', 'url(' + reader.result + ')');
      preview.css('background-size', 'contain');
      return false;
    }

    if ($file) {
      reader.readAsDataURL($file);
    }
  });
});
