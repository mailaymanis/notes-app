import 'package:flutter/material.dart';
import 'package:notes_app/database/sql_database.dart';
import 'package:notes_app/views/home_screen.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, this.id, this.title, this.content});
  final int? id;
  final String? title;
  final String? content;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  SqlDatabase sqlDb = SqlDatabase();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title ?? "";
    contentController.text = widget.content ?? "";
    super.initState();
  }

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
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var response = await sqlDb.updateData(
                        "UPDATE notes SET title = '${titleController.text}' , content = '${contentController.text}' WHERE id = ${widget.id}",
                      );
                      if (response > 0) {
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      }
                    }
                  },
                  text: "Edit Note",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
