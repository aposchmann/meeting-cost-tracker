import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'meeting_model.dart';
import 'meeting_participant.dart';

class MeetingParticipantForm extends StatefulWidget {
  const MeetingParticipantForm({Key? key}) : super(key: key);

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
    return _showForm
        ? Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Name",
                      hintText: "Der Name des Teilnehmers"),
                  maxLength: 30,
                  onFieldSubmitted: (_) => _onSubmit(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte geben Sie einen Text ein";
                    }

                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text("Hinzufügen"))
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
      Provider.of<MeetingModel>(context, listen: false)
          .add(MeetingParticipant(name: _nameController.text));

      currentState.reset();

      _toggleForm();
    }
  }
}
