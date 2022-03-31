<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Patient extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('patients', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pays_id')->constrained();
            $table->foreignId('residence_id')->constrained();
            $table->foreignId('user_id')->constrained();
            $table->foreignId('category_id')->constrained();
            $table->foreignId('society_id')->constrained()->default(1);
            $table->string('num_dossier')->nullable();
            $table->string('nom');
            $table->string('prenom');
            $table->string('date_naiss');
            $table->string('lieu_naiss')->nullable();
            $table->string('num_carte_ident')->nullable();
            $table->string('langue')->nullable();
            $table->char('sexe',1);
            $table->string('etat_civil')->nullable();
            $table->string('commentaire')->nullable();
            $table->string('adresse')->nullable();
            $table->string('boite_postal')->nullable();
            $table->string('email')->nullable();
            $table->string('telephone_fixe')->nullable();
            $table->string('telephone_mobile');
            $table->string('profession');
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
        //
    }
}
