<?php

namespace App\Jobs;

use App\Models\Appointment;
use App\Models\patient;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;

class MailJob implements ShouldQueue
{
  use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

  public $patient;
  public $doctor;
  public $appoint;
  /**
   * Create a new job instance.
   *
   * @return void
   */
  public function __construct(patient $patient, User $doctor, Appointment $appoint)
  {
    $this->patient = $patient;
    $this->doctor = $doctor;
    $this->appoint = $appoint;
  }

  /**
   * Execute the job.
   *
   * @return void
   */
  public function handle()
  {

    $civilite = $this->patient->sexe == 'M' ? 'Monsieur' : 'Madame';
    $date =  date('d M Y, à H:i', strtotime($this->appoint->date_heure_appoint));
    $today = date('D, d/Y H:i');

    $curl = curl_init();

    curl_setopt_array($curl, array(
      CURLOPT_URL => "https://api.ultramsg.com/instance2505/messages/chat",
      CURLOPT_RETURNTRANSFER => true,
      CURLOPT_SSL_VERIFYHOST => false,
      CURLOPT_SSL_VERIFYHOST => 0,
      CURLOPT_SSL_VERIFYPEER => 0,
      CURLOPT_ENCODING => "",
      CURLOPT_MAXREDIRS => 10,
      CURLOPT_TIMEOUT => 30,
      CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
      CURLOPT_CUSTOMREQUEST => "POST",
      CURLOPT_POSTFIELDS => "token=popztl98o6w9pwp5&to={$this->patient->telephone}&body=Bonjour {$civilite} {$this->patient->name} votre RDV du {$date} avec le docteur {$this->doctor->name} du service {$this->doctor->service->libelle} vient d’être confirmé, Cordialement &priority=10&referenceId=",
      CURLOPT_HTTPHEADER => array(
        "content-type: application/x-www-form-urlencoded"
      ),
    ));

    $response = curl_exec($curl);
    $err = curl_error($curl);

    curl_close($curl);

    if ($err) {
      echo "cURL Error #:" . $err;
    } else {
      echo $response;
    }

    // Mail::send('mail.password_reset_mail', ['patient' => $this->patient, 'doctor' => $this->doctor, 'date' => $date, "today" => $today], function ($message) {
    //     $message->to($this->patient->email);
    //     $message->subject('Confirmation de la prise de rendez-vous');
    // });
  }
}
