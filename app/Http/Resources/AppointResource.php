<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class AppointResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "motif" => $this->motif->libelle,
            "description" => $this->description,
            "date_enreg" => $this->date_enreg,
            "date_heure" => $this->date_heure_appoint,
            "date" => date('d M Y, H:i',strtotime($this->date_heure_appoint)),
            "recep_id" => $this->recept->id,
            "recep_name" => $this->recept->name,
            "patient_id" => $this->patient->id,
            "patient_initial" => substr($this->patient->name,0,3),
            "patient_name" => $this->patient->name,
            "doctor_id" => $this->doctor->id,
            "doctor_name" => $this->doctor->name,
            "motif" => $this->motif->libelle,
            "approved" => $this->approved,
        ];
    }
}
