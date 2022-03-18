<?php

namespace App\Http\Controllers;

use App\Models\service;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ServiceController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/services/list",
     *    tags={"ADMINISTRATION__SERVICES"},
     *     summary="Liste des services",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        return service::all();
    }

    /**
     * @OA\Post(
     *     path="/admin/services/store",
     *     tags={"ADMINISTRATION__SERVICES"},
     *     summary="Enregistre un service",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Pédiatrie"
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
            "libelle" => "required|unique:services",
        ]);

        $service = new service();

        $service->libelle = $request->libelle;
        $service->save();

        return response(["message" => "Service enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/services/show/{id}",
     *     tags={"ADMINISTRATION__SERVICES"},
     *     summary="Renvoie les informations d'un service par son ID",
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
        $service = service::where('id', $id)->first();

        if (!$service) {
            return response([
                "message" => "Service introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $service->id,
            "libelle" => $service->libelle,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/services/update",
     *     tags={"ADMINISTRATION__SERVICES"},
     *     summary="Editer les informations d'un service",
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
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Radiologie"
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
    public function update(Request $request)
    {
        $request->validate([
            "id" => "required",
            "libelle" => "required",
        ]);

        $service = service::where('id', $request->id)->first();

        if (!$service) {
            return response([
                "message" => "Service introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        $service->libelle = $request->libelle;
        $service->save();

        return response([
            "message" => "Service modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/services/delete",
     *     tags={"ADMINISTRATION__SERVICES"},
     *     summary="Supprimer un service",
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

        $user = service::where('id', $request->id)->first();

        if (!$user) {
            return response([
                "message" => "Service introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Service supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

}
