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
    final participants = Provider.of<MeetingModel>(context).participants;

    return ListView.separated(
        itemBuilder: (context, index) => index == participants.length
            ? const MeetingParticipantListItem(child: MeetingParticipantForm())
            : MeetingParticipantListItem(
                child: MeetingParticipantEntry(
                participant: participants[index],
              )),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: participants.length + 1);
  }
}
