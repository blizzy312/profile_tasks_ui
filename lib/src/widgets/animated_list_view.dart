import 'package:flutter/material.dart';
import 'package:tasks_app_ui/src/blocs/profile_bloc_provider.dart';
import 'package:tasks_app_ui/src/models/task_model.dart';
import 'package:intl/intl.dart';

class TasksListView extends StatefulWidget {
  @override
  _TasksListViewState createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {

  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<TaskModel> tasks;
  int insertIndex;

  @override
  void initState() {
    tasks = [];
    insertIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProfileScreenBlocProvider.of(context);
    return StreamBuilder(
      stream: bloc.fetchItemsToRemove,
      builder: (context, AsyncSnapshot<List<int>> removeItemsSnapshot){
        if(removeItemsSnapshot.hasData){
          _removeItems(context, removeItemsSnapshot.data);
        }
        return StreamBuilder(
          stream: bloc.fetchItemsToAdd,
          builder: (context, AsyncSnapshot<Map<int, TaskModel>> addTasksSnapshot){
            if(addTasksSnapshot.hasData){
              _addItems(addTasksSnapshot.data);
            }
            return AnimatedList(
              key: listKey,
              initialItemCount: tasks.length,
              itemBuilder: (context, index, animation) {
                if(tasks.length > 0){
                  return buildItem(context, index, animation);
                }
                return Container();
              },
            );
          },
        );
      },
    );

  }

  _addItems(Map<int, TaskModel> newTasks){
    newTasks.forEach( (index, task) {
      listKey.currentState.insertItem(index, duration: const Duration(milliseconds: 350));
      tasks.insert(index, task);
    });
  }

  _removeItems(context, List<int> removeList) {
    for(int i = removeList.length - 1; i > -1; i--){
      var itemToRemove = _taskItem(context, tasks[removeList[i]]);
      listKey.currentState.removeItem(
        removeList[i],
          (context, animation) {
            return SizeTransition(
              axis: Axis.vertical,
              sizeFactor: animation,
              child: itemToRemove,
            );
          },
        duration: const Duration(milliseconds: 350),
      );
      tasks.removeAt(removeList[i]);
    }
  }

  Widget buildItem(BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: _taskItem(context, tasks[index]),
    );
  }

  Widget _taskItem(BuildContext context, TaskModel task){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 12.0,
                height: 12.0,
                decoration: new BoxDecoration(
                  color: task.condition == TaskCondition.green ? Colors.green : task.condition == TaskCondition.yellow ? Colors.yellow : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${task.title}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '${task.description}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              '${DateFormat().add_jm().format(task.time)}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
