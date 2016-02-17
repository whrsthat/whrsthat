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

        EXIF.getData(fileInput.files[0], function() {
            var photo_data = this;
            if (!photo_data.exifdata || !photo_data.exifdata.GPSLatitude) {
              (function() {
                'use strict';
                // var snackbarContainer = document.querySelector('#demo-toast-example');
                // var data = {message: 'Please upload a jpeg file taken with location services on.'};
                // snackbarContainer.MaterialSnackbar.showSnackbar(data);
                $('#file_input_file').val('')
                if (!$('#event_event_address').length) {
                  var ap = $(`
                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label is-upgraded" data-upgraded=",MaterialTextfield">
                      <label class="mdl-textfield__label" for="event_event_address">Address</label>
                      <input class="mdl-textfield__input" type="text" name="event[event_address]" id="event_event_address">
                    </div>
                  `);

                  var address_picker =  new AddressPicker();
                  ap.prependTo('#new_event');
                  $('#event_event_address').typeahead(null, {
                    displayKey: 'description',
                    source: address_picker.ttAdapter()
                  });
                  address_picker.bindDefaultTypeaheadEvent($('#event_event_address'))
                  $(address_picker).on('addresspicker:selected', function (event, result) {
                    $('#event_latitude').val(result.lat());
                    $('#event_longitude').val(result.lng());
                     
                    $('#file_input_file').val('');
                  });
                }
              }());
              return 
            } else {
              var reader = new FileReader();
              reader.readAsDataURL(fileInput.files[0]);
              reader.onload = function (e) {
                var data_url = e.target.result;
                $('.sample').show()
                $('.sample img').attr('src',  data_url);
              }
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