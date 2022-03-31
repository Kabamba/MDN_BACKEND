<?php

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:api'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('login', 'AuthController@login');
Route::get('logout', 'AuthController@logout')->middleware(['auth:api']);

// 'cors'

Route::prefix('/admin')->group(function () {
    Route::get('admins/list', 'AdminController@index');
    Route::get('admins/show/{id}', 'AdminController@show');
    Route::post('admins/store', 'AdminController@store');
    Route::post('admins/update', 'AdminController@update');
    Route::post('admins/delete', 'AdminController@delete');
    Route::get('admins/activate/{id}', 'AdminController@activate');
    Route::get('admins/theme/{id}', 'AdminController@theme');

    Route::get('recepts/list', 'ReceptionController@index');
    Route::get('recepts/show/{id}', 'ReceptionController@show');
    Route::post('recepts/store', 'ReceptionController@store');
    Route::post('recepts/update', 'ReceptionController@update');
    Route::post('recepts/delete', 'ReceptionController@delete');
    Route::get('recepts/activate/{id}', 'ReceptionController@activate');

    Route::get('doctors/list', 'DocteurController@index');
    Route::get('doctors/show/{id}', 'DocteurController@show');
    Route::post('doctors/store', 'DocteurController@store');
    Route::post('doctors/update', 'DocteurController@update');
    Route::get('doctors/activate/{id}', 'DocteurController@activate');

    Route::get('appoints/one/{id}', 'AppointmentController@getDetail');

    Route::get('appoints/listoday', 'AppointmentController@getAllToday');
    Route::get('appoints/listfuture', 'AppointmentController@getAllFuture');
    Route::get('appoints/listlast', 'AppointmentController@getAllLast');

    Route::get('appoints/listoday/{id}', 'AppointmentController@getAllTodayDoctor');
    Route::get('appoints/listfuture/{id}', 'AppointmentController@getAllFutureDoctor');
    Route::get('appoints/listlast/{id}', 'AppointmentController@getAllLastDoctor');
    Route::post('appoints/approuver', 'AppointmentController@approuver');

    Route::post('appoints/store', 'AppointmentController@store');
    Route::post('appoints/dispo', 'AppointmentController@dispo');
    Route::post('appoints/saveschdule', 'AppointmentController@saveSchedule');
    Route::get('appoints/listschedule/{id}', 'AppointmentController@listeSchedule');
    Route::get('appoints/grille/all', 'AppointmentController@grilleAll');
    Route::post('appoints/grille/date', 'AppointmentController@grilleDate');

    Route::get('services/list', 'ServiceController@index');
    Route::get('services/show/{id}', 'ServiceController@show');
    Route::post('services/store', 'ServiceController@store');
    Route::post('services/update', 'ServiceController@update');
    Route::post('services/delete', 'ServiceController@delete');

    Route::get('motifs/list', 'MotifController@index');
    Route::get('motifs/show/{id}', 'MotifController@show');
    Route::post('motifs/store', 'MotifController@store');
    Route::post('motifs/update', 'MotifController@update');
    Route::post('motifs/delete', 'MotifController@delete');

    Route::post('patients/search', 'PatientController@search');
    Route::post('patients/store', 'PatientController@store');
    Route::post('patients/update', 'PatientController@update');
    Route::get('patients/list', 'PatientController@index');
    Route::get('patients/show/{id}', 'PatientController@show');
    Route::post('patients/delete', 'PatientController@delete');

    Route::get('pays/list', 'PatientController@pays');

    Route::get('mail/test', 'TestMail@envoyer');

    Route::get('stats/totrdv', 'StatistiqueController@totRdv');
    Route::get('stats/totrdv/{id}', 'StatistiqueController@totRdvDoc');

    Route::get('categories/list', 'categoryController@index');
    Route::get('categories/show/{id}', 'categoryController@show');
    Route::post('categories/store', 'categoryController@store');
    Route::post('categories/update', 'categoryController@update');
    Route::post('categories/delete', 'categoryController@delete');

    Route::get('societies/list', 'societyController@index');
    Route::get('societies/categorie/{id}', 'societyController@SocietePerCategorie');
    Route::get('societies/show/{id}', 'societyController@show');
    Route::post('societies/store', 'societyController@store');
    Route::post('societies/update', 'societyController@update');
    Route::post('societies/delete', 'societyController@delete');

    Route::get('roles/list', 'RoleController@index');
    Route::get('roles/show/{id}', 'RoleController@show');
    Route::post('roles/store', 'RoleController@store');
    Route::post('roles/update', 'RoleController@update');
    Route::post('roles/delete', 'RoleController@delete');

    Route::get('permissions/list', 'PermissionController@index');
});
