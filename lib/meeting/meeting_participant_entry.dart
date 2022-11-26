import 'package:flutter/material.dart';

import 'meeting_participant.dart';

class MeetingParticipantEntry extends StatelessWidget {
  const MeetingParticipantEntry({super.key, required this.participant});

  final MeetingParticipant participant;

  @override
  Widget build(BuildContext context) {
    return Text(
      participant.name,
      style: const TextStyle(fontSize: 16),
    );
  }
}
