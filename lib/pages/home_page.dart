import 'package:flutter/material.dart';
import 'package:noteapp/pages/note_page.dart';
import 'package:noteapp/services/database_helper.dart';
// import 'package:noteapp/widgets/confirm_dialog.dart';
import 'package:noteapp/widgets/note_card.dart';
// import 'package:noteapp/pages/note_page.dart';
import '../models/note_model.dart';
// import '../widgets/note_card.dart';
// import '../widgets/confirm_dialog.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  Future<void> loadNotes() async{
    final data = await DatabaseHelper.instance.gettAllNotes();
    // ini kaya refres
    setState(() {
      notes = data;
    });
  }

void goToNotePage({Note? note}) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => NotePage(note: note)),
  );

  // DELETE
  if (result == "delete" && note?.id != null) {
    await DatabaseHelper.instance.deleteNote(note!.id!);
    await loadNotes();
    
  }

  //UPDATE

  else if (result is Note && note != null) {
    await DatabaseHelper.instance.updateNote(result);
    await loadNotes();
  }

  // INSERT
  else if (result is Note) {
    await DatabaseHelper.instance.insertNote(result);
    await loadNotes();
  }
 
}

@override
void initState() {
  super.initState();
  loadNotes();
}
  // ================= CRUD =================

  //=========== ADD ===========
  // void addNote(Note note) {
  //   setState(() {
  //     notes.add(note);
  //   });
  // }

  // // //=========== UPDATE =========
  // void updateNote(int index, Note note) {
  //   setState(() {
  //     notes[index] = note;
  //   });
  // }

  // //=========== DELETE =========

  // void deleteNote(int index) async {
  //   bool confirm = await showConfirmDialog(context);
  //   if (confirm) {
  //     setState(() {
  //       notes.removeAt(index);
  //     });
  //   }
  // }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      backgroundColor: theme.scaffoldBackgroundColor,

      body: notes.isEmpty
          ? Center(
              child: Text(
                "Belum ada catatan",
                style: theme.textTheme.bodyMedium,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: notes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],

                  // 👉 EDIT → buka halaman detail
                  onEdit: () => goToNotePage(note: notes[index]),

                  // 👉 DELETE langsung dari card
                  onDelete: () => goToNotePage(note: notes[index]),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => goToNotePage(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
