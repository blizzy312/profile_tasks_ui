import 'package:flutter/material.dart';
import 'profile_bloc.dart';

export 'profile_bloc.dart';

class ProfileScreenBlocProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  final bloc = ProfileScreenBloc();

  ProfileScreenBlocProvider({Key key, Widget child})
    : super(key:key, child: child);

  static ProfileScreenBloc of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ProfileScreenBlocProvider) as ProfileScreenBlocProvider).bloc;
  }
}