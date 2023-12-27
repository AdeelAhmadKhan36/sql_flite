import 'package:flutter/material.dart';
import 'package:sql_flite/DatabaseModel/Notes.dart';
import 'package:sql_flite/view_model/de_handler.dart';



class EditNoteBottomSheet extends StatefulWidget {
  final NotesModel note;

  EditNoteBottomSheet({required this.note});

  @override
  _EditNoteBottomSheetState createState() => _EditNoteBottomSheetState();
}

class _EditNoteBottomSheetState extends State<EditNoteBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Edit Note',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async{
              setState(()  {
                try {
                  // Update the note in the database (await the operation)
                   DBHelper().update(
                    NotesModel(
                      id: widget.note.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      // Set a default value or use another appropriate default
                    ),
                  );
                } catch (e) {
                  print('Error updating note: $e');
                }
              });
              // Close the bottom sheet
              Navigator.pop(context);
            },
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
