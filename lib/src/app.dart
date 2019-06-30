import 'package:flutter/material.dart';
import 'package:tasks_app_ui/src/screens/profile_screen.dart';

import 'blocs/profile_bloc_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileScreenBlocProvider(
      child: MaterialApp(
        home: ProfileScreen(),
      ),
    );
  }
}
