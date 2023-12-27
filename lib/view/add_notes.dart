// add_note_screen.dart

import 'package:flutter/material.dart';
import 'package:sql_flite/DatabaseModel/Notes.dart';


class AddNoteScreen extends StatefulWidget {
  final Function(NotesModel) onNoteAdded;

  const AddNoteScreen({Key? key, required this.onNoteAdded}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size.fromHeight(50.0)),
                // Set the background color of the button
                backgroundColor: MaterialStateProperty.all(Colors.indigo),

              ),
              onPressed: () {
                final newNote = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  email: 'dummy@gmail.com', // You may modify this as needed
                );

                widget.onNoteAdded(newNote);
                Navigator.of(context).pop();
              },
              child: const Text('Create New'),
            ),
          ],
        ),
      ),
    );
  }
}
