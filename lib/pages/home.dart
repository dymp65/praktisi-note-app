import 'package:flutter/material.dart';
import 'package:note_app/pages/detail.dart';
import 'package:note_app/pages/form.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/helpers/db_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NoteModel> listNote = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllNote();
    super.initState();
  }

  Future<void> _getAllNote() async {
    var list = await db.getAllNote();

    setState(() {
      listNote.clear();
      list!.forEach((element) {
        listNote.add(NoteModel.fromMap(element));
      });
    });
  }

  Future<void> _createNote() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (contetx) => FormPage()));

    if (result == 'simpan') {
      await _getAllNote();
    }
  }

  Future<void> _updateNote(NoteModel note) async {
    var result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailNotePage(note: note)));

    if (result == 'update') {
      await _getAllNote();
    }
  }

  Future<void> _deleteNote(NoteModel note, int index) async {
    await db.deleteNote(note.id!);

    setState(() {
      listNote.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 28,
        ),
        title: Text(
          'Note Taking App',
          // style: TextStyle(color: Colors.white),
        ),
      ),
      body: _noteBuilder(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _createNote();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _noteBuilder() {
    return SafeArea(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          itemCount: listNote.length,
          itemBuilder: (context, index) {
            var note = listNote[index];

            return GestureDetector(
              onTap: () {
                _updateNote(note);
              },
              onDoubleTap: () {
                showDeleteDialog(context, note, index);
              },
              child: _itemCard(note),
            );
            // return Text('${note.title}');
            // return Text(note.title!);
          }),
    );
  }

  Widget _itemCard(NoteModel note) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 8),
            // Text(note.note ?? ''),
          ],
        ),
      ),
    );
  }

  showDeleteDialog(BuildContext context, NoteModel note, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Apakah mau menghapus note ini?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                //fungsi date ke database
                await _deleteNote(note, index);
                Navigator.maybePop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Expanded(
                  child: Text(
                'Ya',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Expanded(
                  child: Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.black,
                ),
              )),
            )
          ],
        );
      },
    );
  }
}
