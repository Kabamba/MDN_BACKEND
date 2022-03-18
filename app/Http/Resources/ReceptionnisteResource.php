<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ReceptionnisteResource extends JsonResource
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
            "name" => $this->name,
            "email" => $this->email,
            "telephone" => $this->telephone,
            "status" => $this->is_active,
            "role" => $this->role->libelle,
            "role_id" => $this->role->id,
            "permissions" => PermissionResource::collection($this->role->permissions),
        ];
    }
}
