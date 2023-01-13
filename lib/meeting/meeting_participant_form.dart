import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
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
  final _hourlyRateController = TextEditingController();

  var _showForm = false;

  void _toggleForm() {
    setState(() {
      _showForm = !_showForm;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hourlyRateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final decimalSeparator =
        numberFormatSymbols[localizations.localeName]?.DECIMAL_SEP ?? ".";

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
                      return localizations.formInputFeedbackMissingValue;
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _hourlyRateController,
                  decoration: InputDecoration(
                      icon: const Icon(Icons.payments),
                      labelText: localizations.meetingParticipantHourlyRate,
                      hintText: localizations.meetingParticipantHourlyRateHint),
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) => _onSubmit(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.formInputFeedbackMissingValue;
                    }

                    if (!RegExp(r'^\d+(?:[' + decimalSeparator + r']\d{1,2})?$')
                        .hasMatch(value)) {
                      return localizations.formInputFeedbackInvalidMoneyValue;
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
    final localizations = AppLocalizations.of(context)!;

    if (currentState!.validate()) {
      Provider.of<MeetingModel>(context, listen: false).add(MeetingParticipant(
          name: _nameController.text,
          hourlyRateInCent:
              NumberFormat.simpleCurrency(locale: localizations.localeName)
                  .parse(_hourlyRateController.text)));

      currentState.reset();

      _toggleForm();
    }
  }
}
