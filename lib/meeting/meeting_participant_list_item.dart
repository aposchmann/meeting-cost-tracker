import 'package:flutter/material.dart';

class MeetingParticipantListItem extends StatelessWidget {
  const MeetingParticipantListItem({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SafeArea(minimum: const EdgeInsets.all(15), child: child),
    );
  }
}
