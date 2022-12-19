import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../meeting/meeting_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = "Meeting Cost Tracker";

    return MaterialApp(
      title: title,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("de")],
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: MeetingScreen(title: title),
    );
  }
}
