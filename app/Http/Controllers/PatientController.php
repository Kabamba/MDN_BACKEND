<?php

namespace App\Http\Controllers;

use App\Models\patient;
use Illuminate\Http\Request;

class PatientController extends Controller
{

    /**
     * @OA\Post(
     *     path="/admin/patients/search",
     *     tags={"ADMINISTRATION__PATIENT"},
     *     summary="Recherche un patient",
     *     description="",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *              mediaType="multipart/form-data",
     *              @OA\Schema(
     *                @OA\Property(
     *                   property = "search",
     *                   type="string",
     *                   example = "Lucas"
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
    public function search(Request $request)
    {
        $request->validate([
            'search' => 'required',
        ]);

        if (!empty($request->search)) {
            $patients = patient::where('name', 'like', '%' . $request->search . '%')
                ->orWhere('prenom', 'like', '%' . $request->search . '%')
                ->orWhere('matricule', 'like', '%' . $request->search . '%')->get();

            return $patients;
        }
    }
}
