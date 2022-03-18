<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppointmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->string('titre');
            $table->text('raison')->nullable();
            $table->foreignId('recep_id')->constrained();
            $table->foreignId('doctor_id')->constrained();
            $table->date('date_enreg');
            $table->date('date_appoint');
            $table->dateTime('date_heure_appoint');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('appointments');
    }
}
