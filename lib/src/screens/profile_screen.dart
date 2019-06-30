import 'package:flutter/material.dart';

import 'package:tasks_app_ui/src/blocs/profile_bloc.dart';
import 'package:tasks_app_ui/src/blocs/profile_bloc_provider.dart';
import 'package:tasks_app_ui/src/utils/diagonal_clipper.dart';
import 'package:tasks_app_ui/src/utils/dots_painter.dart';
import 'package:tasks_app_ui/src/widgets/animated_list_view.dart';
import 'package:tasks_app_ui/src/widgets/filter_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  ProfileScreenBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = ProfileScreenBlocProvider.of(context);
    bloc.init();
    return Scaffold(
      body: CustomPaint(
        painter: DotsPainter(),
        child: Stack(
          children: <Widget>[
            Container(),
            _backgroundImage(context),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: _titleBar()
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: _profileInfo(context),
            ),
            Positioned(
              right: -30,
              top: MediaQuery.of(context).size.height * 0.32,
              child: _filterButton(bloc),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 300,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _listTitle(context),
                    Expanded(
                      child: TasksListView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ClipPath(
        clipper: DiagonalClipper(),
        child: new Image.asset(
          'assets/birds.jpg',
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.srcOver,

          color: Colors.black26.withBlue(25),
        ),
      ),
    );
  }

  Widget _titleBar(){
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            Icons.menu,
            size: 30,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            'Timeline',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.linear_scale,
            size: 30,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget _profileInfo(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('profile_image.jpg'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Ryan Barnes',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Product designer',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterButton(ProfileScreenBloc bloc){
    return FilterButton(bloc: bloc,);
  }

  Widget _listTitle(context){
    return Padding(
      padding: const EdgeInsets.only(left: 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'My Tasks',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'June 16, 2019',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

}

