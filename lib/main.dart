import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_main_widget.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CustomMainWidget();
  }
}
