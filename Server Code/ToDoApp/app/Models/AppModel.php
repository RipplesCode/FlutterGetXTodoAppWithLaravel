<?php

namespace App\Models;

use DateTime;
use DB;
use Exception;
use function PHPUnit\Framework\isEmpty;
use Haruncpi\LaravelIdGenerator\IdGenerator;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppModel extends Model
{
    use HasFactory;

    // To get task
    public function getTask()
    {

        $getQuery = DB::table('task')
            ->select(['task_id',
                'task_name',
                'task_description',
                'task_priority',
                DB::raw("(SELECT count(*) FROM task
       ) as active_task"),

       DB::raw("(SELECT count(*) FROM task  where task_priority=1
       ) as highest_priority"),
       DB::raw("(SELECT count(*) FROM task  where task_priority=2
       ) as medium_priority"),
       DB::raw("(SELECT count(*) FROM task  where task_priority=3
       ) as lowest_priority"),
            ])
            ->paginate(10);
        return $getQuery;


    }










    public function saveTask( $title, $description,$priority) {

    $insertQuery = DB::table('task')->insertGetId(
        ['task_name' => $title, 'task_description' => $description,
            'task_priority' => $priority


        ]
    );
    if ($insertQuery > 0) {
        $resultData['result'] = "success";
    } else {
        $resultData['result'] = "fail";
    }

    return $resultData;
}



public function updateTask(  $id,$title, $description,  $priority){

    $Query =DB::table('task')
    ->where('task_id', $id)
    ->update(['task_name' => $title,
    'task_description' => $description,
    'task_priority' => $priority]);

    if ($Query > 0) {
        $resultData['result'] = "success";
    } else {
        $resultData['result'] = "fail";
    }

    return $resultData;
}


public function deleteTask($id){
    $Query =DB::table('task')
    ->where('task_id', $id)
    ->delete();


if ($Query > 0) {
    $resultData['result'] = "success";
} else {
    $resultData['result'] = "fail";
}

return $resultData;
}


}
