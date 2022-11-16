import 'package:flutter/material.dart';

import 'meeting_participant_list_item.dart';

class MeetingParticipantList extends StatefulWidget {
  const MeetingParticipantList({super.key});

  @override
  State<MeetingParticipantList> createState() => _MeetingParticipantListState();
}

class _MeetingParticipantListState extends State<MeetingParticipantList> {
  List<String> participants = ["John Doe", "Jane Doe", "Semsigül Poschmann"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...participants
            .map((participant) => MeetingParticipantListItem(
                  participantName: participant,
                ))
            .toList(),
        const MeetingParticipantListItem()
      ],
    );
  }
}
