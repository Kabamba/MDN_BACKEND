<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var string[]
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function country()
    {
        return $this->belongsTo(country::class, "country_id", "id");
    }

    public function service()
    {
        return $this->belongsTo(service::class);
    }

    public function role()
    {
        return $this->belongsTo(role::class);
    }

    public function days()
    {
        return $this->belongsToMany(day::class,'user_day')->withPivot('heure_deb','heure_fin','max_patient');
    }

    public function appointements()
    {
        return $this->hasMany(Appointment::class, 'doctor_id');
    }
}