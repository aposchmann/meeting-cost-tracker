import 'package:flutter/material.dart';

class MeetingParticipantList extends StatefulWidget {
  const MeetingParticipantList({Key? key}) : super(key: key);

  @override
  State<MeetingParticipantList> createState() => _MeetingParticipantListState();
}

class _MeetingParticipantListState extends State<MeetingParticipantList> {
  List<String> participants = ["John Doe", "Jane Doe", "Semsigül Poschmann"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: participants.map((participant) => Text(participant)).toList(),
    );
  }
}
