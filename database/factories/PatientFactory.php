<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PatientFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'matricule' => $this->faker->numberBetween(1005,1000000000000),
            'name' => $this->faker->name(),
            'prenom' => $this->faker->firstName(),
            'telephone' => $this->faker->phoneNumber(),
            'email' => $this->faker->unique()->safeEmail(),
            'category_id' => $this->faker->numberBetween(1,3),
            'society_id' => $this->faker->numberBetween(1,4),
        ];
    }
}
