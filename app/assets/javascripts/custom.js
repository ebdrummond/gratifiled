$(document).ready(function() {
  $("a.add-document-link").click(function() {
    $("p.add-document:hidden").first().show();
    if ($("p.add-document:hidden").length == 0) {
      $(this).hide();
    }
    return false
  });
});