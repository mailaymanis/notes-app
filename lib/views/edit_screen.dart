import 'package:flutter/material.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Edit Note",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withValues(alpha: 0.2),
              ),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: 20,
              children: [
                CustomTextField(
                  hintText: "Title",
                  label: "Title",
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  hintText: "Content",
                  label: "Content",
                  controller: contentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Content is required";
                    }
                    return null;
                  },
                ),
                CustomButton(onPressed: () {}, text: "Edit Note"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
