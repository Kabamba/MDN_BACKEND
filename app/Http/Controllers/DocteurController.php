<?php

namespace App\Http\Controllers;

use App\Http\Resources\DocteurResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class DocteurController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/doctors/list",
     *    tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Liste des docteurs",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        $docteurs = User::where('admin_level', 2)->get();

        return DocteurResource::collection($docteurs);
    }

    /**
     * @OA\Post(
     *     path="/admin/doctors/store",
     *     tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Enregistre un docteur",
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
     *                   property = "service",
     *                   type="integer",
     *                   example = 1
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
            "name" => "required",
            "email" => "required|email|unique:users",
            "telephone" => "required|unique:users",
            "password" => "required",
            "service" => "required",
            "role" => "required"
        ]);

        $user = new User();

        $user->name = $request->name;
        $user->email = $request->email;
        $user->telephone = $request->telephone;
        $user->role_id = $request->role;
        $user->service_id = $request->service;
        $user->admin_level = 2;
        $user->password = Hash::make($request->password);
        $user->save();

        return response(["message" => "Docteur enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/doctors/show/{id}",
     *     tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Renvoie les informations d'un docteur par son ID",
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
        $user = User::where('id', $id)->where('admin_level', 2)->first();

        if (!$user) {
            return response([
                "message" => "Docteur introuvable",
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
            "permissions" => $user->role->permissions,
            "telephone" => $user->telephone,
            "admin_level" => $user->admin_level,
            "service" => $user->service->libelle,
            "service_id" => $user->service->id,
            "is_active" => $user->is_active,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/doctors/update",
     *     tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Editer les informations d'un docteur",
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
     *                   property = "service",
     *                   type="integer",
     *                   example = 1
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
            "email" => "required|email",
            "telephone" => "required",
            "service" => "required",
            "role" => "required"
        ]);

        $user = User::where('id', $request->id)->where('admin_level', 2)->first();

        if (!$user) {
            return response([
                "message" => "Docteur introuvable",
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
        $user->service_id = $request->service;
        $user->admin_level = 2;
        $user->save();

        return response([
            "message" => "Docteur modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/doctors/activate/{id}",
     *     tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Active ou désactive l'état d'un docteur par son ID",
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
        $user = User::where('id', $id)->where("admin_level", 2)->first();

        if (!$user) {
            return response([
                "message" => "Docteur introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        if ($user->is_active == 1) {
            $user->is_active = 0;
            $user->save();
            return response([
                "message" => "Docteur désactivé",
                "type" => "success",
                "visibility" => true
            ], 200);
        } else {
            $user->is_active = 1;
            $user->save();
            return response([
                "message" => "Docteur activé",
                "type" => "success",
                "visibility" => true
            ], 200);
        }
    }

    /**
     * @OA\Post(
     *     path="/admin/doctors/delete",
     *     tags={"ADMINISTRATION__DOCTEUR"},
     *     summary="Supprimer un docteur",
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

        $user = User::where('id', $request->id)->where('admin_level', 2)->first();

        if (!$user) {
            return response([
                "message" => "Docteur introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Docteur supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
