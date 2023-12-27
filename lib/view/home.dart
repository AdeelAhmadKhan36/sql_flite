import 'package:flutter/material.dart';
import 'package:sql_flite/DatabaseModel/Notes.dart';
import 'package:sql_flite/view/add_notes.dart';
import 'package:sql_flite/view/buttom_sheet.dart';
import 'package:sql_flite/view_model/de_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text("NOTES APP"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<NotesModel>>(
              future: notesList,
              builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No data available');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,

                    itemBuilder: (context, index) {
                      final note = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          dbHelper!.update(
                            NotesModel(
                              id: snapshot.data![index].id!,
                              title: 'Updated',
                              description:
                                  'after the updation the following result is shown',
                              email: 'AdeelAhmad@gmail.com',
                            ),
                          );
                          setState(() {
                            notesList = dbHelper!.getNotesList();
                          });
                        },
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              dbHelper!.delete(snapshot.data![index].id!);
                              notesList = dbHelper!.getNotesList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          key: ValueKey<int>(snapshot.data![index].id!),
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.delete_forever),
                          ),
                          child: Container(
                            height: 100,
                            color: Colors.orange,
                            child: Card(
                              child: ListTile(
                                title:
                                    Text(snapshot.data![index].title.toString(),style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold
                                    ),),
                                subtitle: Text(
                                    snapshot.data![index].description.toString(),style:TextStyle(fontSize: 16),),
                                trailing:SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        setState(() {
                                          showModalBottomSheet(context: context, builder: (BuildContext context){
                                            return EditNoteBottomSheet(note: snapshot.data![index]);
                                          });
                                        });

                                        }, icon:Icon(Icons.edit)),
                                      IconButton(onPressed: (){
                                        dbHelper!.delete(note.id!);
                                        print("here is id: ${note.id}");

                                        setState(() {

                                          notesList=dbHelper!.getNotesList();
                                        });
                                      },


                                          icon:Icon(Icons.delete))
                                    ],
                                  ),

                                ),

                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(
                onNoteAdded: (newNote) {
                  // Add the new note to the database
                  dbHelper!.insert(newNote).then((value) {
                    print('Data added Successfully');
                    setState(() {
                      notesList = dbHelper!.getNotesList();
                    });
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add,),
      ),
    );
  }
}
