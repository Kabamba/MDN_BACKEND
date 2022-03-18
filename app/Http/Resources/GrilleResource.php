<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class GrilleResource extends JsonResource
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
            'doctor_name' => $this->doctor->name,
            'conv' => $this->conv,
            'assur' => $this->assur,
            'prive' => $this->prive,
            'total' => $this->total
        ];
    }
}
