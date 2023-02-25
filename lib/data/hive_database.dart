// ignore_for_file: avoid_print

import 'package:befit/datetime/date_time.dart';
import 'package:befit/models/exercise_.dart';
import 'package:hive/hive.dart';

import '../models/workout_.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase{
  //reference our hive box
  final _myBox = Hive.box("workout_database");


  //check if there is already data storede , if not , record the start date
  bool previousDataExists(){
    if(_myBox.isEmpty){
      print("previous data does Not Exist");
    _myBox.put("START_DATE", todaysDateYYYYMMDD());
    return false;
    }else{
      print("previous Data Exists");
      return true;
    }
    
  }

  //return start date as yy//mm//dd
  String getStartDate(){
   return _myBox.get("START_DATE");
  }

  //write data
  void saveToDatabase(List<Workout> workouts){
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);
    if(exerciseCompleted(workouts)){
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}" , 1);
    }else{
      _myBox.put("COMPLETION_STATUS_${todaysDateYYYYMMDD()}" , 0);
    }
    //save into hive
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  //read data, and return a list of workouts
  List<Workout> readFromDataBase(){
    List<Workout> mySavedWorkouts = [];
    List<String> wokroutNames = _myBox.get("WORKOUTS") ?? [];
    final exerciseDetails = _myBox.get("EXERCISES") ?? [];
    //create workout objects
    for(int i=0; i<wokroutNames.length; i++){
      //each workout can have multiple exercises
      List<Exersice>  exerciseInEachWorkout = [];
      for(int j=0 ; j<exerciseDetails[i].length ; j++){
        exerciseInEachWorkout.add(
          Exersice(
            name: exerciseDetails[i][j][0], 
            sets : exerciseDetails[i][j][1], 
            weight: exerciseDetails[i][j][2], 
            reps: exerciseDetails[i][j][3],
            isCompleted: exerciseDetails[i][j][4] == "true" ? true : false,
            )
        );
      }
      //create individual workout
      Workout workout = Workout(
        name: wokroutNames[i], 
        exersices: exerciseInEachWorkout);
      //add individual workout to overall list
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  //check if any exercise have been done
  bool exerciseCompleted(List<Workout> workouts){
    //go through each workout
    for(var workout in workouts){
      // go through each exercise in workout
      for(var exercise in workout.exersices){
        if(exercise.isCompleted){
          return true;
        }
      }
    }
    return false;
  }
  
  //return completion status of a given date yyyymmdd
  int getCompletionStatus(String yyyymmdd){
    int completionStatus = _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
    return completionStatus;
  }
}
//converts workout objects into a list
  List<String> convertObjectToWorkoutList(List<Workout> workouts){
    List<String> workoutList = [

    ];
    for(int i= 0 ; i<workouts.length; i++){
      workoutList.add(workouts[i].name);
    }
    return workoutList;
  }

  //converts the exercise in a workout object into a list of strings
  List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts){
    List<List<List<String>>> exerciseList = [];

    for (int i = 0; i < workouts.length; i++) {
      List<Exersice> exerciseInWorkout = workouts[i].exersices;
      List<List<String>> individualWorkout = [];

      for (int j = 0; j < exerciseInWorkout.length; j++) { // fixed indexing issue
        List<String> individualExercise = [];
        individualExercise.addAll([
          exerciseInWorkout[j].name,
          exerciseInWorkout[j].sets,
          exerciseInWorkout[j].weight,
          exerciseInWorkout[j].reps,
          exerciseInWorkout[j].isCompleted.toString(),
        ]);
        individualWorkout.add(individualExercise);
      }
      exerciseList.add(individualWorkout);
    }
    return exerciseList;
  }
