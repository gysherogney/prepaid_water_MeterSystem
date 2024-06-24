<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $title ?? 'Momo internet' }}</title>
    <style>
        /*the complete project is in the following link:
https://github.com/vkive/coupon-code.git
Follow me on Codepen
*/
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'poppins', sans-serif;

        }

        .xcontainer {
            width: 100%;
            /* height: 100vh; */

            display: flex;
            align-items: center;
            justify-content: center;

        }

        .coupon-card {
            background: linear-gradient(135deg, #fe5874, #e9410e);
            color: #fff;
            text-align: center;
            padding: 10px 50px;
            border-radius: 15px;
            box-shadow: 0 10px 10px 0 rgba(0, 0, 0, 0.15);
            position: relative;

        }

        .logo {
            width: 80px;
            border-radius: 8px;
            margin-bottom: 20px;

        }

        .coupon-card h3 {
            font-size: 28px;
            font-weight: 400;
            line-height: 40px;

        }

        .coupon-card p {
            font-size: 15px;

        }

        .coupon-row {
            display: flex;
            align-items: center;
            margin: 25px auto;
            width: fit-content;

        }

        #cpnCode {
            border: 1px dashed #fff;
            padding: 10px 20px;
            border-right: 0;

        }

        #cpnBtn {
            border: 1px solid #fff;
            background: #fff;
            padding: 10px 20px;
            color: #fe5858;
            cursor: pointer;
        }

        .circle1,
        .circle2 {
            background: #f0fff3;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);

        }

        .circle1 {
            left: -25px;
        }

        .circle2 {
            right: -25px;
        }

        .btn-primary {
            background-color: #f72d2d !important;
        }

        .alert-danger {
            background-color: #fe585850 !important;
            color: #fe5858 !important;
        }

        .glass {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0));
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            height: 1000px !important;
            width: 100% !important;
        }


        .glassc {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0));
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            /* color: white !important; */
            width: 100% !important;
        }
    </style>
    <link href="{{ asset('bootstrap.min.css') }}" rel="stylesheet">

    @livewireStyles()
</head>

<body class="" style="background-image:url({{ asset('bg.jpg') }});">

    <div class="glass  ">
        <div class="  ">
            <center>
                <a href="/"><img src="{{ asset('wifi.png') }}" alt="" width="150"></a>
            </center>
            <div class="row mt-2 ">
                <div class="card   glassc m-1">
                    {{ $slot }}

                </div>

            </div>
        </div>
    </div>

    @livewireScripts()
</body>

</html>
