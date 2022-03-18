<?php

namespace App\Jobs;

use App\Models\patient;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class ApproveJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $patient;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct(patient $patient)
    {
        $this->patient = $patient;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $civilite = $this->patient->sexe == 'M' ? 'Monsieur' : 'Madame';
     
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
            CURLOPT_POSTFIELDS => "token=popztl98o6w9pwp5&to={$this->patient->telephone}&body=Merci {$civilite} {$this->patient->name} de nous avoir fait confiance vous recevrez vos résultats dans les brefs délais Cordialement &priority=10&referenceId=",
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
    }
}
