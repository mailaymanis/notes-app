import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes_app/database/sql_database.dart';

class TestDatabase extends StatefulWidget {
  const TestDatabase({super.key});

  @override
  State<TestDatabase> createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  SqlDatabase sqlDb = SqlDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              var response = await sqlDb.readData("SELECT * FROM notes");
              log(response.toString());
            },
            child: Text("Read Data"),
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await sqlDb.insertData(
                "INSERT INTO notes (title , content) VALUES ('first note' , 'my name is ahmed')",
              );
              log(response.toString());
            },
            child: Text("Insert Data"),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Update Data")),
          ElevatedButton(onPressed: () {}, child: Text("Delete Data")),
        ],
      ),
    );
  }
}
