<?php

namespace App\Http\Controllers;

use App\Models\permission;
use Illuminate\Http\Request;

class PermissionController extends Controller
{
    
    /**
     * @OA\Get(
     *     path="/admin/permissions/list",
     *    tags={"ADMINISTRATION__PERMISSIONS"},
     *     summary="Liste des permissions",
     *     @OA\Response(
     *         response=200,
     *         description="OK",
     *     )
     * )
     */
    public function index()
    {
        return permission::all();
    }
}
