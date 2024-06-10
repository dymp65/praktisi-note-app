import 'package:flutter/material.dart';
import 'package:note_app/helpers/db_helper.dart';
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
  DbHelper db = DbHelper();
  bool _isEdit = false;
  String _appTitle = 'Detail Note';
  TextEditingController _judul = TextEditingController();
  TextEditingController _note = TextEditingController();

  Future<void> updateNote() async {
    await db.updateNote(
      NoteModel(
        id: widget.note?.id,
        title: _judul.text,
        note: _note.text,
      ),
    );

    Navigator.pop(context, "update");
  }

  _resetNote() {
    setState(() {
      _judul.text = widget.note?.title ?? '';
      _note.text = widget.note?.note ?? '';
    });
  }

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
        title: Text('$_appTitle'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
                _appTitle = _isEdit ? 'Edit Note' : 'Detail Note';
                _resetNote();
              });
            },
            icon: _isEdit ? Icon(Icons.close) : Icon(Icons.edit),
          ),
        ],
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
                readOnly: !_isEdit,
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
                readOnly: !_isEdit,
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
              _isEdit
                  ? ElevatedButton(
                      onPressed: () {
                        //fungsi update ke database
                        updateNote();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Expanded(
                          child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
