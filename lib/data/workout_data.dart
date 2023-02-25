// ignore_for_file: unused_import

import 'package:befit/data/hive_database.dart';
import 'package:befit/datetime/date_time.dart';
import 'package:befit/models/exercise_.dart';
import 'package:befit/models/workout_.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class WorkoutData extends ChangeNotifier {
  final db = HiveDataBase();
  List<Workout> workoutList = [
    
  ];
  //if there are workouts already in database, then get that workout list, otherwise use default
  void initalizeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDataBase();
    } else {
      db.saveToDatabase(workoutList);
    }
    //load heat map
    loadHeatMap();
  }

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
    
  }

  // get length of workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exersices.length;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exersices: []));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  //add an exersice to a workout
  void addExersice(String workoutName, String exerciseName, String weight, String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exersices.add(Exersice(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  //check off exersice
  void checkOffExercise(String workoutName, String exerciseName) {
    Exersice relevantExercise = getRelevantExercise(workoutName, exerciseName);
    //check off boolean to show user completed the exersice
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
    db.saveToDatabase(workoutList);
    loadHeatMap();
  }
  

  //return relevant workout object, given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  //return relevant exercise object , given a workout name + exercise name

  Exersice getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exersice relevantExercise = relevantWorkout.exersices
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }
  //get start date
  String getStartDate(){
    return db.getStartDate();
  }
  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap(){
    DateTime startDate = createDateTimeObject(getStartDate());

    //count the number of days to load
    int dayInBetween = DateTime.now().difference(startDate).inDays;

    //go from start date to today , and add each completion status to the dataset 
    //"Completion_Status_yyyymmdd" will be the key in the database
    for(int i =0; i<dayInBetween+1 ; i++){
      String yyyymmdd = convertDateTimeToYYYYMMDD(startDate.add(Duration(days:i)));

      //completion status = 0 or 1
      int completionStatus = db.getCompletionStatus(yyyymmdd);

      //year
      int year = startDate.add(Duration(days: i)).year;

      //month
      int month = startDate.add(Duration(days:i)).month;

      //day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year , month, day):completionStatus
      };
      //add to the heat map dataset
      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}