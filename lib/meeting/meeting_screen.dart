import 'package:flutter/material.dart';
import 'package:meeting_cost_tracker/meeting/meeting_participant_list.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SafeArea(
              child: Text(
                "Teilnehmer",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SafeArea(child: MeetingParticipantList())
          ],
        ),
      ),
    );
  }
}
