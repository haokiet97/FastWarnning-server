$(document).on('turbolinks:load', function() {
    $('.input-daterange input[type="text"]').datetimepicker({
        format: "YYYY-MM-DD HH:mm"
    });

    $('.history-button').on('click', function (){
        $(this).parent().find('.list-group-item').removeClass('active');
        $(this).addClass('active');
        let time_values = $(this).find('.list-group-item-heading').eq(0).data('time-values');
        let startEl = $('.input-daterange input#q_created_at_gteq[type="text"]');
        let endEl = $('.input-daterange input#q_created_at_lteq[type="text"]');
        let formSubmitEl = $('form#video_search input[type="submit"]');
        let current_time = new Date();
        let end_time = new Date(current_time.getTime());
        let start_time = new Date(current_time.getTime());
        switch (time_values) {
            case 'today':
                end_time = new Date(current_time.getTime());
                start_time = new Date(current_time.getTime());
                start_time.setHours(0, 0, 0);
                SetTimesForDateRange(startEl, endEl, start_time, end_time);
                formSubmitEl.trigger('click');
                break;
            case 'yesterday':
                end_time = new Date(current_time.getTime());
                start_time = new Date(current_time.getTime());
                start_time.setDate(start_time.getDate() - 1);
                start_time.setHours(0, 0, 0);
                end_time.setDate(end_time.getDate() - 1);
                end_time.setHours(23, 59, 59);
                SetTimesForDateRange(startEl, endEl, start_time, end_time);
                formSubmitEl.trigger('click');
                break;
            case 'this-week':
                end_time = new Date(current_time.getTime());
                start_time = new Date(current_time.getTime());
                start_time.setDate(start_time.getDate() - 6);
                start_time.setHours(0, 0, 0);
                SetTimesForDateRange(startEl, endEl, start_time, end_time);
                formSubmitEl.trigger('click');
                break;
            case 'this-month':
                end_time = new Date(current_time.getTime());
                start_time = new Date(current_time.getTime());
                start_time.setDate(1);
                start_time.setHours(0, 0, 0);
                SetTimesForDateRange(startEl, endEl, start_time, end_time);
                formSubmitEl.trigger('click');
                break;
            case 'all':
                SetTimesForDateRange(startEl, endEl, null, null);
                formSubmitEl.trigger('click');
                break;
            default:
                $.notify({
                    icon: 'glyphicon glyphicon-warning-sign',
                    message: "Lỗi! Hiển thị tất cả video",
                    url: "#"
                }, {
                    type: 'warning'
                });
                break;
        }
    });
});

function SetTimesForDateRange(startEl, endEl, startTime, endTime) {
    startEl.data("DateTimePicker").date(startTime);
    endEl.data("DateTimePicker").date(endTime);
}
