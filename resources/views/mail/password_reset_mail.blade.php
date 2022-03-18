<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <meta name="description" content="envoie du mail">
    <title>Email</title>
</head>

<body>

    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }

        html,
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen,
                Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
            background: #f2f3f5;
            color: #0e1004;
        }

        .email {
            max-width: 600px;
            width: 100%;
            background-color: #ffffff;
            margin: 100px auto;
            text-align: center;
            padding: 30px;
            border-radius: 10px;
            box-sizing: border-box;
            position: relative;
        }

        .email-logo {
            text-align: center;
        }

        .email-logo img {
            width: 320px;
            height: 100px;
        }

        .email-title {
            text-align: center;
            margin-top: 30px;
        }

        .email-title h2 {
            display: inline-block;
            text-align: center;
            width: 350px;
        }

        .email-body {
            width: 100%;
            text-align: center;
        }

        .email-img {
            width: 100%;
            position: relative;
            margin-top: 30px;
        }

        .email-img img {
            width: 100%;
            height: 380px;
            border-radius: 20px;
        }

        .email-content {
            width: 100%;
            margin-top: 30px;
            position: relative;
        }

        .email-content p {
            text-align: left;
        }

        a {
            text-decoration: none;
        }

        .email-content a {
            display: inline-block;
            margin-top: 30px;
            font-weight: 500;
            background-color: #184918;
            width: 100%;
            padding: 20px;
            color: #ffffff;
            border-radius: 6px;
            box-shadow: 0 3px 20px rgba(0, 0, 0, 0.1);
        }

        .email-content .merci,
        .email-content .datetime {
            margin: 10px 0;
            font-weight: Bolder;
            color: #525053;
            text-transform: capitalize;
        }

        .email-content .merci {
            margin-top: 30px;
            line-height: 30px;
        }

        .email-content .merci strong {
            color: #0e1004;
        }

        @media screen and (max-width: 450px) {
            .email {
                max-width: 100%;
                width: 100%;
                padding: 20px;
            }

            .email-logo img {
                width: 100%;
                height: 100px;
            }

            .email-title h2 {
                width: 100%;
            }

            .email-img img {
                width: 100%;
                height: 220px;
            }
        }
    </style>

    <div class="email">
        <div class="email-logo">
            <img src="https://logcorporation.com/PEV_new/public/images/mdn.png">
        </div>

        <div class="email-title">
            <h2>Confirmation de la prise de rendez-vous</h2>
        </div>

        <div class="email-body">
            <div class="email-img">
                <img
                    src="https://images.pexels.com/photos/7579831/pexels-photo-7579831.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940">
            </div>

            <div class="email-content">
                <p>Bonjour {{$patient->sexe == 'M' ? 'Monsieur' : 'Madame'}} {{$patient->name}} votre RDV du {{$date}}
                    avec le docteur {{$doctor->name}} du service {{$doctor->service->libelle}} vient d’être confirmé
                </p>

                <p class="datetime">{{$today}}</p>

                <p class="merci">Cordialement<br> <strong>l'équipe médecins de nuit</strong></p>
            </div>
        </div>
    </div>
</body>

</html>