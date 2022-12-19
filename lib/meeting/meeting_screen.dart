import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'meeting_model.dart';
import 'meeting_participant_list.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.participants,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ChangeNotifierProvider<MeetingModel>(
                  create: (context) => MeetingModel(),
                  child: const MeetingParticipantList()),
            ),
          ],
        ),
      ),
    );
  }
}
