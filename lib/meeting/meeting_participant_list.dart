import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'meeting_model.dart';
import 'meeting_participant_entry.dart';
import 'meeting_participant_form.dart';
import 'meeting_participant_list_item.dart';

class MeetingParticipantList extends StatelessWidget {
  const MeetingParticipantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...Provider.of<MeetingModel>(context)
            .participants
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
