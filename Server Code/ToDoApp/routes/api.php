<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AppController;

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

Route::get('getTask', [AppController::class, 'getTask']);




Route::post('saveTask', [AppController::class, 'saveTask']);
Route::post('updateTask', [AppController::class, 'updateTask']);
Route::post('deleteTask', [AppController::class, 'deleteTask']);
