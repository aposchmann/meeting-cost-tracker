import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'meeting_participant.dart';

class MeetingParticipantEntry extends StatelessWidget {
  const MeetingParticipantEntry({super.key, required this.participant});

  final MeetingParticipant participant;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: Text(
            participant.name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Text(
          NumberFormat.simpleCurrency(locale: localizations.localeName)
              .format(participant.hourlyRate),
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
