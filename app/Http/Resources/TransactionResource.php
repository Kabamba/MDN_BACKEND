<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class TransactionResource extends JsonResource
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
            "montant" => $this->montant,
            "date_trans" => $this->date_trans,
            "date_time_trans" => $this->date_time_trans,
            "billing_id" => $this->billing_id,
            "reference" => $this->reference,
            "status" => $this->status,
            "type_trans" => $this->type_trans,
            "paie_syst" => $this->paie_syst,
            "user" => UserResource::make($this->user),
            "country" => $this->country
        ];
    }
}
