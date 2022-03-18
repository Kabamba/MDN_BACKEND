<?php

namespace App\Http\Controllers;

use App\Http\Resources\AppointResource;
use App\Http\Resources\DateRdvResource;
use App\Jobs\ApproveJob;
use App\Jobs\MailJob;
use App\Models\Appointment;
use App\Models\date_rdv;
use App\Models\grille;
use App\Models\patient;
use App\Models\top;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AppointmentController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/appoints/one/{id}",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Affiche les détails d'un rendez-vous par son ID",
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
    public function getDetail($id)
    {
        $appoint = Appointment::find($id);

        return [
            "id" => $appoint->id,
            "motif" => $appoint->motif->libelle,
            "description" => $appoint->description,
            "observations" => $appoint->observations,
            "piece" => $appoint->piece,
            "date_heure" => $appoint->date_heure_appoint,
            "date" => date('d M Y, à H:i', strtotime($appoint->date_heure_appoint)),
            "recep_id" => $appoint->recept->id,
            "recep_name" => $appoint->recept->name,
            "patient_id" => $appoint->patient->id,
            "patient_initial" => substr($appoint->patient->name, 0, 3),
            "patient_name" => $appoint->patient->name,
            "patient_prenom" => $appoint->patient->prenom,
            "patient_telephone" => $appoint->patient->telephone,
            "patient_email" => $appoint->patient->email,
            "patient_sexe" => $appoint->patient->sexe,
            "doctor_id" => $appoint->doctor->id,
            "doctor_name" => $appoint->doctor->name,
            "approved" => $appoint->approved,
        ];
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listoday",
     *    tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous du jour",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function getAllToday()
    {

        $date = date('Y-m-d');

        $appoints = Appointment::where('date_appoint', $date)->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listfuture",
     *    tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous à venir",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function getAllFuture()
    {
        $date = date('Y-m-d');

        $appoints = Appointment::where('date_appoint', '>', $date)
            ->orderBy('date_appoint', 'ASC')
            ->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listlast",
     *    tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous passés",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function getAllLast()
    {
        $date = date('Y-m-d');

        $appoints = Appointment::where('date_appoint', '<', $date)->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listoday/{id}",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous du jour d'un docteur",
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
    public function getAllTodayDoctor($id)
    {
        $date = date('Y-m-d');

        $appoints = Appointment::where('doctor_id', $id)->where('date_appoint', $date)->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listfuture/{id}",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous à venir d'un docteur",
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
    public function getAllFutureDoctor($id)
    {
        $date = date('Y-m-d');

        $appoints = Appointment::where('doctor_id', $id)->where('date_appoint', '>', $date)->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listlast/{id}",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les rendez-vous passés d'un docteur",
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
    public function getAllLastDoctor($id)
    {
        $date = date('Y-m-d');

        $appoints = Appointment::where('doctor_id', $id)->where('date_appoint', '<', $date)->get();

        return AppointResource::collection($appoints);
    }

    /**
     * @OA\Post(
     *     path="/admin/appoints/store",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Enregistre un rendez-vous",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "motif",
     *                   type="string",
     *                   example = "Rencontre pour consulation"
     *                  ),
     *                @OA\Property(
     *                   property = "description",
     *                   type="string",
     *                   example = "Je ne me sens pas bien et je veux rencontrer mon docteur"
     *                  ),
     *                @OA\Property(
     *                   property = "recep_id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "doctor_id",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                 @OA\Property(
     *                   property = "patient_id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                 @OA\Property(
     *                   property = "date_heure_appoint",
     *                   type="dateTime",
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
    public function store(Request $request)
    {
        $request->validate([
            "motif" => "required",
            "description" => "required",
            "recep_id" => "required",
            "doctor_id" => "required",
            "patient_id" => "required",
            "date_heure_appoint" => "required",
        ]);

        $doctor = User::find($request->doctor_id);
        $date = date('w', strtotime($request->date_heure_appoint));


        // if ($request->date_heure_appoint < date('Y-m-d')) {
        //     return response([
        //         "message" => "La date choisie est déjà passée",
        //         "visibility" => false
        //     ], 200);
        // }

        $dispo_day = DB::table('user_day')
            ->where('user_id', $doctor->id)
            ->where('day_id', $date)
            ->first();

        if (!$dispo_day) {
            return response([
                "message" => "Vous avez selectionné un jour où ce docteur ne travail pas",
                "visibility" => false
            ], 200);
        }


        $temps = date('H:i', strtotime($request->date_heure_appoint));

        $dispo_time = DB::table('user_day')
            ->where('user_id', $doctor->id)
            ->where('day_id', $date)
            ->where('heure_deb', '<=', $temps)
            ->where('heure_fin', '>=', $temps)
            ->first();

        if (!$dispo_time) {
            return response([
                "message" => "Vous avez selectionné une heure où ce docteur ne travail pas",
                "visibility" => false
            ], 200);
        }

        $occuped = Appointment::where('doctor_id', $doctor->id)
            ->where('date_heure_appoint', $request->date_heure_appoint)
            ->first();

        if ($occuped) {
            return response([
                "message" => "Vous avez selectionné une heure où ce docteur est déjà pris par un autre rendez-vous",
                "visibility" => false
            ], 200);
        }

        $temp_appoint = date('Y-m-d', strtotime($request->date_heure_appoint));

        $top = top::where('doctor_id', $doctor->id)
            ->where('date_appoint', $temp_appoint)
            ->first();

        if ($top) {
            $increment = $top->max_patient + 1;

            if ($increment > $dispo_day->max_patient) {
                return response([
                    "message" => "Ce docteur a atteint le nombre maximum des rendez-vous pour le jour selectionné",
                    "visibility" => false
                ], 200);
            } else {
                $top->max_patient = $increment;
                $top->save();
            }
        } else {
            $atteint = new top();

            $atteint->doctor_id = $doctor->id;
            $atteint->date_appoint = $request->date_heure_appoint;
            $atteint->max_patient = 1;
            $atteint->save();
        }

        $appoint = new Appointment();

        $appoint->motif_id = $request->motif;
        $appoint->description = $request->description;
        $appoint->recep_id = $request->recep_id;
        $appoint->doctor_id = $request->doctor_id;
        $appoint->patient_id = $request->patient_id;
        $appoint->date_enreg = now();
        $appoint->date_appoint = $request->date_heure_appoint;
        $appoint->date_heure_appoint = $request->date_heure_appoint;
        $appoint->save();

        $patient = patient::find($request->patient_id);
        $doctors = user::find($request->doctor_id);
        $appoints = Appointment::find($appoint->id);

        MailJob::dispatch($patient, $doctors, $appoints);

        return response(["message" => "Rendez-vous enregistré avec succés", "visibility" => true], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/appoints/dispo",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Recherche l'horaire d'un docteur pour un jour",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "day_id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "doctor_id",
     *                   type="integer",
     *                   example = 2
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
    public function dispo(Request $request)
    {
        $request->validate([
            "doctor_id" => "required",
            "day_id" => "required",
        ]);

        $schedule = DB::table('user_day')
            ->where('user_id', $request->doctor_id)
            ->where('day_id', $request->day_id)
            ->first();

        return $schedule;
    }

    /**
     * @OA\Post(
     *     path="/admin/appoints/saveschdule",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Enregistrer l'horaire d'un docteur pour un jour précis",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "day_id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "doctor_id",
     *                   type="integer",
     *                   example = 2
     *                  ),
     *                @OA\Property(
     *                   property = "heure_deb",
     *                   type="string",
     *                   example = "09:10"
     *                  ),
     *                @OA\Property(
     *                   property = "heure_fin",
     *                   type="string",
     *                   example = "16:37"
     *                  ),
     *                @OA\Property(
     *                   property = "max_pat",
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
    public function saveSchedule(Request $request)
    {
        $request->validate([
            "doctor_id" => "required",
            "day_id" => "required",
            "heure_deb" => "required",
            "heure_fin" => "required",
            "max_pat" => "required"
        ]);

        $schedule = DB::table('user_day')
            ->where('user_id', $request->doctor_id)
            ->where('day_id', $request->day_id)
            ->first();

        if ($schedule) {
            DB::table('user_day')
                ->where('user_id', $schedule->user_id)
                ->where('day_id', $schedule->day_id)
                ->update(
                    [
                        'heure_deb' => $request->heure_deb,
                        'heure_fin' => $request->heure_fin,
                        'max_patient' => $request->max_pat,
                    ]
                );
        } else {
            DB::table('user_day')->insert(
                [
                    'user_id' => $request->doctor_id,
                    'day_id' => $request->day_id,
                    'heure_deb' => $request->heure_deb,
                    'heure_fin' => $request->heure_fin,
                    'max_patient' => $request->max_pat,
                ]
            );
        }

        return response(["message" => "Horaire sauvegardé avec succés"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/listschedule/{id}",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Affiche l'horaire d'un docteur par son ID",
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
    public function listeSchedule($id)
    {
        $doctor = new User();

        $horaire = $doctor->with('days')->where('id', $id)->where('admin_level', 2)->first();

        return $horaire;
    }

    /**
     * @OA\Post(
     *     path="/admin/appoints/approuver",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Approuve un RDV",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "id",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "observations",
     *                   type="string",
     *                   example = "OK"
     *                  ),
     *                @OA\Property(
     *                   property = "piece",
     *                   type="file"
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
    public function approuver(Request $request)
    {
        $request->validate([
            'id' => 'required'
        ]);

        $appoint = Appointment::find($request->id);

        if (!$appoint) {
            return response([
                "message" => "Rendez-vous introuvable",
                "visibility" => false
            ], 404);
        }

        // if ($appoint->approved == 1) {
        //     return response([
        //         "message" => "Rendez-vous introuvable",
        //         "visibility" => false
        //     ], 404);
        // }

        $appoint->approved = 1;

        if (!empty($request->observations)) {
            $appoint->observations = $request->observations;
        }

        $image = $request->file('piece');

        if (!empty($image)) {

            $completeFileName = $image->getClientOriginalName();

            $completeFileName = $image->getClientOriginalName();
            $fileNameOnly = pathinfo($completeFileName, PATHINFO_FILENAME);
            $extension = $image->getClientOriginalExtension();
            $compPic = str_replace(' ', '_', $fileNameOnly) . '_' . rand() . '_' . time() . '.' . $extension;
            $image->storeAs('public/rdv', $compPic);

            $appoint->piece = $compPic;
        }

        $appoint->save();

        $patient = patient::find($appoint->patient_id);

        $date = date('Y-m-d');

        $grille = grille::where('doctor_id', $appoint->doctor_id)
            ->where('date_rdv', $appoint->date_appoint)
            ->first();

        $exist_daterdv = date_rdv::where('dates', $appoint->date_appoint)->first();


        if ($exist_daterdv) {

            if ($patient->category_id == 1) {
                $exist_daterdv->prive += 1;
            }

            if ($patient->category_id == 2) {
                $exist_daterdv->assur += 1;
            }

            if ($patient->category_id == 3) {
                $exist_daterdv->conv += 1;
            }
            $exist_daterdv->total += 1;
            $exist_daterdv->save();
        } else {
           
            $nouv_date_rdv = new date_rdv();

            if ($patient->category_id == 1) {
                $nouv_date_rdv->prive += 1;
            }

            if ($patient->category_id == 2) {
                $nouv_date_rdv->assur += 1;
            }

            if ($patient->category_id == 3) {
                $nouv_date_rdv->conv += 1;
            }

            $nouv_date_rdv->total += 1;
            $nouv_date_rdv->dates = $appoint->date_appoint;
            $nouv_date_rdv->save();
        }



        if ($grille) {
            if ($patient->category_id == 1) {
                $grille->prive += 1;
            }

            if ($patient->category_id == 2) {
                $grille->assur += 1;
            }

            if ($patient->category_id == 3) {
                $grille->conv += 1;
            }

            $grille->doctor_id = $appoint->doctor_id;
            $grille->total += 1;
            $grille->date_rdv_id = $exist_daterdv->id;
            $grille->date_rdv = $exist_daterdv->dates;
            $grille->save();

        } else {
            $nouv_grille = new grille();

            if ($patient->category_id == 1) {
                $nouv_grille->prive += 1;
            }

            if ($patient->category_id == 2) {
                $nouv_grille->assur += 1;
            }

            if ($patient->category_id == 3) {
                $nouv_grille->conv += 1;
            }

            $nouv_grille->doctor_id = $appoint->doctor_id;
            $nouv_grille->total += 1;

            if ($exist_daterdv) {
                $nouv_grille->date_rdv_id = $exist_daterdv->id;
            }else{
                $nouv_grille->date_rdv_id = $nouv_date_rdv->id;
            }

            $nouv_grille->date_rdv = $appoint->date_appoint;
            $nouv_grille->save();
        }

        ApproveJob::dispatch($patient);

        return response([
            "message" => "Rendez-vous approuvé",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/appoints/grille/all",
     *    tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les docteurs et leurs rendez-vous sous forme de grille avec un total",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function grilleAll()
    {
        $appoints = date_rdv::all();

        return DateRdvResource::collection($appoints);
    }

    /**
     * @OA\Post(
     *     path="/admin/appoints/grille/date",
     *     tags={"ADMINISTRATION__RDV"},
     *     summary="Liste les docteurs et leurs rendez-vous sous forme de grille avec un total à partir d'une date début et fin",
     *     description="",
     *     @OA\RequestBody(
     *         required=false,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "date_deb",
     *                   type="date",
     *                   example = "2022-02-05"
     *                  ),
     *                @OA\Property(
     *                   property = "date_fin",
     *                   type="date",
     *                   example = "2022-02-18"
     *                  )
     *              )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function grilleDate(Request $request)
    {
        $request->validate([
            "date_deb" => "required|date",
            "date_fin" => "required|date"
        ]);

        $appoints = date_rdv::whereBetween('dates', [$request->date_deb, $request->date_fin])->get();

        return DateRdvResource::collection($appoints);
    }
}
