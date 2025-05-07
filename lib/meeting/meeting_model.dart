import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'meeting_participant.dart';

class MeetingModel extends ChangeNotifier {
  final List<MeetingParticipant> _participants = [];
  DateTime? _startTime;
  DateTime? _endTime;
  Timer? _timer;
  Duration _duration = Duration.zero;
  bool _isRunning = false;

  UnmodifiableListView<MeetingParticipant> get participants =>
      UnmodifiableListView(_participants);

  bool get isRunning => _isRunning;

  Duration get duration => _isRunning
      ? _duration + DateTime.now().difference(_startTime!)
      : _duration;

  double get totalCost {
    final durationInHours = duration.inMilliseconds / (1000 * 60 * 60);
    return _participants.fold(0,
        (sum, participant) => sum + participant.hourlyRate * durationInHours);
  }

  void add(MeetingParticipant participant) {
    _participants.add(participant);
    notifyListeners();
  }

  void startMeeting() {
    if (_isRunning) return;

    _isRunning = true;
    _startTime = DateTime.now();

    // Start a timer to update the UI every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });

    notifyListeners();
  }

  void stopMeeting() {
    if (!_isRunning) return;

    _isRunning = false;
    _endTime = DateTime.now();

    // Add the elapsed time to the total duration
    _duration += _endTime!.difference(_startTime!);

    // Cancel the timer
    _timer?.cancel();
    _timer = null;

    notifyListeners();
  }

  void resetMeeting() {
    stopMeeting();
    _duration = Duration.zero;
    _startTime = null;
    _endTime = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
