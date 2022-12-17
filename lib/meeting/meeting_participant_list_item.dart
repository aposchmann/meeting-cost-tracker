import 'package:flutter/material.dart';

class MeetingParticipantListItem extends StatelessWidget {
  const MeetingParticipantListItem({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
