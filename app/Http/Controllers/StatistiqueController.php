<?php

namespace App\Http\Controllers;

use App\Models\Appointment;
use Illuminate\Http\Request;

class StatistiqueController extends Controller
{

    public function getToday()
    {
        return date('Y-m-d');
    }

    /**
     * @OA\Get(
     *     path="/admin/stats/totrdv",
     *    tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function totRdv()
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())->count();

        return $appoints;
    }

    /**
     * @OA\Get(
     *     path="/admin/stats/totrdvappr",
     *    tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour approuvés",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function totRdvApprov()
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())
            ->where('approved', 1)->count();

        return $appoints;
    }
    
    /**
     * @OA\Get(
     *     path="/admin/stats/totrdvatt",
     *    tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour approuvés",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function totRdvAttente()
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())
            ->where('approved', 1)->count();

        return $appoints;
    }

    /**
     * @OA\Get(
     *     path="/admin/stats/totrdv/{id}",
     *     tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour d'un docteur",
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
    public function totRdvDoc($id)
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())
            ->where('doctor_id', $id)
            ->count();

        return $appoints;
    }

    /**
     * @OA\Get(
     *     path="/admin/stats/totrdvapprov/{id}",
     *     tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour approuvés d'un docteur",
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
    public function totRdvApprovDoc($id)
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())
            ->where('doctor_id', $id)
            ->where('approved', 1)->count();

        return $appoints;
    }

    /**
     * @OA\Get(
     *     path="/admin/stats/totrdvattent/{id}",
     *     tags={"ADMINISTRATION__STATISTIQUES"},
     *     summary="Total des rendez-vous du jour en attentes d'un docteur",
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
    public function totRdvAttenteDoc($id)
    {
        $appoints = Appointment::where('date_appoint', $this->getToday())
            ->where('doctor_id', $id)
            ->where('approved', 0)->count();

        return $appoints;
    }
}
