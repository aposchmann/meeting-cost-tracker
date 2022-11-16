import 'package:flutter/material.dart';

class MeetingParticipantListItem extends StatefulWidget {
  const MeetingParticipantListItem({super.key, this.participantName});

  final String? participantName;

  @override
  State<MeetingParticipantListItem> createState() =>
      _MeetingParticipantListItemState();
}

class _MeetingParticipantListItemState
    extends State<MeetingParticipantListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: Text(
            widget.participantName ?? "➕",
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}
