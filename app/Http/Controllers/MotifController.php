<?php

namespace App\Http\Controllers;

use App\Models\Motif;
use Illuminate\Http\Request;

class MotifController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/motifs/list",
     *    tags={"ADMINISTRATION__MOTIFS"},
     *     summary="Liste des motifs",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        return Motif::all();
    }

    /**
     * @OA\Post(
     *     path="/admin/motifs/store",
     *     tags={"ADMINISTRATION__MOTIFS"},
     *     summary="Enregistre un motif",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Consultation labo"
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
            "libelle" => "required|unique:motifs",
        ]);

        $motif = new motif();

        $motif->libelle = $request->libelle;
        $motif->save();

        return response(["message" => "Motif enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/motifs/show/{id}",
     *     tags={"ADMINISTRATION__MOTIFS"},
     *     summary="Renvoie les informations d'une consultation par son ID",
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
        $motif = motif::where('id', $id)->first();

        if (!$motif) {
            return response([
                "message" => "Motif introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $motif->id,
            "libelle" => $motif->libelle,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/motifs/update",
     *     tags={"ADMINISTRATION__MOTIFS"},
     *     summary="Editer les informations d'un motif",
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
     *                   example = "Consultation pédiatrie"
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

        $motif = motif::where('id', $request->id)->first();

        if (!$motif) {
            return response([
                "message" => "Motif introuvable",
                "type" => "danger",
                "visibility" => false
            ], 404);
        }

        $motif->libelle = $request->libelle;
        $motif->save();

        return response([
            "message" => "Motif modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/motifs/delete",
     *     tags={"ADMINISTRATION__MOTIFS"},
     *     summary="Supprimer un motif",
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

        $user = Motif::where('id', $request->id)->first();

        if (!$user) {
            return response([
                "message" => "Motif introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Motif supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
