<?php

namespace App\Http\Controllers;

use App\Http\Resources\ReceptionnisteResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ReceptionController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/recepts/list",
     *    tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Liste des réceptionnistes",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
       $recepts = User::where('admin_level', 1)->get();

       return ReceptionnisteResource::collection($recepts);
    }

    /**
     * @OA\Post(
     *     path="/admin/recepts/store",
     *     tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Enregistre un réceptionniste",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "name",
     *                   type="string",
     *                   example = "Mulamba"
     *                  ),
     *                @OA\Property(
     *                   property = "email",
     *                   type="string",
     *                   example = "bgi@gmail.com"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone",
     *                   type="string",
     *                   example = "0852277379"
     *                  ),
     *                @OA\Property(
     *                   property = "role",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "password",
     *                   type="string",
     *                   example = "12345678"
     *                  ),
     *                @OA\Property(
     *                   property = "password_confirmation",
     *                   type="string",
     *                   example = "12345678"
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
            "name" => "required",
            "role" => "required",
            "email" => "required|email|unique:users",
            "telephone" => "required|unique:users",
            "password" => "required",
        ]);

        $user = new User();

        $user->name = $request->name;
        $user->email = $request->email;
        $user->role_id = $request->role;
        $user->telephone = $request->telephone;
        $user->admin_level = 1;
        $user->service_id = 1;
        $user->password = Hash::make($request->password);
        $user->save();

        return response(["message" => "Réceptionniste enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/recepts/show/{id}",
     *     tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Renvoie les informations d'un réceptionniste par son ID",
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
        $user = User::where('id', $id)->where('admin_level', 1)->first();

        if (!$user) {
            return response([
                "message" => "Réceptionniste introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $user->id,
            "name" => $user->name,
            "email" => $user->email,
            "role" => $user->role->libelle,
            "role_id" => $user->role->id,
            "telephone" => $user->telephone,
            "admin_level" => $user->admin_level,
            "is_active" => $user->is_active,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/recepts/update",
     *     tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Editer les informations d'un réceptionniste",
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
     *                   property = "name",
     *                   type="string",
     *                   example = "Mulamba"
     *                  ),
     *                @OA\Property(
     *                   property = "email",
     *                   type="string",
     *                   example = "bgi@gmail.com"
     *                  ),
     *                @OA\Property(
     *                   property = "telephone",
     *                   type="string",
     *                   example = "0852277379"
     *                  ),
     *                @OA\Property(
     *                   property = "role",
     *                   type="integer",
     *                   example = 1
     *                  ),
     *                @OA\Property(
     *                   property = "password",
     *                   type="string",
     *                   example = "12345678"
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
    public function update(Request $request)
    {
        $request->validate([
            "id" => "required",
            "name" => "required",
            "role" => "required",
            "email" => "required|email",
            "telephone" => "required",
        ]);

        $user = User::where('id', $request->id)->where('admin_level', 1)->first();

        if (!$user) {
            return response([
                "message" => "Réceptionniste introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        $email = User::where('email', $request->email)
            ->where('id', '<>', $request->id)
            ->first();

        if ($email) {
            return response([
                "message" => "Adresse mail déjà utilisée",
                "type" => "danger",
                "visibility" => true
            ], 200);
        }

        if (!empty($request->password)) {
            $user->password = Hash::make($request->password);
        }

        $user->name = $request->name;
        $user->email = $request->email;
        $user->role_id = $request->role;
        $user->telephone = $request->telephone;
        $user->admin_level = 1;
        $user->password = Hash::make($request->password);
        $user->save();

        return response([
            "message" => "Réceptionniste modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/recepts/activate/{id}",
     *     tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Active ou désactive l'état d'un réceptionniste par son ID",
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
    public function activate($id)
    {
        $user = User::where('id', $id)->where("admin_level", 1)->first();

        if (!$user) {
            return response([
                "message" => "Réceptionniste introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        if ($user->is_active == 1) {
            $user->is_active = 0;
            $user->save();
            return response([
                "message" => "Réceptionniste désactivé",
                "type" => "success",
                "visibility" => true
            ], 200);
        } else {
            $user->is_active = 1;
            $user->save();
            return response([
                "message" => "Réceptionniste activé",
                "type" => "success",
                "visibility" => true
            ], 200);
        }
    }

    /**
     * @OA\Post(
     *     path="/admin/recepts/delete",
     *     tags={"ADMINISTRATION__RECEPTIONISTE"},
     *     summary="Supprimer un receptionniste",
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

        $user = User::where('id', $request->id)->where('admin_level', 1)->first();

        if (!$user) {
            return response([
                "message" => "Récepetionniste introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Récepetionniste supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
