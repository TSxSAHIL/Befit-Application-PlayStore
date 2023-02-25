// ignore_for_file: unnecessary_brace_in_string_interps, avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable, unnecessary_import, implementation_imports

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? OnCheckChanged;

  ExerciseTile({super.key,
  required this.exerciseName,
  required this.weight,
  required this.reps,
  required this.sets,
  required this.isCompleted,
  required this.OnCheckChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            Chip(label: Text(
              "${sets} Sets",
            )),
            Chip(label: Text(
              "${weight} Kg",
            )),
            Chip(label: Text(
              "${reps} Reps",
            )),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => OnCheckChanged!(value),
        ),
        ),
    );
  }
}