$(document).ready(function() {
  var W3CDOM = document.createElement && document.getElementsByTagName;
  populateText();
  buildUpdatePage();

  function buildUpdatePage() {
    showPane("default");

    //Set up listeners
    if (!W3CDOM) {
      console.log("hidden file being removed");
      $("#filebox").removeClass("hiddenFileChoose");
      return;
    }

    // Get product info for display
    getProductInfo();

    /////////////////////////////
    // When a file is selected, update the UI and add listener for upload
    $(":file").change(function() {
      var file = this.files[0];
      name = file.name;
      size = file.size;
      type = file.type;

      if (file.name.length < 1) {
      } else {
        updateFakeFileInput();
        $("#upload").click(function() {
          showPane("uploading");
          $("#uploadProgress").css("width", "0%");
          var formData = new FormData($("#fileupload")[0]);
          $.ajax(
            {
              type: "POST",
              xhr: function() {
                // custom xhr
                myXhr = $.ajaxSettings.xhr();
                if (myXhr.upload) {
                  // if upload property exists
                  myXhr.upload.addEventListener(
                    "progress",
                    handleUploadProgress,
                    false
                  ); // progressbar
                }
                return myXhr;
              },
              //Ajax events
              success: (completeHandler = function(data) {
                showPane("finished");
              }),
              error: (errorHandler = function(e) {
                handleUploadError(e);
              }),
              // Form data
              data: formData,
              //Options to tell JQuery not to process data or worry about content-type
              cache: false,
              contentType: false,
              processData: false
            },
            "json"
          );
        });
      }
    });
  }

  /*
   * If we get an error while uploading the zip
   * Display an error string and prompt user
   * to retry
   */
  function handleUploadError(ajaxError) {
    // Update the error text in the DOM
    var errorMessage = getErrorMessage(ajaxError);
    $("#helpTitle_error").text(errorMessage);

    cleanUpFileInput();
    setTimeout(function() {
      showPane("error");
    }, 1500);
  }

  /*
   * Gets an ajax error event and parses an error string
   * based on the subcode
   */
  function getErrorMessage(errorEvent) {
    try {
      // parse subcode from raw response
      var errorJson = JSON.parse(errorEvent.responseText);
      var subcode = errorJson.Error.subcode;
      var suppliedMessage = errorJson.Error.message;

      // use subcode to get the error string
      // see https://tinyurl.com/yd9ln6f4
      // for details

      var errorMessage = "";

      switch (subcode) {
        case 100:
          errorMessage = translationsObj.upload_error_unable_to_create_unzip;
          break;
        case 101:
          errorMessage = translationsObj.upload_error_not_enough_space;
          break;
        case 102:
          errorMessage = translationsObj.upload_error_problem_unzipping;
          break;
        case 110:
          errorMessage = translationsObj.upload_error_missing_sig_file;
          break;
        case 111:
          errorMessage = translationsObj.upload_error_validation_issue;
          break;
        case 112:
          errorMessage = translationsObj.upload_error_invalid_metadata;
          break;
        case 120:
          errorMessage = translationsObj.upload_error_product_mismatch;
          break;
        case 121:
          errorMessage = translationsObj.upload_error_signing_key_mismatch;
          break;
        case 122:
          errorMessage = translationsObj.helpTitle_error;
          break;
        case 130:
          errorMessage = translationsObj.upload_error_unsupported_version;
          break;
        case 190:
        case 104:
          errorMessage = translationsObj.upload_error_timeout;
          break;
        default:
          // default to the english error message supplied in the response
          errorMessage = suppliedMessage || translationsObj.helpTitle_error;
          break;
      }

      // return error message
      return errorMessage;
    } catch (parseError) {
      // on error
      // return default error message
      return translationsObj.helpTitle_error;
    }
  }

  /*
   * Gets the current product info and displays it on the page
   */
  function getProductInfo(canRetry) {
    $.ajax({
      url: "./sysinfo.json",
      success: function(systemInfoObj) {
        console.log(JSON.stringify(systemInfoObj));

        var productType = systemInfoObj.productType;
        var environment = systemInfoObj.certType;
        var firmwareVer = systemInfoObj.firmwareVersion;

        //truncate firmware number to make it more readable
        var indexOfSecondSpace = firmwareVer.indexOf(
          " ",
          firmwareVer.indexOf(" ") + 1
        );
        if (indexOfSecondSpace > 0) {
          var firmwareVer = firmwareVer.substring(0, indexOfSecondSpace);
        }

        // Populate speaker metadata
        $("#productTypeAndEnvironment").text(
          productType + " " + "(" + environment + ")"
        );
        $("#productFirmware").text(firmwareVer);

        $("#productInfoContainer").show();
      },
      error: function(error) {
        // retry once
        if (canRetry) {
          getProductInfo(false);
        }
      }
    });
  }

  /**
   * When a file has been chosen, update UI & get value
   */
  function updateFakeFileInput() {
    $("#chooseFile").hide();
    $("#uploadBoxMessage_default").hide();
    $(".fakeFile").show();
    $("#fileinputs").show();
    $("#upload").show();
    $(".chooseFileButton").css("cursor", "auto");
    $("#filebox").css("cursor", "auto");

    /*
     * workaround for chrome browser // delete the fakepath
     */
    if (navigator.userAgent.indexOf("Chrome")) {
      $("#fakeFileInput").val(
        $("#filebox")
          .val()
          .replace(/C:\\fakepath\\/i, "")
      );
    } else {
      $("#fakeFileInput").val($("#filebox").val());
    }
  }

  /**
   * Calculate progress percentage and update progress bar CSS
   */
  function handleUploadProgress(e) {
    var percentUploaded = Math.ceil((e.loaded / e.total) * 98);
    $("#uploadProgress").css("width", percentUploaded + "%");
  }

  /**
   * Remove file input and change styles back to default
   */
  function cleanUpFileInput() {
    document.getElementById("filebox").value = "";
    $("#chooseFile").show();
    $("#uploadBoxMessage_default").show();
    $(".fakeFile").hide();
    $("#upload").hide();
    $(".chooseFileButton").css("cursor", "pointer");
    $("#filebox").css("cursor", "pointer");
  }
});

