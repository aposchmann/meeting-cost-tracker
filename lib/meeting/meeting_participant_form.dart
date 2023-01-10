import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'meeting_model.dart';
import 'meeting_participant.dart';

class MeetingParticipantForm extends StatefulWidget {
  const MeetingParticipantForm({super.key});

  @override
  State<MeetingParticipantForm> createState() => _MeetingParticipantFormState();
}

class _MeetingParticipantFormState extends State<MeetingParticipantForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  var _showForm = false;

  void _toggleForm() {
    setState(() {
      _showForm = !_showForm;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;

    return _showForm
        ? Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      labelText: localizations.meetingParticipantName,
                      hintText: localizations.meetingParticipantNameHint),
                  maxLength: 30,
                  onFieldSubmitted: (_) => _onSubmit(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.formInputFeedbackMissingText;
                    }

                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: Text(localizations.buttonAdd))
              ],
            ))
        : IconButton(
            onPressed: () => _toggleForm(),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
            ));
  }

  void _onSubmit(BuildContext context) {
    final currentState = _formKey.currentState;

    if (currentState!.validate()) {
      Provider.of<MeetingModel>(context, listen: false).add(
          MeetingParticipant(name: _nameController.text, hourlyRateInCent: 42));

      currentState.reset();

      _toggleForm();
    }
  }
}
