/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

({
    subscribeToEvent: function (component) {
        let empApi = component.find('empApi');
        empApi.subscribe("/event/Batch_Completed__e", -1, $A.getCallback(searchResult => {
            this.handleEventAndGetData(component, searchResult.data.payload);
            console.log('seatchRes : ' + JSON.stringify(searchResult.data.payload));
        })).then(subscription => {
            component.set('v.subscription', subscription);
        }).catch(error => {
            console.log(JSON.stringify(error));
        });
    },
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
    fireFormData: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.fireBatchToFormData", {});
        component.set("v.spinner", true);
        requestMethodResult.then(
            result => {
                console.log('success fire');
            },
            error => {
                console.log('err fire');
            }
        );
    },
    handleEventAndGetData: function (component, batchStatus) {
        if (batchStatus.Status__c === 'Failed') {
            component.set("v.spinner", false);
            component.set("v.errorMessage", true);
        } else {
            const request = component.find("requestCall");
            const requestMethodResult = request.enqueue("c.getSubjectsLeadsData", {});
            requestMethodResult.then(
                result => {
                    let labels = [],
                        data = [];
                    result.forEach(function (element) {
                        labels.push(element.Name);
                        data.push(element.Quantity__c);
                    });
                    component.set("v.spinner", false);
                    this.formChart(labels, data);
                },
                error => {
                }
            );
        }
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
                                sum = dataset.data.reduce(function (prevValue, currentValue, currentIndex, array) {
                                    return prevValue + currentValue;
                                });
                            let currentValue = dataset.data[tooltipItem.index],
                                percent = Math.floor(((currentValue / sum) * 100) + 0.5);
                            return percent + "%";
                        }
                    }
                }
            }
        };

        let context = document.getElementById("pie-chart");
        new Chart(context, config);
    },

});