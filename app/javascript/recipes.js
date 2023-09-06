$(document).ready(function() {
  $('#public-checkbox').on('change', function() {
    $(this).closest('form').submit();
  });
});