import 'package:flutter/material.dart';
import 'package:note_app/helpers/db_helper.dart';
import 'package:note_app/models/note_model.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DbHelper db = DbHelper();
  TextEditingController _judul = TextEditingController();
  TextEditingController _note = TextEditingController();

  Future<void> insertNote() async {
    await db.saveNote(NoteModel(
      title: _judul.text,
      note: _note.text,
    ));

    Navigator.pop(context, 'simpan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Form'),
      ),
      body: _boydBuilder(),
    );
  }

  Widget _boydBuilder() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Title'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _judul,
                decoration: const InputDecoration(
                  // label: Text('Title'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Note'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _note,
                maxLines: 10,
                decoration: const InputDecoration(
                  // label: Text('Note'),
                  // labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  insertNote();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  backgroundColor: Colors.blue,
                ),
                child: const Expanded(
                    child: Text(
                  'simpan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
