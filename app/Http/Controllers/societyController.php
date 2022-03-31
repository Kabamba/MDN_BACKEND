<?php

namespace App\Http\Controllers;

use App\Http\Resources\SocietyResource;
use Illuminate\Http\Request;
use App\Models\society;

class societyController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/societies/list",
     *    tags={"ADMINISTRATION__SOCIETIES"},
     *     summary="Liste des sociétés",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        $societies = society::all();

        return SocietyResource::collection($societies);
    }

    /**
     * @OA\Get(
     *     path="/admin/societies/categorie/{id}",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Renvoie les informations des societés d'une catégorie précise",
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
    public function SocietePerCategorie($id)
    {
        $societies = society::where('category_id',$id)->get();

        return SocietyResource::collection($societies);
    }

    /**
     * @OA\Post(
     *     path="/admin/societies/store",
     *     tags={"ADMINISTRATION__SOCIETIES"},
     *     summary="Enregistre une société",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "category_id",
     *                   type="integer",
     *                   example = 1
     *                  ),  
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Orange"
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
            "category_id" => "required",
            "libelle" => "required|unique:societies",
        ]);

        $society = new society();

        $society->category_id = $request->category_id;
        $society->libelle = $request->libelle;
        $society->save();

        return response(["message" => "Société enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/societies/show/{id}",
     *     tags={"ADMINISTRATION__SOCIETIES"},
     *     summary="Renvoie les informations d'une société par son ID",
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
        $society = society::where('id', $id)->first();

        if (!$society) {
            return response([
                "message" => "Société introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $society->id,
            "category" => $society->category->libelle,
            "category_id" => $society->category->id,
            "libelle" => $society->libelle,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/societies/update",
     *     tags={"ADMINISTRATION__SOCIETIES"},
     *     summary="Editer les informations d'une société",
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
     *                   property = "category_id",
     *                   type="integer",
     *                   example = 1
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
            "category_id" => "required",
            "libelle" => "required",
        ]);

        $society = society::where('id', $request->id)->first();

        if (!$society) {
            return response([
                "message" => "Société introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        $society->libelle = $request->libelle;
        $society->category_id = $request->category_id;
        $society->save();

        return response([
            "message" => "Société modifiée avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/societies/delete",
     *     tags={"ADMINISTRATION__SOCIETIES"},
     *     summary="Supprimer une société",
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

        $society = society::where('id', $request->id)->first();

        if (!$society) {
            return response([
                "message" => "Société introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $society->delete();

        return response([
            "message" => "Société supprimée avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
