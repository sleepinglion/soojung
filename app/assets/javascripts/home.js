//= require application

$(document).ready(function() {
    $(".scrollable").scrollable({
        circular: true,
        mousewheel: true
    }).navigator().autoscroll({
        interval: 3000
  });
});  