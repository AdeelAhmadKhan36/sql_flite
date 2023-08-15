import 'package:flutter/material.dart';
import 'package:sql_flite/DatabaseModel/Notes.dart';
import 'package:sql_flite/de_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQL Lite"),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbHelper!.insert(

              NotesModel(
              title: 'My first title',
              age: 20,
              description: 'My first Database',
              email: 'Adeel@gmail.com')

          ).then((value) {
            print('Data is Added sucessfully');

          }).onError((error, stackTrace){
            print(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
