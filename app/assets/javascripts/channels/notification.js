App.notifications = App.cable.subscriptions.create('NotificationChannel', {
    connected: function () {
        $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message: "connected",
            url: "#"
        }, {
            type: 'warning'
        });
    },

    disconnected: function () {
    },

    received: function (data) {
        $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message: data.message,
            url: data.url
        }, {
            type: 'warning'
        });

        let drop_content = $(".dropdown-menu.notify-drop .drop-content");
        if (drop_content != null) {
            drop_content.prepend(data.html);
        }
    }
});
