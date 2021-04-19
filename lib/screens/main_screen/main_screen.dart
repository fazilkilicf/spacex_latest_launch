import 'package:flutter/material.dart';
import 'package:spacex_latest_launch/screens/main_screen/local_widgets/app_bar.dart';
import 'package:spacex_latest_launch/screens/main_screen/local_widgets/body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: Body(),
    );
  }
}
