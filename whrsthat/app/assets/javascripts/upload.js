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
    if (fileInputText.value.length != 0) {
      if (!fileInputTextDiv.classList.contains("is-focused")) {
        fileInputTextDiv.classList.add('is-focused');
        var reader = new FileReader();
        reader.readAsDataURL(fileInput.files[0]);
        reader.onload = function (e) {
          var data_url = e.target.result;
          $('.sample').show()
          $('.sample img').attr('src',  data_url);
        }
      }
    } else {
      if (fileInputTextDiv.classList.contains("is-focused")) {
        fileInputTextDiv.classList.remove('is-focused');
      }
    }
  }
}

$('#file_input_file').length && file_input()