<?php

namespace App\Http\Controllers;

use App\Models\role;
use App\Models\role_permission;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    /**
     * @OA\Get(
     *     path="/admin/roles/list",
     *    tags={"ADMINISTRATION__ROLES"},
     *     summary="Liste des roles",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        $roles = role::with('permissions')->get();

        return $roles;
    }

    /**
     * @OA\Post(
     *     path="/admin/roles/store",
     *     tags={"ADMINISTRATION__ROLES"},
     *     summary="Enregistre un role",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "libelle",
     *                   type="string",
     *                   example = "Administrateur"
     *                  ),     
     *                 @OA\Property(
     *                   property = "permissions",
     *                   type="array",
     *                      @OA\Items(
     *                          type = "integer",
     *                      )
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
            "libelle" => "required|unique:roles",
            "permissions" => "required"
        ]);

        $role = new role();

        $role->libelle = $request->libelle;
        $role->save();

        foreach ($request->permissions as $permission) {
            $perm = new role_permission();
            $perm->role_id = $role->id;
            $perm->permission_id = $permission;
            $perm->save();
        }

        return response(["message" => "Rôle enregistré avec succes"], 200);
    }

    /**
     * @OA\Get(
     *     path="/admin/roles/show/{id}",
     *     tags={"ADMINISTRATION__ROLES"},
     *     summary="Renvoie les informations d'un role par son ID",
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
        $role = role::where('id', $id)->first();

        if (!$role) {
            return response([
                "message" => "Rôle introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        return response([
            "id" => $role->id,
            "libelle" => $role->libelle,
            "permissions" => $role->permissions,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/roles/update",
     *     tags={"ADMINISTRATION__ROLES"},
     *     summary="Editer les informations d'un role",
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
     *                   example = "Infirmiére"
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
            "permissions" => "required",
        ]);

        $role = role::where('id', $request->id)->first();

        if (!$role) {
            return response([
                "message" => "Rôle introuvable",
                "type" => "danger",
                "visibility" => true
            ], 404);
        }

        $role->libelle = $request->libelle;

        $role->permissions()->sync($request->permissions);

        $role->save();

        return response([
            "message" => "Rôle modifié avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/admin/roles/delete",
     *     tags={"ADMINISTRATION__ROLES"},
     *     summary="Supprimer un role",
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

        $user = role::where('id', $request->id)->first();

        if (!$user) {
            return response([
                "message" => "Rôle introuvable",
                "type" => "danger",
                "visibility" => false
            ], 200);
        }

        $user->delete();

        return response([
            "message" => "Rôle supprimé avec succés",
            "type" => "success",
            "visibility" => true
        ], 200);
    }
}
