import 'package:flutter_test/flutter_test.dart';
import 'package:meeting_cost_tracker/meeting/meeting_model.dart';
import 'package:meeting_cost_tracker/meeting/meeting_participant.dart';

void main() {
  test("Creates meeting model with empty list of participants",
      () => {expect(MeetingModel().participants, [])});

  test("Adds a new participant to the meeting model", () {
    final meetingModel = MeetingModel();

    final meetingParticipant =
        MeetingParticipant(name: "Test Participant", hourlyRateInCent: 420);

    meetingModel.add(meetingParticipant);

    expect(meetingModel.participants, [meetingParticipant]);
  });

  test("Notifies listeners on adding a new participant", () {
    final meetingModel = MeetingModel();

    var callbackCalled = false;

    meetingModel.addListener(() {
      callbackCalled = true;
    });

    meetingModel.add(
        MeetingParticipant(name: "Test Participant", hourlyRateInCent: 420));

    expect(callbackCalled, true);
  });
}
