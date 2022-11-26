import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'meeting_participant.dart';

class MeetingModel extends ChangeNotifier {
  final List<MeetingParticipant> _participants = [];

  UnmodifiableListView<MeetingParticipant> get participants =>
      UnmodifiableListView(_participants);

  void add(MeetingParticipant participant) {
    _participants.add(participant);

    notifyListeners();
  }
}
