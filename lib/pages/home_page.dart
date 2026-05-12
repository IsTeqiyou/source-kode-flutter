import 'package:flutter/material.dart';
import 'package:noteapp/pages/note_page.dart';
import '../services/database_helper.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';

// ================= WIDGET =================
class HomePage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const HomePage({super.key, required this.onToggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ================= STATE =================
class _HomePageState extends State<HomePage> {
  List<Note> notes = [];

  // ================= LOAD DATA (DATABASE → UI) =================
  Future<void> loadNotes() async {
    final data = await DatabaseHelper.instance.getAllNotes();
    //ini kaya refres
    setState(() {
      notes = data;
    });
  }

  // ================= NAVIGATION + CRUD HANDLER =================
  void goToNotePage({Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotePage(note: note)),
    );

    // ===== DELETE =====
    if (result == "delete" && note?.id != null) {
      await DatabaseHelper.instance.deleteNote(note!.id!);
      await loadNotes();
    }
    // ===== UPDATE =====
    else if (result is Note && note != null) {
      await DatabaseHelper.instance.updateNote(result);
      await loadNotes();
    }
    // ===== INSERT =====
    else if (result is Note) {
      await DatabaseHelper.instance.insertNote(result);
      await loadNotes();
    }
  }

  // ================= INIT (PERTAMA KALI LOAD DATA) =================
  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // ===== APP BAR =====
      appBar: AppBar(
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      // ===== BACKGROUND =====
      backgroundColor: theme.scaffoldBackgroundColor,

      // ===== BODY =====
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

                  // ===== EDIT =====
                  onEdit: () => goToNotePage(note: notes[index]),

                  // ===== DELETE =====
                  onDelete: () => goToNotePage(note: notes[index]),
                );
              },
            ),

      // ===== FLOATING BUTTON (ADD NOTE) =====
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToNotePage(),
        child: const Icon(Icons.add),
      ),
    );
  }
}