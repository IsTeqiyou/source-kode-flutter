import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotePage extends StatefulWidget{
  final Note? note;

  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => NotePageState();
}

class  NotePageState extends State<NotePage> {
  final titlecontroler = TextEditingController();
  final descriptioncontroler = TextEditingController();
  final authorcontroler = TextEditingController();

  @override
  void initState(){
    super.initState();
    if(widget.note != null){
      titlecontroler.text = widget.note!.title;
      descriptioncontroler.text = widget.note!.content;
      authorcontroler.text = widget.note!.author;
    }
  }

  @override
  void dispose(){
    titlecontroler.dispose();
    descriptioncontroler.dispose();
    authorcontroler.dispose();
    super.dispose();
  }


// 1. Tambahkan ini di dalam class NotePageState (paling atas)
bool _isSaving = false; 

void savenote() {
  if (_isSaving) return;
  _isSaving = true;

  // 2. Hapus 'if(mounted) return' karena itu penyebab kode tidak jalan
  // 3. Perbaiki nama controller dan hapus '&&' gantung
  if (titlecontroler.text.trim().isEmpty && 
      descriptioncontroler.text.trim().isEmpty) {
    Navigator.pop(context); // N-nya harus besar
    return;
  }

  final now = DateTime.now().toIso8601String();
  final note = Note(
    id: widget.note?.id,
    title: titlecontroler.text,
    content: descriptioncontroler.text,
    author: authorcontroler.text,
    createdAt: widget.note?.createdAt ?? now,
    updatedAt: now
  );
    
  }

void deletenote()async {
  final confirm = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Apakah anda yakin ingin menghapus catatan ini?"),
      actions: [
        TextButton( 
          onPressed: () => Navigator.pop(context, false),
          child: Text("Batal"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text("Hapus"),
        )
      ],
    ),
  );

  if(confirm == true){
    
    // ignore: use_build_context_synchronously
    Navigator.pop(context,"delete");
  }

}
@override
Widget build(BuildContext context){
  Theme.of(context);
  return Scaffold(
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: savenote, // auto save saat back
      ),
      actions: [
        IconButton(
          onPressed: deletenote,
       icon:const Icon(Icons.delete_outline),
         )
      ],
    ),

    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: titlecontroler,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: const InputDecoration(
              hintText: "Judul",
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 10),

          Expanded(child: TextField(
            controller: descriptioncontroler,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              hintText: "Tulis sesuatu...",
              border: InputBorder.none,
            ),
          ),
          ),

          Divider(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),

          ),

          const SizedBox(height: 10),

          TextField(
            controller: authorcontroler,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              hintText: "Penulis",
              border: InputBorder.none,
            ),
          )
        ],
      )
    )
  );
}

}