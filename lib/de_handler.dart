import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sql_flite/DatabaseModel/Notes.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

class DBHelper {
  static Database? _db;
  //use future function here;
  Future<Database> get db async {
    if (_db != null) {
      return db;
    } //else then create database
    _db = await initDatabase();
    return _db!;
  } //create init database function

  initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }
//Using Database Query
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE notes(id INTEGER  PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,age INTEGER NOT NULL,description TEXT NOT NULL,emailN TEXT NOTNULL)"
    );

  }
  //Entries in the Database
  Future<NotesModel> insert (NotesModel notesModel) async{
     var dbClient=await db;

     await dbClient.insert('notes', notesModel.toMap());
     return notesModel;
   }
   //on insert Completed mean Database is created and Table Created and values are inserted in the table.

//Now we will retriew the data.
             Future<List<NotesModel>> getNotesList() async{
               var dbClient=await db;
               final List<Map<String, Object?>>


             }

}
