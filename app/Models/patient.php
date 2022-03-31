<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class patient extends Model
{
    use HasFactory;

    public function appointements()
    {
        return $this->hasMany(Appointment::class);
    }

    public function residence()
    {
        return $this->belongsTo(pays::class, 'residence_id');
    }

    public function natale()
    {
        return $this->belongsTo(pays::class, 'pays_id');
    }

    public function doctor()
    {
        return $this->belongsTo(user::class, 'user_id');
    }

    public function category()
    {
        return $this->belongsTo(category::class);
    }

    public function society()
    {
        return $this->belongsTo(society::class);
    }
}
