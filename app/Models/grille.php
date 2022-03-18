<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class grille extends Model
{
    use HasFactory;

    public function doctor()
    {
        return $this->belongsTo(user::class);
    }

    public function date_rdv()
    {
        return $this->belongsTo(date_rdv::class);
    }
}
