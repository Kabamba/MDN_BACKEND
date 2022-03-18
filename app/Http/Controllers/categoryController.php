<?php

namespace App\Http\Controllers;

use App\Models\category;
use Illuminate\Http\Request;

class categoryController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/categories/list",
     *    tags={"ADMINISTRATION__CATEGORIES"},
     *     summary="Liste des catégories",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        return category::all();
    }

    /**
     * @OA\Post(
     *     path="/admin/categories/store",
     *     tags={"ADMINISTRATION__CATEGORIES"},
     *     summary="Enregistre une catégorie",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Privé"
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
            "libelle" => "required|unique:categories",
        ]);

        $category = new category();

        $category->libelle = $request->libelle;
        $category->save();

        return response(["message" => "Catégorie enregistrée avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/categories/show/{id}",
     *     tags={"ADMINISTRATION__CATEGORIES"},
     *     summary="Renvoie les informations d'une catégorie par son ID",
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
        $category = category::where('id', $id)->first();

        if (!$category) {
            return response([
                "message" => "Catégorie introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $category->id,
            "libelle" => $category->libelle,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/categories/update",
     *     tags={"ADMINISTRATION__CATEGORIES"},
     *     summary="Editer les informations d'une catégorie",
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
     *                   example = "Associé"
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

        $category = category::where('id', $request->id)->first();

        if (!$category) {
            return response([
                "message" => "catégorie introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        $category->libelle = $request->libelle;
        $category->save();

        return response([
            "message" => "Catégorie modifiée avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/categories/delete",
     *     tags={"ADMINISTRATION__CATEGORIES"},
     *     summary="Supprimer une catégorie",
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

        $category = category::where('id', $request->id)->first();

        if (!$category) {
            return response([
                "message" => "Catégorie introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $category->delete();

        return response([
            "message" => "Catégorie supprimée avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
