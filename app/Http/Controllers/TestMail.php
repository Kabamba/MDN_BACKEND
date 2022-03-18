<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class TestMail extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/mail/test",
     *    tags={"ADMINISTRATION__MAIL"},
     *     summary="Envoie un mail",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function envoyer()
    {
        $token = "123456";
        $email = "enockmulamba1802@gmail.com";

        Mail::send('mail.password_reset_mail', ['token' => $token], function ($message) {
            $message->to("enockmulamba1802@gmail.com");
            $message->subject('Rénitialisation du mot de passe');
        });

        return response(["message" => "Mail envoyé avec succés"], 200);
    }
}
