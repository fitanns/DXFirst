/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

({
    getLeadsBySubjects: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getLeadsBySubject", {});
        requestMethodResult.then(
            result => {
                let labels = [],
                    data = [];
                result.forEach(function (element) {
                    labels.push(element.label);
                    data.push(element.quantity);
                });
                this.formChart(labels, data);
            },
            error => {
            }
        );
    },
    formChart: function (labels, datas) {

        let config = {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: datas,
                    backgroundColor: [
                        "#00a1e0", "#16325c", "#3cba9f", "#e8c3b9"
                    ],
                }],
                labels: labels
            },
            options: {
                responsive: true,
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Number of Leads per Subject'
                },
                tooltips: {
                    callbacks: {
                        label: function (tooltipItem, data) {
                            let dataset = data.datasets[tooltipItem.datasetIndex],
                                total = dataset.data.reduce(function (prevValue, currentValue, currentIndex, array) {
                                return prevValue + currentValue;
                            });
                            let currentValue = dataset.data[tooltipItem.index];
                            let percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                            return percentage + "%";
                        }
                    }
                }
            }
        };


        let ctx = document.getElementById("pie-chart").getContext("2d");
        window.myDoughnut = new Chart(ctx, config);
    }
});