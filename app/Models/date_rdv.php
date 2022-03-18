<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class date_rdv extends Model
{
    use HasFactory;

    public function grilles()
    {
        return $this->hasMany(grille::class);
    }
}
