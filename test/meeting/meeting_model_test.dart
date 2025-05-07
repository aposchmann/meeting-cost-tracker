import 'package:flutter_test/flutter_test.dart';
import 'package:meeting_cost_tracker/meeting/meeting_model.dart';
import 'package:meeting_cost_tracker/meeting/meeting_participant.dart';

void main() {
  group('Participant management', () {
    test("Creates meeting model with empty list of participants",
        () => {expect(MeetingModel().participants, [])});

    test("Adds a new participant to the meeting model", () {
      final meetingModel = MeetingModel();

      final meetingParticipant =
          MeetingParticipant(name: "Test Participant", hourlyRate: 420);

      meetingModel.add(meetingParticipant);

      expect(meetingModel.participants, [meetingParticipant]);
    });

    test("Notifies listeners on adding a new participant", () {
      final meetingModel = MeetingModel();

      var callbackCalled = false;

      meetingModel.addListener(() {
        callbackCalled = true;
      });

      meetingModel
          .add(MeetingParticipant(name: "Test Participant", hourlyRate: 420));

      expect(callbackCalled, true);
    });
  });

  group('Meeting timing', () {
    test('Initial meeting state is not running', () {
      final meetingModel = MeetingModel();
      expect(meetingModel.isRunning, false);
    });

    test('Starting a meeting changes state to running', () {
      final meetingModel = MeetingModel();
      meetingModel.startMeeting();
      expect(meetingModel.isRunning, true);
    });

    test('Stopping a meeting changes state to not running', () {
      final meetingModel = MeetingModel();
      meetingModel.startMeeting();
      meetingModel.stopMeeting();
      expect(meetingModel.isRunning, false);
    });

    test('Starting a meeting notifies listeners', () {
      final meetingModel = MeetingModel();
      var callbackCalled = false;

      meetingModel.addListener(() {
        callbackCalled = true;
      });

      meetingModel.startMeeting();
      expect(callbackCalled, true);
    });

    test('Stopping a meeting notifies listeners', () {
      final meetingModel = MeetingModel();
      meetingModel.startMeeting();

      var callbackCalled = false;
      meetingModel.addListener(() {
        callbackCalled = true;
      });

      meetingModel.stopMeeting();
      expect(callbackCalled, true);
    });

    test('Resetting a meeting sets duration to zero', () {
      final meetingModel = MeetingModel();
      meetingModel.startMeeting();

      // Wait a bit to accumulate some duration
      Future.delayed(const Duration(milliseconds: 100));

      meetingModel.stopMeeting();
      meetingModel.resetMeeting();

      expect(meetingModel.duration, Duration.zero);
    });

    test('Resetting a meeting notifies listeners', () {
      final meetingModel = MeetingModel();
      var callbackCalled = false;

      meetingModel.addListener(() {
        callbackCalled = true;
      });

      meetingModel.resetMeeting();
      expect(callbackCalled, true);
    });
  });

  group('Meeting cost calculation', () {
    test('Initial total cost is zero', () {
      final meetingModel = MeetingModel();
      expect(meetingModel.totalCost, 0);
    });

    test('Total cost is calculated based on participants and duration',
        () async {
      final meetingModel = MeetingModel();

      // Add participants with different hourly rates
      meetingModel
          .add(MeetingParticipant(name: "Participant 1", hourlyRate: 100));
      meetingModel
          .add(MeetingParticipant(name: "Participant 2", hourlyRate: 200));

      // Start the meeting
      meetingModel.startMeeting();

      // Wait for a specific duration
      await Future.delayed(const Duration(seconds: 1));

      // Stop the meeting
      meetingModel.stopMeeting();

      // Calculate expected cost (1 second = 1/3600 hour)
      final expectedCostPerHour = 100 + 200; // Sum of hourly rates
      final durationInHours =
          meetingModel.duration.inMilliseconds / (1000 * 60 * 60);
      final expectedCost = expectedCostPerHour * durationInHours;

      // Allow for small differences due to timing
      expect(meetingModel.totalCost, closeTo(expectedCost, 0.1));
    });
  });

  test('Dispose cancels the timer', () {
    final meetingModel = MeetingModel();
    meetingModel.startMeeting();

    // This should not throw an error
    meetingModel.dispose();
  });
}