/**
 * Get strings for current language and add them to UI
 */
function populateText() {
  var lang = getLanguage();
  var langString = "lang_" + lang;
  translationsObj = LANG_OBJ[langString];

  var keys = Object.keys(translationsObj);
  for (var i = 0; i < keys.length; i++) {
    $("#" + keys[i]).text(translationsObj[keys[i]]);
  }
}

/**
 * Get language from the browser. English is the default
 */
function getLanguage() {
  var userLang = window.navigator.userLanguage || window.navigator.language;
  var langRegex = /^[a-z]{2,3}(?:-[A-Z]{1}[a-z]{3})?(?:-[A-Z]{2,3})?$/;
  var isValidLang = langRegex.test(userLang);

  if (!isValidLang) {
    return "en";
  }

  var curLang;
  var lang = userLang.split("-");

  if (lang.length > 1 && lang[0].toLowerCase() === "zh") {
    if (lang[1].toLowerCase() === "cn" || lang[1].toLowerCase() === "sg") {
      curLang = "zh_hans";
    } else {
      curLang = "zh_hant";
    }
  } else {
    curLang = lang[0].toLowerCase();

    if (curLang === "zh") {
      curLang = "zh_hans";
    }
  }

  // Default to en if lang file doesn't exist
  if (!('lang_'+curLang in LANG_OBJ)) {
    curLang = 'en';
  }

  return curLang;
}

/**
 * Show pane with given id
 */
function showPane(pane) {
  // If element isn't already visible, fade it in
  if (!$("#" + pane).is(":visible")) {
    $(".panes").hide();
    $("#" + pane).fadeIn();
  }
}

/*
 * Called by the 'Try Again' button upon getting a
 * error for the server. Re-requests the current webpage
 * from the server (un-cached)
 */
function reloadPage() {
  location.reload(true);
}
