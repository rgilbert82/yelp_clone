$(document).on('turbolinks:load', function() {
  $(".business-profile-header-pics a").on("mouseenter", function(e) {
    var $icon = $(e.currentTarget);
    var $icons = $icon.closest(".business-profile-header-pics").find("a");

    $icons.stop().removeClass("pic-icon-large", 0);
    $icon.stop().addClass("pic-icon-large", 0);
  });

  $(".business-profile-header-pics").on("mouseleave", function(e) {
    var $icon = $(e.currentTarget).find("a.pic-icon-primary")
    var $icons = $(e.currentTarget).find("a.pic-icon-secondary");

    $icons.stop().removeClass("pic-icon-large", 0);
    $icon.stop().addClass("pic-icon-large", 0);
  });

  $(".photo-modal").on("click", ".photo-dark-layer", function(e) {
    $(".photo-modal").hide();
  });
});
