import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/database/sql_database.dart';
import 'package:notes_app/views/home_screen.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({super.key});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  SqlDatabase sqlDb = SqlDatabase();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Colors.indigo,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder:
              (context) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 20,
                      children: [
                        SizedBox(height: 16),
                        CustomTextField(
                          hintText: "Title",
                          label: "title",
                          controller: titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          hintText: "Content",
                          label: "content",
                          controller: contentController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Content is required';
                            }
                            return null;
                          },
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              var response = await sqlDb.insertData(
                                "INSERT INTO notes (title , content) VALUES ('${titleController.text}' , '${contentController.text}')",
                              );
                              log(response.toString());

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
                          text: "Save Note",
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
