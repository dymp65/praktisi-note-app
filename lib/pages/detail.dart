import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class DetailNotePage extends StatefulWidget {
  final NoteModel? note;
  const DetailNotePage({
    super.key,
    this.note,
  });

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  void initState() {
    _judul.text = widget.note?.title ?? '';
    _note.text = widget.note?.note ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Note'),
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
                readOnly: true,
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
                readOnly: true,
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
            ],
          ),
        ),
      ),
    );
  }
}
