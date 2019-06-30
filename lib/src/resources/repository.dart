import 'package:tasks_app_ui/src/models/task_model.dart';

class Repository {

  Future<List<TaskModel>> getTasks(TaskCondition filterType){
//    Future.delayed( Duration(seconds: 1));
    var task1 = TaskModel(title: 'Catch up with Brian', condition: TaskCondition.yellow, description:  'Mobile Project', time: DateTime(2019, 08, 06, 5 ));
    var task2 = TaskModel(title: 'Make new icons', condition: TaskCondition.green, description:  'Web App', time: DateTime(2019, 08, 06, 2 ));
    var task3 = TaskModel(title: 'Design explorations', condition: TaskCondition.red, description:  'Company WEbsite', time: DateTime(2019, 08, 06, 1 ));
    var task4 = TaskModel(title: 'Lunch with Mary', condition: TaskCondition.green, description:  'Grill house', time: DateTime(2019, 08, 06, 5 ));
    var task5 = TaskModel(title: 'Team meeting', condition: TaskCondition.green, description:  'Hangouts', time: DateTime(2019, 08, 06, 1 ));

    List<TaskModel> y = [task1, task2, task3, task4, task5];

    if(filterType != null){
      y = y.where((task) => task.condition == filterType).toList();
    }

    return Future.value(y);

  }

}