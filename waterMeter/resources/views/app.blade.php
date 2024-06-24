<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maji Portal</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <!-- PWA  -->
    <meta name="theme-color" content="#6777ef"/>
    <link rel="apple-touch-icon" href="{{ asset('logo.png') }}">
    <link rel="manifest" href="{{ asset('/manifest.json') }}">
    <style>
        body {
            background: url('background-image.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333;
            font-family: Arial, sans-serif;
        }

        .card {
            margin: 5px auto;
            max-width: 600px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-body {
            position: relative;
            padding: 10px;
        }

        .gauge-container {
            position: relative;
            width: 100%;
            height: 200px;
        }

        /* .gauge-value {
            position: absolute;
            width: 100%;
            text-align: center;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        } */

        .stats {
            margin-top: 20px;
        }

        .stats p {
            margin: 5px 0;
            font-size: 16px;
        }

        .chart-container {
            margin-top: 20px;
        }

        .status {
            margin-top: 10px;
            font-size: 18px;
        }

        .logo {
            width: 100px;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
              <a class="navbar-brand text-dark" href="#"><b>MAJI PORTAL</b></a>
              <a  href="{{ route('user.logout') }}" class="navbar-toggler " >
                <span class="btn btn-sm btn-danger">Logout</span>
              </a>
            </div>
          </nav>
        <div class="card">
            <div class="card-body text-center">
                <h6 class="mb-4">MTEJA PORTAL</h6>

                <img src="{{ asset('logo.png') }}" alt="Company Logo" class="logo mb-3">
                <br>
                @yield('content')
            </div>
        </div>
    </div>


<script src="{{ asset('/sw.js') }}"></script>
<script>
   if ("serviceWorker" in navigator) {
      // Register a service worker hosted at the root of the
      // site using the default scope.
      navigator.serviceWorker.register("/sw.js").then(
      (registration) => {
         console.log("Service worker registration succeeded:", registration);
      },
      (error) => {
         console.error(`Service worker registration failed: ${error}`);
      },
    );
  } else {
     console.error("Service workers are not supported.");
  }
</script>
</body>

</html>
