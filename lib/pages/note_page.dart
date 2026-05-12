import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotePage extends StatefulWidget {
  final Note? note;

  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final authorController = TextEditingController();

  bool _isSaving = false; // 🔴 anti double save

  // ================= INIT =================
  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      authorController.text = widget.note!.author;
    }
  }

  // ================= DISPOSE =================
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    super.dispose();
  }

  // ================= SAVE NOTE =================
  void saveNote() {
    if (_isSaving) return;
    _isSaving = true;

    if (!mounted) return;

    // 🔴 VALIDASI INPUT
    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      Navigator.pop(context);
      return;
    }

    final now = DateTime.now().toIso8601String();

    final note = Note(
      id: widget.note?.id,
      title: titleController.text,
      content: contentController.text,
      author: authorController.text,
      createdAt: widget.note?.createdAt ?? now,
      updatedAt: now,
    );

    Navigator.pop(context, note);
  }

  // ================= DELETE =================
  void deleteNote() async {
    //tambah bagian ini
    final navigator = Navigator.of(context);

    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin ingin menghapus?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirm == true) {
      //ubah bagian ini
      navigator.pop("delete");
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop || _isSaving) return;

          //hapus beberapa bagian
          saveNote();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: saveNote,
            ),
            actions: [
              //penyesuaian tombol hapus data
              if (widget.note != null)
                IconButton(
                  onPressed: deleteNote,
                  icon: const Icon(Icons.delete),
                ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===== TITLE =====
                TextField(
                  controller: titleController,
                  autofocus: true, // 🔴 UX improvement
                  style: theme.textTheme.titleLarge,
                  decoration: const InputDecoration(
                    hintText: "Judul",
                    border: InputBorder.none,
                  ),
                ),

                const SizedBox(height: 10),

                // ===== CONTENT =====
                Expanded(
                  child: TextField(
                    controller: contentController,
                    style: theme.textTheme.bodyMedium,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: "Tulis catatan...",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Divider(color: theme.dividerColor.withValues(alpha: 0.3)),

                const SizedBox(height: 6),

                // ===== AUTHOR =====
                TextField(
                  controller: authorController,
                  style: theme.textTheme.bodySmall,
                  decoration: const InputDecoration(
                    hintText: "Ditulis oleh...",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}