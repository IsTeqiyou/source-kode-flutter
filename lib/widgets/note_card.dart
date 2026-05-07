

import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget{
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  // ignore: use_key_in_widget_constructors
  const NoteCard({
    Key? key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final   theme = Theme.of(context);

    return GestureDetector(
      onTap: onEdit,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.2),
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start,
              children: [
                //TITLE
                Text(
                  note.title,
                  style: theme.textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),

                 const SizedBox(height: 6),


                  //content
                  Expanded(
                    child: Text(
                      note.content,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                   ) ),

                   const SizedBox(height:8),


                   //AUTHOR
                   Text(
                    note.author,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                   ),

                   //ACTION
                   Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     GestureDetector(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete,
                        size: 18,
                        color: theme.colorScheme.error 
                      
                      ),
                     )
                   ],
                   ),
            ],
        )
      ),
    );
  }

}