<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class DateRdvResource extends JsonResource
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
            'id' => $this->id,
            'conv' => $this->conv,
            'assur' => $this->assur,
            'prive' => $this->prive,
            'total' => $this->total,
            setlocale(LC_ALL, 'fr'),
            'date_rdv' => ucfirst(strftime('%A %d/%m/%y',strtotime($this->dates))),
            'appoints' => GrilleResource::collection($this->grilles)
        ];
    }
}
