$(function () {

    // Retrieve page data
    var chartData = getMailViewChartData();
    var updateMailData = getUpdateMailData();


    // Create Mail Views Line Chart for the last 7 days
    var ctx = document.getElementById("viewLineChart").getContext("2d");
    var newLineChart = new Chart(ctx, {
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
                    label: "Mobile Views",
                    backgroundColor: "rgba(35,198,200,0.5)",
                    data: chartData[2]
                },
                {
                    label: "Desktop Views",
                    backgroundColor: "rgba(26,179,148,0.6)",
                    data: chartData[3]
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        }
    });



    // Create Mails Views per hour bar chart
    var ctx2 = document.getElementById("viewBarChart").getContext("2d");
    var newBarChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: getBarChartLabels(),
            datasets: [
                {
                    label: 'Views',
                    backgroundColor: "rgba(26,179,148,0.6)",
                    data: updateMailData[0]
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                yAxes: [{
                    stacked: true
                }]
            }
        }
    });

    // Create Mail Views per device type pie chart
    var ctx3 = document.getElementById('viewPieChart').getContext("2d");
    var newPieChart = new Chart(ctx3, {
        type: 'pie',
        data: {
            labels: ['Desktop Views', 'Mobile Views'],
            datasets: [
                {
                    data: updateMailData[1],
                    backgroundColor: [
                        "rgba(26,179,148,0.6)",
                        "rgba(35,198,200,0.5)"

                    ]
                }
            ]
        }
    })

});

function getMailViewChartData() {
    var result = [[],[],[],[]];
    $.ajax({
        url: '/statistics/chartData?id=' + update_mail_id ,
        dataType: 'json',
        async: false, // needs to replaced soon with async call!
        success: function (data) {
            $.each(data, function() {
                result[0].push(this['date']);
                result[1].push(this['viewsPerDeviceType']['totalViews']);
                result[2].push(this['viewsPerDeviceType']['mobileViews']);
                result[3].push(this['viewsPerDeviceType']['desktopViews']);
            });
        }
    });
    return result
}

function getUpdateMailData() {
    var result = [[],[]];
    $.ajax({
        url: '/statistics/updateMailData?id=' + update_mail_id ,
        dataType: 'json',
        async: false, // needs to replaced soon with async call!
        success: function (data) {
            $.each(data['viewsPerHour'], function() {
                result[0].push(parseInt(this))
            });
            result[1].push(parseInt(data['viewsPerDeviceType']['desktop']));
            result[1].push(parseInt(data['viewsPerDeviceType']['mobile']));
        }
    });
    return result
}

function getBarChartLabels() {
    var viewBarChartLabels = [];
    for(var i = 0; i <= 23; i++) {
        viewBarChartLabels.push(i.toString())
    }
    return viewBarChartLabels
}