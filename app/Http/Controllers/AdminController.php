<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{

    /**
     * @OA\Get(
     *     path="/admin/admins/list",
     *    tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Liste des administrateurs",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        $user = User::where('admin_level', 3)->get();

        return UserResource::collection($user);
    }

    /**
     * @OA\Post(
     *     path="/admin/admins/store",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Enregistre un administrateur",
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
        $user->admin_level = 3;
        $user->service_id = 1;
        $user->password = Hash::make($request->password);
        $user->save();

        return response(["message" => "Administrateur enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/admins/show/{id}",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Renvoie les informations d'un administrateur par son ID",
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
        $user = User::where('id', $id)->where('admin_level', 3)->first();

        if (!$user) {
            return response([
                "message" => "Administrateur introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $user->id,
            "name" => $user->name,
            "email" => $user->email,
            "role_id" => $user->role->id,
            "telephone" => $user->telephone,
            "admin_level" => $user->admin_level,
            "is_active" => $user->is_active,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/admins/update",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Editer les informations d'un administrateur",
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
            "email" => "required|email",
            "telephone" => "required",
            "role" => "required"
        ]);

        $user = User::where('id', $request->id)->where('admin_level', 3)->first();

        if (!$user) {
            return response([
                "message" => "Administrateur introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $email = User::where('email', $request->email)
            ->where('id', '<>', $request->id)
            ->first();

        if ($email) {
            return response([
                "message" => "Adresse mail déjà utilisée",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        if (!empty($request->password)) {
            $user->password = Hash::make($request->password);
        }

        $user->name = $request->name;
        $user->email = $request->email;
        $user->telephone = $request->telephone;
        $user->role_id = $request->role;
        $user->admin_level = 3;
        $user->save();

        return response([
            "message" => "Administrateur modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/admins/activate/{id}",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Active ou désactive l'état d'un administrateur par son ID",
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
        $user = User::where('id', $id)->where("admin_level", 3)->first();

        if (!$user) {
            return response([
                "message" => "Administrateur introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        if ($user->is_active == 1) {
            $user->is_active = 0;
            $user->save();
            return response([
                "message" => "Administrateur désactivé",
                "type" => "success",
                "visibility" => true
            ], 200);
        } else {
            $user->is_active = 1;
            $user->save();
            return response([
                "message" => "Administrateur activé",
                "type" => "success",
                "visibility" => true
            ], 200);
        }
    }

    /**
     * @OA\Post(
     *     path="/admin/admins/delete",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Supprimer un administrateur",
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

        $user = User::where('id', $request->id)->where('admin_level', 3)->first();

        if (!$user) {
            return response([
                "message" => "Administrateur introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Administrateur supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/admins/theme/{id}",
     *     tags={"ADMINISTRATION__ADMINISTRATEURS"},
     *     summary="Change le thème du design d'un administrateur par son ID",
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
    public function theme($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response([
                "message" => "Administrateur introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        if ($user->theme == 1) {
            $user->theme = 2;
            $user->save();
            return response([
                "theme" => true,
                "message" => "Thème changé avec succés",
                "type" => "success",
                "visibility" => true
            ], 200);
        } else {
            $user->theme = 1;
            $user->save();
            return response([
                "theme" => false,
                "message" => "Thème changé avec succés",
                "type" => "success",
                "visibility" => true
            ], 200);
        }
    }
}
