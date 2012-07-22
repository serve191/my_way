var $j = jQuery.noConflict();

FileUploader = function(dropzone, options) {
  new View();
  var uploadQuery = {}, count = 0;


  function upload(myFile, itemUI) {
    var xhr = createRequestObject();

    xhr.upload.onprogress  = onprogress;
    xhr.onreadystatechange = onreadystatechange; 

    addToQuery(myFile);
    run();

    function run() {
      var url = path();
      var formData = new FormData();
      formData.append("uploadfile", myFile);
      formData.append("authenticity_token", options.authenticity_token);

      xhr.open("POST", url, true);
      xhr.send(formData);
    }

    function onprogress(e) {
      if (e.lengthComputable) {
        var percentage = Math.round((e.loaded * 100) / e.total);
        itemUI.progress(percentage);
      }
    }
  
    function onComplete() {
      var response; 

      if (xhr.status == 201 || xhr.status == 200) {
        itemUI.success();
        delFromQuery(myFile);

        try { response = eval("(" + xhr.responseText + ")"); }
        catch(err) { response = {}; }

        options.success && options.success(response, fileName(), path());
        isUploadQueryEmpty() && options.queryEmpty && options.queryEmpty();
      }
    }
  
    function onreadystatechange() {
      if (xhr.readyState == 4) { onComplete(); }
    }

    function addToQuery() {
      uploadQuery[myFile] = true; count++;
    }

    function delFromQuery() {
      delete uploadQuery[myFile]; 
      if (0 < count) count--;
    }

    function isUploadQueryEmpty() {
      return count == 0;
    }

    function path() {
      return options.url + '?fileName=' + fileName();
    }

    function fileName() {
      return (escape(myFile.name))
    }
  }

  //----------------------------------------------------------------------------------------------------------------------
  function View() {
    var button      = $j('<button class="awesome">Upload</button>'),
        fileInput   = $j('<input type="file" multiple="multiple" name="files[]">'),
        filesList   = $j('<ul class="file-upload-list"></ul>');


    function addItem(file) {
      var progressBar = $j('<strong>0%</strong>'),
          li = $j(r('<li>{{fileName}} {{size}} / </li>')).append(progressBar);

      filesList.append(li);

      upload(file, {
        progress: progress,
        success: success 
      });

      function progress(text) {
        progressBar.html(text + '%');
      }

      function success() {
        li.effect('highlight', {}, 3000);
        li.fadeOut('slow', function() { li.remove() });
      }

      function r(str) {
        return str
            .replace('{{fileName}}', file.name)
            .replace('{{size}}', formatSize(file.size));
      }
    }

    function formatSize(size) {
      var bytesPerMB = 1024 * 1024,
          mb = size / bytesPerMB;

      return Math.round(mb * 100) / 100 + ' MB';
    }


    fileInput.bind('change', function() {
      var f = fileInput.get(0);
      $j.doWithEach(f.files, addItem);
    });

    dropzone
        .addClass('file-upload')
        .append(button)
        .append(fileInput)
        .append(filesList);
        
    button.click(function(e) {
      fileInput.trigger('click'); e.preventDefault();
    });

    dropzone.bind("dragover", function(e) {
      dropzone.addClass('file-upload-dragover'); e.preventDefault();
    });
    dropzone.bind("dragleave", function(e) {
      dropzone.removeClass('file-upload-dragover'); e.preventDefault();
    });
    dropzone.bind("drop", function(e) {
      e.preventDefault();
      
      var files = e.originalEvent.dataTransfer.files;
      dropzone.removeClass('file-upload-dragover');

      $j.doWithEach(files, addItem);
    });
  }
}

$j.doWithEach = function(arr, cb) {
  $j.each(arr, function(i) {
    cb(arr[i]);
  });
}

$j.fn.asUpload = function(options) {
  new FileUploader($j(this), options);
}

function createRequestObject() {
    var request = null;

    if (!request) try {
      request = new ActiveXObject('Msxml2.XMLHTTP');
    } catch (e) {}
    if (!request) try {
      request = new ActiveXObject('Microsoft.XMLHTTP');
    } catch (e) {}
    if (!request) try {
      request = new XMLHttpRequest();
    } catch (e) {}
    
    return request;
}

