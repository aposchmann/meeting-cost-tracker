import 'package:flutter/material.dart';

import '../meeting/meeting_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = "Meeting Cost Tracker";

    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: MeetingScreen(title: title),
    );
  }
}
