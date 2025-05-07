import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'meeting_model.dart';
import 'meeting_participant_list.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ChangeNotifierProvider<MeetingModel>(
          create: (context) => MeetingModel(),
          child: Column(
            children: [
              const MeetingCostTracker(),
              const SizedBox(height: 16),
              Text(
                localizations.meetingParticipants,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Expanded(
                child: MeetingParticipantList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeetingCostTracker extends StatelessWidget {
  const MeetingCostTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final model = Provider.of<MeetingModel>(context);
    final currencyFormat =
        NumberFormat.simpleCurrency(locale: localizations.localeName);

    // Format duration as HH:MM:SS
    final duration = model.duration;
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final durationText = '$hours:$minutes:$seconds';

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Meeting Cost Tracker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Duration: $durationText'),
                    const SizedBox(height: 8),
                    Text(
                      'Total Cost: ${currencyFormat.format(model.totalCost)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!model.isRunning)
                      ElevatedButton.icon(
                        onPressed: () => model.startMeeting(),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start'),
                      )
                    else
                      ElevatedButton.icon(
                        onPressed: () => model.stopMeeting(),
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => model.resetMeeting(),
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
