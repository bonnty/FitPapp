import 'dart:developer';

import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<String> exercises = ["Push-ups", "Squats", "Burpees"];

  void _addExercise(String newExercise) {
    setState(() {
      exercises.add(newExercise);
    });
  }

  void _showAddExerciseDialog() {
    TextEditingController exerciseController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Exercise"),
          content: TextField(
            controller: exerciseController,
            decoration: InputDecoration(hintText: "Enter exercise name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (exerciseController.text.isNotEmpty) {
                  _addExercise(exerciseController.text);
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
  appBar: AppBar(title: Text("Workout Tracker")),
  body: Padding(
    padding: EdgeInsets.all(16.0),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 225, 
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10, 
        childAspectRatio: 1, 
      ),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed:() => log(exercises[index]),
                label: Text(exercises[index], textAlign: TextAlign.center),
                icon: Icon(Icons.fitness_center_outlined),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 225,  
                child: Image.asset(
                  "assets/courses.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
        );
      },
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: _showAddExerciseDialog,
    child: Icon(Icons.add),
  ),
);

  }
}

