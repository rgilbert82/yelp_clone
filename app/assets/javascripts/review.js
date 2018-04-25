$(document).on('turbolinks:load', function() {
  var $parent = $(".write-review-content-box .star-rating");

  if ($(".write-review-main-column").length > 0) {
    changeStarColorsBasedOnRating();
  }

  $parent.on('change', "input[type='radio']", function() {
    changeStarColorsBasedOnRating();
  });

  function changeStarColorsBasedOnRating() {
    if ($("input[type='radio']#star-1").is(":checked")) {
      changeStarColors("1", "#FED718")
    } if ($("input[type='radio']#star-2").is(":checked")) {
      changeStarColors("2", "#FEB018")
    } if ($("input[type='radio']#star-3").is(":checked")) {
      changeStarColors("3", "#fe5b18")
    } if ($("input[type='radio']#star-4").is(":checked")) {
      changeStarColors("4", "#EB2B2B")
    } if ($("input[type='radio']#star-5").is(":checked")) {
      changeStarColors("5", "#bd1f1f")
    }
  }

  function changeStarColors(n, color) {
    var $allStars = $parent.find(".star-box");
    var $selectedStars = $parent.find(".star-box:lt(" + n + ")");
    $allStars.css("background-color", "#ccc");
    $selectedStars.css("background-color", color);
  }
});
