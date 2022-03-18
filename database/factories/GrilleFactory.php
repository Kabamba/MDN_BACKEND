<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class GrilleFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'date_rdv' => $this->faker->dateTimeBetween(),
            'doctor_id' => $this->faker->numberBetween(1, 2),
            'conv' => $this->faker->numberBetween(1, 2),
        ];
    }
}
