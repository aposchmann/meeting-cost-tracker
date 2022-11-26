import 'package:flutter/material.dart';
import 'package:meeting_cost_tracker/meeting/meeting_participant_entry.dart';

import 'meeting_participant.dart';
import 'meeting_participant_form.dart';
import 'meeting_participant_list_item.dart';

class MeetingParticipantList extends StatefulWidget {
  const MeetingParticipantList({super.key});

  @override
  State<MeetingParticipantList> createState() => _MeetingParticipantListState();
}

class _MeetingParticipantListState extends State<MeetingParticipantList> {
  final participants = [
    MeetingParticipant(name: "John Doe"),
    MeetingParticipant(name: "Jane Doe"),
    MeetingParticipant(name: "Semsigül Poschmann")
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...participants
            .map((participant) => MeetingParticipantListItem(
                  child: MeetingParticipantEntry(
                    participant: participant,
                  ),
                ))
            .toList(),
        const MeetingParticipantListItem(child: MeetingParticipantForm())
      ],
    );
  }
}
