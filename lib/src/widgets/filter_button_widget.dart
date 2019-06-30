import 'package:flutter/material.dart';
import 'package:tasks_app_ui/src/blocs/profile_bloc_provider.dart';
import 'package:tasks_app_ui/src/models/task_model.dart';
import 'package:tasks_app_ui/src/utils/types.dart';


class FilterButton extends StatefulWidget {

  final ProfileScreenBloc bloc;

  FilterButton({this.bloc});

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _scaleAnimation;
  Animation<double> _transitionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _colorAnimation = new ColorTween(begin: Colors.pink, end: Colors.pink[800])
      .animate(_animationController);
    _transitionAnimation = Tween(begin: 0.0, end: 1.0)
      .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut),
    );
    _scaleAnimation = Tween(begin: 1.0, end: 3.0)
      .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ButtonState>(
      initialData: ButtonState.closed,
      stream: widget.bloc.fetchButtonState,
      builder: (context, AsyncSnapshot<ButtonState> snapshot) {
        var state = snapshot.data;
        return SizedBox(
          height: 160,
          width: 160,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _){
              if(snapshot.data == ButtonState.closed){
                _animationController.reverse();
              }else{
                _animationController.forward();
              }
              return Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  _backgroundContainer(state),
                  _filterButton(state, Icons.check_circle, Offset(0, -55 * _transitionAnimation.value), TaskCondition.green),
                  _filterButton(state, Icons.flash_on, Offset(-50 * _transitionAnimation.value, -30 * _transitionAnimation.value), TaskCondition.yellow ),
                  _filterButton(state, Icons.access_time, Offset(-50 * _transitionAnimation.value, 30 * _transitionAnimation.value), TaskCondition.red ),
                  _filterButton(state, Icons.error_outline, Offset(0, 55 * _transitionAnimation.value), null ),
                  _mainFilterButton(state),
                ],
              );
            },
          ),
        );
      }
    );
  }
  

  Widget _filterButton(ButtonState state, IconData icon, Offset offset, TaskCondition condition){
    return Transform.translate(
      offset: offset,
      child: Opacity(
        opacity: _transitionAnimation.value,
        child: MaterialButton(
          child: Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
          splashColor: Colors.white70,
          shape: CircleBorder(),
          onPressed: () {
            widget.bloc.filterTasks(condition);
            widget.bloc.toggleButtonState();
          },
        ),
      ),
    );
  }

  Widget _backgroundContainer(ButtonState state){
    return Transform.scale(
      scale: _scaleAnimation.value,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _mainFilterButton(ButtonState state){
    return MaterialButton(
      height: 55,
      padding: EdgeInsets.all(5),
      color: _colorAnimation.value,
      shape: CircleBorder(),
      onPressed: () {
        widget.bloc.toggleButtonState();
      },
      child: Icon(
        state == ButtonState.closed ? Icons.filter_list : Icons.close,
        size: 20,
        color: Colors.white,
      ),
    );
  }

}
