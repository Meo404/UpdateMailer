$(function () {

    // Create Charts.js chart
    // TODO- Change chart colors
    var ctx = document.getElementById("viewChart").getContext("2d");
    var chartData = getChartData();
    var newChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: chartData[0],
            datasets: [
                {
                    label: "Total Views",
                    backgroundColor: 'rgba(243,243,244,0.4)',
                    data: chartData[1]
                },
                {
                    label: "Desktop Views",
                    backgroundColor: "rgba(26,179,148,0.6)",
                    data: chartData[2]
                },
                {
                    label: "Mobile Views",
                    backgroundColor: "rgba(35,198,200,0.5)",
                    data: chartData[3]
                },
                {
                    label: "Tablet Views",
                    backgroundColor: "rgba(26,179,148,0.6)",
                    data: chartData[4]
                },
                {
                    label: "Other Views",
                    backgroundColor: "rgba(26,179,148,0.6)",
                    data: chartData[5]
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            tooltips: {
                backgroundColor: "rgba(76,0,153,0.8)",
                mode: 'label'
            }
        }
    });

});

function getChartData() {
    var result = [[],[],[],[],[],[]];
    $.ajax({
        url: '/statistics/chartData',
        dataType: 'json',
        async: false, // needs to replaced soon with async call!
        success: function (data) {
            $.each(data, function() {
                result[0].push(this['date']);
                result[1].push(this['viewsPerDeviceType']['totalViews']);
                result[2].push(this['viewsPerDeviceType']['desktopViews']);
                result[3].push(this['viewsPerDeviceType']['mobileViews']);
                result[4].push(this['viewsPerDeviceType']['tabletViews']);
                result[5].push(this['viewsPerDeviceType']['otherViews']);
            });
        }
    });
    return result
}