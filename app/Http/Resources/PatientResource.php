<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PatientResource extends JsonResource
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
            "pays_natal" => $this->natale->name ?? '',
            "pays_residence" => $this->residence->name ?? '',
            "doctor" => $this->doctor->name ?? '',
            "category" => $this->category->libelle,
            "society" => $this->society->libelle,
            "num_dossier" => $this->num_dossier,
            "nom" => $this->nom,
            "prenom" => $this->prenom,
            "date_naiss" => $this->date_naiss,
            "lieu_naiss" => $this->lieu_naiss,
            "num_carte" => $this->num_carte_ident,
            "langue" => $this->langue,
            "sexe" => $this->sexe,
            "etat_civil" => $this->etat_civil,
            "adresse" => $this->adresse,
            "boite_post" => $this->boite_postal,
            "email" => $this->email,
            "telephone_fixe" => $this->telephone_fixe,
            "telephone_mobile" => $this->telephone_mobile,
            "profession" => $this->profession,
        ];
    }
}
