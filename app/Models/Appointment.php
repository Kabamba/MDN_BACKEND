<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    use HasFactory;

    public function patient()
    {
        return $this->belongsTo(patient::class);
    }

    public function recept()
    {
        return $this->belongsTo(user::class, 'recep_id');
    }

    public function doctor()
    {
        return $this->belongsTo(user::class, 'doctor_id');
    }

    public function motif()
    {
        return $this->belongsTo(motif::class);
    }
}
