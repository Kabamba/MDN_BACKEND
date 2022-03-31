<?php

namespace App\Http\Controllers;

use App\Http\Resources\PatientResource;
use App\Models\patient;
use App\Models\pays;
use App\Rules\DossierExistRule;
use App\Rules\EmailExistRule;
use App\Rules\PhoneFixeExistRule;
use App\Rules\PhoneMobileExistRule;
use Illuminate\Http\Request;

class PatientController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/patients/list",
     *    tags={"ADMINISTRATION__PATIENT"},
     *     summary="Liste des patients",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        $patients = patient::all();

        return PatientResource::collection($patients);
    }

    /**
     * @OA\Get(
     *     path="/admin/pays/list",
     *    tags={"ADMINISTRATION__PAYS"},
     *     summary="Liste des pays",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function pays()
    {
        return pays::all();
    }

    /**
     * @OA\Post(
     *     path="/admin/patients/store",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Enregistre un patient",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "pays_natal",
     *                   type="integer",
     *                   example = 50
     *                  ),
     *                @OA\Property(
     *                   property = "pays_residence",
     *                   type="integer",
     *                   example = 50
     *                  ),
     *                @OA\Property(
     *                   property = "docteur",
     *                   type="integer",
     *                   example = 3
     *                  ),
     *                @OA\Property(
     *                   property = "category",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                @OA\Property(
     *                   property = "society",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                @OA\Property(
     *                   property = "num_dossier",
     *                   type="string",
     *                   example = "23650000"
     *                  ),
     *                @OA\Property(
     *                   property = "nom",
     *                   type="string",
     *                   example = "Kabamba"
     *                  ),
     *                 @OA\Property(
     *                   property = "prenom",
     *                   type="string",
     *                   example = "Enock"
     *                  ),
     *                @OA\Property(
     *                   property = "date_naiss",
     *                   type="date",
     *                   example = "2022-02-08"
     *                  ),
     *                @OA\Property(
     *                   property = "lieu_naiss",
     *                   type="string",
     *                   example = "Mbuji-mayi"
     *                  ),
     *                @OA\Property(
     *                   property = "num_carte",
     *                   type="string",
     *                   example = "430256AKJNDJKDK"
     *                  ),
     *                 @OA\Property(
     *                   property = "langue",
     *                   type="string",
     *                   example = "Français"
     *                  ),
     *                @OA\Property(
     *                   property = "sexe",
     *                   type="string",
     *                   example = "M"
     *                  ),
     *                @OA\Property(
     *                   property = "etat_civil",
     *                   type="string",
     *                   example = "Célibataire"
     *                  ),
     *                @OA\Property(
     *                   property = "adresse",
     *                   type="string",
     *                   example = "N°5 Av/Bukasa Q/Socopao C/Limete"
     *                  ),
     *                @OA\Property(
     *                   property = "boite_postal",
     *                   type="string",
     *                   example = "3400"
     *                  ),
     *                @OA\Property(
     *                   property = "email",
     *                   type="string",
     *                   example = "enockmulamba1802@gmail.com"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone_fixe",
     *                   type="string",
     *                   example = "+2438522000"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone_mobile",
     *                   type="string",
     *                   example = "+243852277379"
     *                  ),
     *                @OA\Property(
     *                   property = "profession",
     *                   type="string",
     *                   example = "Developpeur"
     *                  ),
     *              
     *              )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function store(Request $request)
    {
        $request->validate([
            "nom" => "required",
            "prenom" => "required",
            "date_naiss" => "required",
            "telephone_mobile" => "required|unique:patients",
            "adresse" => "required",
            "sexe" => "required",
            "category" => "required",
            "society" => "required",
            "email" => "nullable|unique:patients",
            "telephone_fixe" => "nullable|unique:patients",
            "num_dossier" => "nullable|unique:patients"
        ]);

        $patient = new patient();

        $patient->nom = $request->nom;
        $patient->prenom = $request->prenom;
        $patient->date_naiss = $request->date_naiss;
        $patient->telephone_mobile = $request->telephone_mobile;
        $patient->adresse = $request->adresse;
        $patient->sexe = $request->sexe;
        $patient->category_id = $request->categor;
        $patient->society_id = $request->society;

        $patient->pays_id = $request->pays_natal ?? '';
        $patient->residence_id = $request->pays_residence ?? '';
        $patient->user_id = $request->docteur ?? '';
        $patient->num_dossier = $request->num_dossier ?? '';
        $patient->lieu_naiss = $request->lieu_naiss ?? '';
        $patient->num_carte_ident = $request->num_carte ?? '';
        $patient->langue = $request->langue ?? '';
        $patient->etat_civil = $request->etat_civil ?? '';
        $patient->boite_postal = $request->boite_postal ?? '';
        $patient->email = $request->email ?? '';
        $patient->telephone_fixe = $request->telephone_fixe ?? '';
        $patient->profession = $request->profession ?? '';

        $patient->save();

        return response(["message" => "Patient enregistré avec succes"], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/patients/update",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Modifie les informations d'un patient",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *               @OA\Property(
     *                   property = "id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "pays_natal",
     *                   type="integer",
     *                   example = 50
     *                  ),
     *                @OA\Property(
     *                   property = "pays_residence",
     *                   type="integer",
     *                   example = 50
     *                  ),
     *                @OA\Property(
     *                   property = "docteur",
     *                   type="integer",
     *                   example = 3
     *                  ),
     *                @OA\Property(
     *                   property = "category",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                @OA\Property(
     *                   property = "society",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                @OA\Property(
     *                   property = "num_dossier",
     *                   type="string",
     *                   example = "23650000"
     *                  ),
     *                @OA\Property(
     *                   property = "nom",
     *                   type="string",
     *                   example = "Kabamba"
     *                  ),
     *                 @OA\Property(
     *                   property = "prenom",
     *                   type="string",
     *                   example = "Enock"
     *                  ),
     *                @OA\Property(
     *                   property = "date_naiss",
     *                   type="date",
     *                   example = "2022-02-08"
     *                  ),
     *                @OA\Property(
     *                   property = "lieu_naiss",
     *                   type="string",
     *                   example = "Mbuji-mayi"
     *                  ),
     *                @OA\Property(
     *                   property = "num_carte",
     *                   type="string",
     *                   example = "430256AKJNDJKDK"
     *                  ),
     *                 @OA\Property(
     *                   property = "langue",
     *                   type="string",
     *                   example = "Français"
     *                  ),
     *                @OA\Property(
     *                   property = "sexe",
     *                   type="string",
     *                   example = "M"
     *                  ),
     *                @OA\Property(
     *                   property = "etat_civil",
     *                   type="string",
     *                   example = "Célibataire"
     *                  ),
     *                @OA\Property(
     *                   property = "adresse",
     *                   type="string",
     *                   example = "N°5 Av/Bukasa Q/Socopao C/Limete"
     *                  ),
     *                @OA\Property(
     *                   property = "boite_postal",
     *                   type="string",
     *                   example = "3400"
     *                  ),
     *                @OA\Property(
     *                   property = "email",
     *                   type="string",
     *                   example = "enockmulamba1802@gmail.com"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone_fixe",
     *                   type="string",
     *                   example = "+2438522000"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone_mobile",
     *                   type="string",
     *                   example = "+243852277379"
     *                  ),
     *                @OA\Property(
     *                   property = "profession",
     *                   type="string",
     *                   example = "Developpeur"
     *                  ),
     *              
     *              )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function update(Request $request)
    {
        $request->validate([
            "id" => "required",
            "nom" => "required",
            "prenom" => "required",
            "date_naiss" => "required",
            "telephone_mobile" => ["required", new PhoneMobileExistRule($request->id)],
            "adresse" => "required",
            "sexe" => "required",
            "category" => "required",
            "society" => "required",
            "email" => ["nullable", new EmailExistRule($request->id)],
            "telephone_fixe" => ["nullable", new PhoneFixeExistRule($request->id)],
            "num_dossier" => ["nullable", new DossierExistRule($request->id)]
        ]);

        $patient = patient::find($request->id);

        if (!$patient) {
            return response([
                "message" => "Patient introuvable",
                "visibility" => false
            ], 404);
        }

        $patient->nom = $request->nom;
        $patient->prenom = $request->prenom;
        $patient->date_naiss = $request->date_naiss;
        $patient->telephone_mobile = $request->telephone_mobile;
        $patient->adresse = $request->adresse;
        $patient->sexe = $request->sexe;
        $patient->category_id = $request->category;
        $patient->society_id = $request->society;

        $patient->pays_id = $request->pays_natal ?? '';
        $patient->residence_id = $request->pays_residence ?? '';
        $patient->user_id = $request->docteur ?? '';
        $patient->num_dossier = $request->num_dossier ?? '';
        $patient->lieu_naiss = $request->lieu_naiss ?? '';
        $patient->num_carte_ident = $request->num_carte ?? '';
        $patient->langue = $request->langue ?? '';
        $patient->etat_civil = $request->etat_civil ?? '';
        $patient->boite_postal = $request->boite_postal ?? '';
        $patient->email = $request->email ?? '';
        $patient->telephone_fixe = $request->telephone_fixe ?? '';
        $patient->profession = $request->profession ?? '';

        $patient->save();

        return response(["message" => "Patient enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/patients/show/{id}",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Renvoie les informations d'un patient par son ID",
     *      @OA\Parameter(
     *          name = "id",
     *          required = true,
     *          in = "path",
     *          example = 18,
     *          @OA\Schema(type="integer")
     *      ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function show($id)
    {
        $patient = patient::where('id', $id)->first();

        if (!$patient) {
            return response([
                "message" => "Patient introuvable",
                "visibility" => false
            ], 404);
        }

        return PatientResource::make($patient);
    }

    /**
     * @OA\Post(
     *     path="/admin/patients/search",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Recherche un patient",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "search",
     *                   type="string",
     *                   example = "Lucas"
     *                  ),
     *              )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function search(Request $request)
    {
        $request->validate([
            'search' => 'required',
        ]);

        if (!empty($request->search)) {
            $patients = patient::where('nom', 'like', '%' . $request->search . '%')
                ->orWhere('prenom', 'like', '%' . $request->search . '%')->get();

            return $patients;
        }
    }


    /**
     * @OA\Post(
     *     path="/admin/patients/delete",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Supprimer un patient",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *            mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "id",
     *                   type="integer",
     *                   example = 10
     *                  ),
     *              )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function delete(Request $request)
    {
        $request->validate([
            "id" => "required"
        ]);

        $patient = patient::where('id', $request->id)->first();

        if (!$patient) {
            return response([
                "message" => "Patient introuvable",
                "visibility" => false
            ], 200);
        }

        $patient->delete();

        return response([
            "message" => "Patient supprimé avec succés",
            "visibility" => true
        ], 200);
    }
}
