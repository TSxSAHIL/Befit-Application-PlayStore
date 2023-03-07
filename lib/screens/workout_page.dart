// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_import, sort_child_properties_last

import 'package:befit/constants/app_constants.dart';
import 'package:befit/models/exercise_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/workout_data.dart';
class WorkoutPage extends StatefulWidget {
  final String workoutname;
  const WorkoutPage({super.key  , required this.workoutname});
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}
class _WorkoutPageState extends State<WorkoutPage> {
  //checkbox was tapped
  void OnCheckChanged(String workoutName , String exerciseName){
    Provider.of<WorkoutData>(context , listen: false).
    checkOffExercise(
      workoutName, exerciseName);
  }
  
  //text controllers
  final exerciseNameController = TextEditingController();
  final setsController = TextEditingController();
  final weightController = TextEditingController();
  final repsController =  TextEditingController();
  //create new exercise
  void createNewExercise(){
    showDialog(
      context: context, 
      builder: (context)=> AlertDialog(
      title: Text("Add a new Exercise"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //exercise name 
          TextField(
            controller:  exerciseNameController,
            decoration: const InputDecoration(
              hintText: "Exercise Name",
            ),
            
          ),
          //sets
          TextField(
            controller:  setsController,
            decoration: const InputDecoration(
              hintText: "No. of Sets",
            ),
          ),
          //weight
          TextField(
            controller:  weightController,
            decoration: const InputDecoration(
              hintText: "Weight",
            ),
          ),
          //reps
          TextField(
            controller:  repsController,
            decoration: const InputDecoration(
              hintText: "No. of Reps",
            ),
          ),          
        ],
      ),
      actions: [
        //save button 
        MaterialButton(
          onPressed: save,
          child: Text("save"),
          ),
        //cancel button
        MaterialButton(onPressed: cancel,
        child: Text("cancel"),
        ),

      ],
    ));
  }
  //save workout
    void save(){
      //get exercise from the text controller 
      String newExerciseName = exerciseNameController.text;
      String sets = setsController.text;
      String weight = weightController.text;
      String reps = repsController.text;
      //add exercise to workout data
      Provider.of<WorkoutData>(context , listen:false).addExersice(
        widget.workoutname, 
        newExerciseName, 
        weight, 
        reps, 
        sets);
        Navigator.pop(context);
        clear();
    }


    //cancel workout
    void cancel(){
      //pop this dialog box 
      Navigator.pop(context);
      clear();
    }

    //clear workout
    void clear(){
      exerciseNameController.clear();
      setsController.clear();
      weightController.clear();
      repsController.clear();
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: ((context, value, child) => Scaffold(
        backgroundColor: mainHexColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () => createNewExercise(),
          child: Icon(Icons.add),
          backgroundColor: accentHexColor,
          ),
      appBar: AppBar(
        title: Text(widget.workoutname),
        backgroundColor: accentHexColor,),
      body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.workoutname),
            itemBuilder: (context, index) => ExerciseTile(
              exerciseName: value.getRelevantWorkout(widget.workoutname).exersices[index].name, 
              weight: value.getRelevantWorkout(widget.workoutname).exersices[index].weight,
              reps: value.getRelevantWorkout(widget.workoutname).exersices[index].reps, 
              sets: value.getRelevantWorkout(widget.workoutname).exersices[index].sets, 
              isCompleted: value.getRelevantWorkout(widget.workoutname).exersices[index].isCompleted, 
              OnCheckChanged: (val) => OnCheckChanged(widget.workoutname ,value.getRelevantWorkout(widget.workoutname).exersices[index].name ) ,
              )
    )))
    );
  }
}