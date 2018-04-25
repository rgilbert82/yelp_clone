$(document).on('turbolinks:load', function() {
  $("body").on("click", ".check-all", function(e) {
    e.preventDefault();
    $(".conversation-check").prop("checked", true);
  });

  $("body").on("click", ".uncheck-all", function(e) {
    e.preventDefault();
    $(".conversation-check").prop("checked", false);
  });
});
