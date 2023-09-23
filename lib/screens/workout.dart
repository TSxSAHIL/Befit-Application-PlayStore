// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import

import 'package:befit/constants/app_constants.dart';
import 'package:befit/data/workout_data.dart';
import 'package:befit/main.dart';
import 'package:befit/models/heat_map.dart';
import 'package:befit/screens/workout_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});
  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  @override
  void initState(){
    super.initState();
    Provider.of<WorkoutData>(context , listen: false).initalizeWorkoutList();
  }

  final newWorkoutNameController = TextEditingController();

  //create a new workout
  void createNewWorkout(){
    showDialog(context: context, 
    builder: ((context) => AlertDialog(
      title: Text("Create New Workout"),
      content: TextFormField(
        controller: newWorkoutNameController,
      ),
      actions: [
        //save button
        MaterialButton(
          onPressed: save,
          child: Text("Save"),
          ),
        MaterialButton(onPressed: cancel,
        child: Text("Cancel"),
        ),
      ],
    )));
  }

    //new workout page
    void goToWorkoutPage(String workoutname){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WorkoutPage(
        workoutname: workoutname,
      )));
    }

    //save workout
    void save(){
      //get workout from the text controller 
      String newWorkoutName = newWorkoutNameController.text;
      //add workout to workout data
      Provider.of<WorkoutData>(context , listen:false).addWorkout(newWorkoutName);
      //pop this dialog box 
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
      newWorkoutNameController.clear();
    }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => 
      Scaffold(
        backgroundColor: mainHexColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: accentHexColor,
          onPressed: createNewWorkout,
          child: Icon(Icons.add),
          ),
        body: ListView(
          children: [
            
            //HeatMap
            MyHeatMap(datasets: value.heatMapDataSet, startDateYYYYMMDD: value.getStartDate()),
            Divider(),
            Divider(),


            //Workout List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getWorkoutList().length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(value.getWorkoutList()[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: (() => goToWorkoutPage(value.getWorkoutList()[index].name)
                  
                  ),
                )),
      ),


          ],
        )
    ));
  }
}
