@extends('app')

@section('content')
<div class="d-flex justify-content-between">
    <div class="dropdown my-3">
        <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
          Select Meter
        </button>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="{{route('home')}}">All</a></li>
            @foreach($meters as $meter)
          <li><a class="dropdown-item" href="{{route('home')}}?meter_id={{ $meter->id }}">{{ $meter->meter_no }}</a></li>
          @endforeach

        </ul>
    </div>

    <a href="{{ route('purchase') }}" class="btn btn-success my-3">Purchase Watter</a>
   </div>
    <div class="p-2 shadow-lg rounded">
        <center>
            <div class="gauge-container">
                <canvas id="gaugeChart"></canvas>
            </div>
        </center>
        <div class="stats">
          @livewire('detect-leackage',['meterId'=>request()->meter_id])
         </div>
    </div>
    <div class="chart-container">
        <canvas id="barChart" width="400" height="200"></canvas>
    </div>
    <div class="status text-success">No Leak Detected</div>


    <script>
        // Custom plugin to draw text at the center of the doughnut chart
        const centerTextPlugin = {
            id: 'centerText',
            afterDatasetsDraw(chart) {
                const {
                    ctx,
                    chartArea: {
                        width,
                        height
                    }
                } = chart;
                ctx.save();
                ctx.font = '20px Arial';
                ctx.fillStyle = '#007bff';
                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                const text = chart.data.remaining??0 + ' Litres';
                const textX = width / 2;
                const textY = height / 2;
                ctx.fillText(text, textX, textY);
                ctx.restore();
            }
        };

        // Register the plugin with Chart.js
        Chart.register(centerTextPlugin);
        // Function to fetch data from the server
        async function fetchGaugeData() {
            try {
                const response = await fetch('/getgaugedata?meter_id='+"{{ request()->meter_id }}");
                const data = await response.json();
                return data;
            } catch (error) {
                console.error('Error fetching gauge data:', error);
                return null;
            }
        }

        // Function to update the gauge chart
        async function updateGaugeChart() {
            const gaugeData = await fetchGaugeData();
            if (gaugeData) {
                const { totalWater, remainingWater } = gaugeData;
                const usedWater = totalWater - remainingWater;
                const remainingPercentage = (remainingWater / totalWater) * 100;
                const usedPercentage = (usedWater / totalWater) * 100;

                gaugeChart.data.datasets[0].data = [remainingPercentage, usedPercentage];
                gaugeChart.data.remaining = remainingWater+" Litres";
                gaugeChart.update();


            }
        }

        // Gauge Chart
        const gaugeCtx = document.getElementById('gaugeChart').getContext('2d');
        const gaugeChart = new Chart(gaugeCtx, {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: [100, 0], // Initial values
                    backgroundColor: ['#007bff', '#e0e0e0'],
                    borderWidth: 0
                }]
            },
            options: {
                cutout: '80%',
                plugins: {
                    legend: {
                        display: false
                    },
                    centerText: true
                }
            }
        });

        // Initial update to the gauge chart
        updateGaugeChart();

        // Refresh the chart data every 5 seconds
        setInterval(updateGaugeChart, 5000); // Update every 5 seconds

    // Bar Chart
const barCtx = document.getElementById('barChart').getContext('2d');
const barChart = new Chart(barCtx, {
    type: 'line',
    data: {
        labels: @json($labels),
        datasets: [{
            label: 'Daily Usage (Litres)',
            data: @json($dailyUsage), // Example values
            borderColor: '#007bff',  // Line color
            backgroundColor: 'rgba(0, 123, 255, 0.2)', // Area under the line color
            fill: true // Fill the area under the line
        }]
    },
    options: {
        responsive: true,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

// Dynamically updating values (example)
document.getElementById('dailyLimit').innerText = '250 Litres';
document.getElementById('monthlyTotal').innerText = '1149 Litres';
document.getElementById('dailyAverage').innerText = '287 Litres';

    </script>
    @endsection
