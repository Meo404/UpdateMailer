$(function () {

    // Create Charts.js chart
    var ctx = document.getElementById("viewChart").getContext("2d");
    var chartData = getData();
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
            maintainAspectRatio: false,
            tooltips: {
                backgroundColor: "rgba(76,0,153,0.8)",
                mode: 'label'
            }
        }
    });

});

function getData() {
    var party = [[],[],[],[]];
    $.ajax({
        url: '/statistics/chartData',
        dataType: 'json',
        async: false, // needs to replaced soon with async call!
        success: function (data) {
            $.each(data, function() {
                $.each(this, function(k, v) {
                    if(k == 'date') {
                        party[0].push(v);
                    }
                    else if(k == 'total_views') {
                        party[1].push(v)
                    }
                    else if(k == 'mobile_views') {
                        party[2].push(v)
                    }
                    else if(k == 'desktop_views') {
                        party[3].push(v)
                    }
                });
            });
        }
    });
    return party
}