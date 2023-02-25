class Exersice{
  final String name;
  final String sets;
  final String weight;
  final String reps;
  bool isCompleted;

  Exersice({
    required this.name,
    required this.sets,
    required this.weight,
    required this.reps,

    this.isCompleted = false,
  });

}