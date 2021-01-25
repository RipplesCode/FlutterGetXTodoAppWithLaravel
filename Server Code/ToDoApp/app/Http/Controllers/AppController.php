<?php

namespace App\Http\Controllers;

use App\Models\AppModel;
use Exception;
use Illuminate\Http\Request;

class AppController extends Controller
{

 // To get task
    public function getTask(Request $request)
    {

        $app_model = new AppModel;
       return $app_model->getTask();
    }











    
    public function saveTask(Request $request)
    {
        $title=$request->title;
        $description=$request->description;
        $priority=$request->priority;
        $app_model = new AppModel;
        return $app_model->saveTask( $title, $description,  $priority);
    }
    public function updateTask(Request $request)
    {
        $id=$request->id;
        $title=$request->title;
        $description=$request->description;
        $priority=$request->priority;
        $app_model = new AppModel;
        return $app_model->updateTask(  $id,$title, $description,  $priority);
    }
    public function deleteTask(Request $request)
    {
        $id=$request->id;
        $app_model = new AppModel;
        return $app_model->deleteTask($id);
    }


}
