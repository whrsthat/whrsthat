$ ->
  $('#file_input_file').change () ->
    $(this).addClass('is-focused')
    reader = new FileReader()
    image = $(this)[0].files[0]

    EXIF.getData(image, () ->
      if !this or !this.exifdata or !this.exifdata.GPSLatitude
        $('#image-upload-toast')[0].MaterialSnackbar.showSnackbar({ message: "Sorry, the image you uploaded does not contain location data" });
        return

      lat = this.exifdata.GPSLatitude.slice(-1)[0].valueOf()
      lng = this.exifdata.GPSLongitude.slice(-1)[0].valueOf()
      debugger
      reader.readAsDataURL(image);
      reader.onload = (e) ->
        data_url = e.target.result;
        $('.sample').show()
        $('.sample img').attr('src',  data_url)
    ) 
