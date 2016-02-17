function file_input() {
  var fileInputTextDiv = $('#file_input_text_div')[0];
  var fileInput = $('#file_input_file')[0];
  var fileInputText = $('#file_input_text')[0];
  fileInput.addEventListener('change', changeInputText);
  fileInput.addEventListener('change', changeState);

  function changeInputText() {
    var str = fileInput.value;
    var i;
    if (str.lastIndexOf('\\')) {
      i = str.lastIndexOf('\\') + 1;
    } else if (str.lastIndexOf('/')) {
      i = str.lastIndexOf('/') + 1;
    }
    fileInputText.value = str.slice(i, str.length);
  }

  function changeState() {
        fileInputTextDiv.classList.add('is-focused');
        var reader = new FileReader();
        reader.readAsDataURL(fileInput.files[0]);
        reader.onload = function (e) {
          var data_url = e.target.result;
          $('.sample').show()
          $('.sample img').attr('src',  data_url);
        }
        EXIF.getData(fileInput.files[0], function() {
            var photo_data = this;
            if (!photo_data.exifdata || !photo_data.exifdata.GPSLatitude) {
              (function() {
                'use strict';
                var snackbarContainer = document.querySelector('#demo-toast-example');
                var data = {message: 'Please upload a jpeg file taken with location services on.'};
                snackbarContainer.MaterialSnackbar.showSnackbar(data);
              }());
              return 
            } 

            var lat = photo_data.exifdata.GPSLatitude[0] + (photo_data.exifdata.GPSLatitude[1] / 60) + (photo_data.exifdata.GPSLatitude[2] / 3600)
            var long = photo_data.exifdata.GPSLongitude[0] + (photo_data.exifdata.GPSLongitude[1] / 60) + (photo_data.exifdata.GPSLongitude[2] / 3600)
            
            var final_latitude = ((photo_data.exifdata.GPSLatitudeRef == "S") ? (lat * -1) : lat) //(N is +, S is -)
            var final_longitude = ((photo_data.exifdata.GPSLongitudeRef == "W") ? (long * -1) : long) //(W is -, E is +)

            $('#event_latitude').val(final_latitude)
            $('#event_longitude').val(final_longitude)
        });
  }
} 

$(function() {
  $('#file_input_text_div').length && file_input()
})