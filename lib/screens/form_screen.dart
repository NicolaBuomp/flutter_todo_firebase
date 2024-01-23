import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDateTime;

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDateTime) {
      setState(() {
        _selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _selectedDateTime?.hour ?? 0,
          _selectedDateTime?.minute ?? 0,
        );
      });
    }
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && _selectedDateTime != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime!.year,
          _selectedDateTime!.month,
          _selectedDateTime!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  void _submitForm() {
    if (_titleController.text.isNotEmpty && _selectedDateTime != null) {

      FirebaseFirestore.instance.collection('todos').add({
        'title': _titleController.text,
        'done': false,
        'showTime': _selectedDateTime != null ? true : false,
        'endDate': _selectedDateTime,
      });

      // Clear the form fields
      _titleController.clear();
      _selectedDateTime = null;

      Navigator.pushNamed(context, 'todos');

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post aggiunto con successo'),
        ),
      );
    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Compila tutti i campi'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titolo'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _showDatePicker,
                  child: const Text('Seleziona Data'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _showTimePicker,
                  child: const Text('Seleziona Ora'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDateTime != null
                  ? 'Data e Ora selezionate: ${_selectedDateTime!.toString()}'
                  : 'Seleziona Data e Ora',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Aggiungi'),
            ),

          ],
        ),
      ),
    );
  }
}
