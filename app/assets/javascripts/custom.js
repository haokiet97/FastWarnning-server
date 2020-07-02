$(document).on('turbolinks:load', function() {
    $('.input-daterange input[type="text"]').datetimepicker({
        format: "YYYY/MM/DD HH:mm"
    });
});