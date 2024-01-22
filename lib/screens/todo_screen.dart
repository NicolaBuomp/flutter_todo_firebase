// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      // Puoi gestire l'errore qui, ad esempio mostrando un messaggio all'utente
    }
  }

  void editTodo() {
    // Funzione da eseguire quando si preme l'icona di modifica
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

          // Estrai i documenti dalla snapshot
          List<DocumentSnapshot> todos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // Estrai il titolo della todo
              String title = todos[index]['title'];
              String dateString = todos[index]['endDate'];
              String todoId = todos[index].id;

              // Converti la stringa in un oggetto DateTime
              DateTime endDate = DateTime.parse(dateString);

              // Formatta la data come "20/01/2024"
              String formattedDate = DateFormat('dd/MM/yyyy').format(endDate);

              // Verifica se la data di scadenza è inferiore a quella odierna
              bool isExpired = endDate.isBefore(DateTime.now());

              return ListTile(
                title: Text(title),
                subtitle: Row(
                  children: [
                    Text(
                      'Data di scadenza: $formattedDate',
                      style: TextStyle(
                        color: isExpired ? Colors.red : null,
                      ),
                    ),
                    const Spacer(), // Aggiunge uno spazio flessibile tra le icone
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
          );
        },
      ),
    );
  }
}
