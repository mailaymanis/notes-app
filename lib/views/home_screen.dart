import 'package:flutter/material.dart';
import 'package:notes_app/database/sql_database.dart';
import 'package:notes_app/views/edit_screen.dart';
import 'package:notes_app/widgets/custom_card_notes.dart';
import 'package:notes_app/widgets/custom_floating_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List notes = [];
  SqlDatabase sqlDb = SqlDatabase();

  readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(),
      appBar: AppBar(
        title: const Text(
          "Notes",
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
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
      body:
          isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: ListView(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return CustomCardNotes(
                          title: notes[index]["title"],
                          content: notes[index]["content"],
                          editOnPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditScreen(),
                              ),
                            );
                          },
                          deleteOnPressed: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}
