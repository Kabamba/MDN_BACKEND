<?php

namespace App\Rules;

use App\Models\patient;
use Illuminate\Contracts\Validation\Rule;

class PhoneMobileExistRule implements Rule
{
    
    public $id;

    /**
     * Create a new rule instance.
     *
     * @return void
     */
    public function __construct($id)
    {
        $this->id = $id;
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
        $exist = patient::where("telephone_mobile", $value)
        ->where('id','<>',$this->id)->first();

        if ($exist) {
            return false;
        }

        return true;
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Numéro de téléphone mobile déjà utilisé.';
    }
}
