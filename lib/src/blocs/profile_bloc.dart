import 'package:rxdart/rxdart.dart';
import 'package:tasks_app_ui/src/models/task_model.dart';
import 'package:tasks_app_ui/src/resources/repository.dart';
import 'package:tasks_app_ui/src/utils/types.dart';

class ProfileScreenBloc {

  ButtonState _buttonState;
  List<TaskModel> _currentTasks;
  List<TaskModel> _requestedTasks;
  
  List<int> _tasksToRemoveIndices;
  Map<int, TaskModel> _tasksToAddMap;


  final Repository _repo = Repository();

  final _tasksToAddProvider = PublishSubject<Map<int,TaskModel>>();
  final _tasksToRemoveProvider = PublishSubject<List<int>>();

  final _buttonStateProvider = BehaviorSubject<ButtonState>();

  Observable<Map<int, TaskModel>> get fetchItemsToAdd => _tasksToAddProvider.stream;
  Observable<List<int>> get fetchItemsToRemove => _tasksToRemoveProvider.stream;
  Observable<ButtonState> get fetchButtonState => _buttonStateProvider.stream;


  
  ProfileScreenBloc(){
    _currentTasks = [];
    _requestedTasks = [];
    _tasksToAddMap = {};
  }

  init() async{
    await _repo.getTasks(null).then( (tasks) {
      _requestedTasks = tasks;
      for( int i = 0; i < tasks.length; i++){
        _tasksToAddMap.putIfAbsent( i, () => tasks[i]);
      }
    });
    _tasksToAddProvider.sink.add(_tasksToAddMap);
    _buttonState = ButtonState.closed;
  }

  toggleButtonState(){
    if(_buttonState == ButtonState.open){
      _buttonState = ButtonState.closed;
    } else {
      _buttonState = ButtonState.open;
    }
    _buttonStateProvider.sink.add(_buttonState);
  }

  filterTasks(TaskCondition filterType) async{
    _currentTasks = _requestedTasks;
    _requestedTasks = await _repo.getTasks(filterType);
    _tasksToRemoveIndices = [];
    _tasksToAddMap.clear();

    for( int i = 0; i < _currentTasks.length; i++){
      if(!_requestedTasks.contains(_currentTasks[i])){
        _tasksToRemoveIndices.add(i);
      }
    }
    _tasksToRemoveProvider.sink.add(_tasksToRemoveIndices);

    for( int i = 0; i < _requestedTasks.length; i++){
      if(!_currentTasks.contains(_requestedTasks[i])){
        _tasksToAddMap.putIfAbsent(i, () => _requestedTasks[i]);
      }
    }
    _tasksToAddProvider.sink.add(_tasksToAddMap);

  }

  dispose(){
    _tasksToAddProvider.close();
    _tasksToRemoveProvider.close();
    _buttonStateProvider.close();
  }
}