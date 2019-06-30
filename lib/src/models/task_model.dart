import 'package:equatable/equatable.dart';

enum TaskCondition {
  red,
  yellow,
  green
}

class TaskModel extends Equatable{
  final String title;
  final String description;
  final DateTime time;
  final TaskCondition condition;

  TaskModel( {this.title, this.description, this.time, this.condition})
    : super([title, description, time, condition]);


}