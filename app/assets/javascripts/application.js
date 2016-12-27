//= require jquery_ujs
//= require plugin/jquery.easing.pack

window['CKEDITOR_BASEPATH']='/ckeditor/';

var ww = $('html').width();

  if (ww > 768) {
    $("#sdt_menu > li").bind("mouseenter", function() {
      var $elem;
      $elem = $(this);
      $elem.addClass("active");
      return $elem.find("img").stop(true).animate({
        width: "123px",
        height: "68px",
        left: "0px"
      }, 400, "easeOutBack").andSelf().find(".sdt_wrap").stop(true).animate({
        top: "50px"
      }, 500, "easeOutBack").andSelf().find(".sdt_active").stop(true).animate({
        height: "68px"
      }, 300, function() {
        var $sub_menu, left;
        $sub_menu = $elem.find(".sdt_box");
        if ($sub_menu.length) {
          left = "100px";
          if ($elem.parent().children().length === $elem.index() + 1) {
            left = "-100px";
          }
          return $sub_menu.show().animate({
            left: left
          }, 200);
        }
      });
    }).bind("mouseleave", function() {
      var $elem, $sub_menu;
      $elem = $(this);
      $elem.removeClass("active");
      $sub_menu = $elem.find(".sdt_box");
      if ($sub_menu.length) {
        $sub_menu.hide().css("left", "0px");
      }
      return $elem.find(".sdt_active").stop(true).animate({
        height: "0px"
      }, 300).andSelf().find("img").stop(true).animate({
        width: "0px",
        height: "0px",
        left: "85px"
      }, 400).andSelf().find(".sdt_wrap").stop(true).animate({
        top: "0px"
      }, 500);
    });
  }