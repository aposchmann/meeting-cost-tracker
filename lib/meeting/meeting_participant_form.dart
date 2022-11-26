import 'package:flutter/material.dart';

class MeetingParticipantForm extends StatefulWidget {
  const MeetingParticipantForm({Key? key}) : super(key: key);

  @override
  State<MeetingParticipantForm> createState() => _MeetingParticipantFormState();
}

class _MeetingParticipantFormState extends State<MeetingParticipantForm> {
  final _formKey = GlobalKey<FormState>();

  var _showForm = false;

  void _toggleForm() {
    setState(() {
      _showForm = !_showForm;
    });
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
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Name",
                      hintText: "Der Name des Teilnehmers"),
                  maxLength: 30,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bitte geben Sie einen Text ein";
                    }

                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      final currentState = _formKey.currentState;

                      if (currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Speichern ...")));

                        currentState.reset();

                        _toggleForm();
                      }
                    },
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
}
