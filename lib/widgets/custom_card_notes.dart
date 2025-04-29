import 'package:flutter/material.dart';
import 'package:notes_app/views/edit_screen.dart';

class CustomCardNotes extends StatelessWidget {
  const CustomCardNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent.withValues(alpha: 0.7),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          isThreeLine: true,
          title: Text("title", style: TextStyle(color: Colors.white)),
          subtitle: Text("content", style: TextStyle(color: Colors.white)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                  color: Colors.black.withValues(alpha: 0.7),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditScreen()),
                  );
                },
                icon: Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
