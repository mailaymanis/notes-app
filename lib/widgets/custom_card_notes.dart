import 'package:flutter/material.dart';

class CustomCardNotes extends StatelessWidget {
  const CustomCardNotes({
    super.key,
    required this.content,
    required this.title,
    required this.deleteOnPressed,
    required this.editOnPressed,
  });
  final String title;
  final String content;
  final void Function()? deleteOnPressed;
  final void Function()? editOnPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent.withValues(alpha: 0.7),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          title: Text(title, style: TextStyle(color: Colors.white)),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content, style: TextStyle(color: Colors.white)),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: deleteOnPressed,
                icon: Icon(
                  Icons.delete,
                  color: Colors.black.withValues(alpha: 0.7),
                ),
              ),
              IconButton(
                onPressed: editOnPressed,
                icon: Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
