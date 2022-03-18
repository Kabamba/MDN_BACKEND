<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateGrillesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('grilles', function (Blueprint $table) {
            $table->id();
            $table->date('date_rdv');
            $table->foreignId('doctor_id')->constrained();
            $table->integer('conv');
            $table->integer('assur');
            $table->integer('prive');
            $table->integer('total');
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
        Schema::dropIfExists('grilles');
    }
}
