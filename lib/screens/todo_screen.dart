// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_firebase/widgets/FormattedDateText.dart';
import 'package:intl/intl.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> deleteTodo(String todoId) async {
    try {
      await todosCollection.doc(todoId).delete();
      print('Todo eliminato con successo');
    } catch (e) {
      print('Errore durante l\'eliminazione del todo: $e');
    }
  }

  void editTodo() {
    print('Modifica todo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: todosCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Text('Errore durante il recupero dei dati');
          }

          List<DocumentSnapshot> todos = snapshot.data!.docs;

          return todos.length > 0 ? ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // Estrai il titolo della todo
              String todoId = todos[index].id;

              return ListTile(
                title: Text(todos[index]['title']),
                subtitle: Row(
                  children: [
                    FormattedDateText(
                      dateTime: todos[index]['endDate'],
                      showTime: true,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => deleteTodo(todoId),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                        width: 8), // Aggiunge uno spazio tra le icone
                    GestureDetector(
                      onTap: editTodo,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
              : Center(child: Text('Non ci sono Todo da mostrare', style: TextStyle(fontSize: 18)));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.pushNamed(context, 'form');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
