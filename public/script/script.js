$(document).ready(function(){
  $("#shortenit").click(function(){

    $("#alert").css("visibility", "hidden"); 
    $("#shortenurl").empty();

    var url_value = $("#url").val(); 

    if (isValidURL(url_value)) {
      $.post("shorten",
      {
          url: url_value 
      },
      function(data, status){
        $("#shortenurl").append("Your Shorten URL<br/><div>" + data + "</div>"); 
      });
    } else {
       $("#alert").css("visibility", "visible");
    }
  }); 
  
  function isValidURL(url) {
    return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})).?)(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(url);
  }
});
