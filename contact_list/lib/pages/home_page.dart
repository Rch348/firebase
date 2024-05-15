// ignore_for_file: prefer_const_constructors, unused_element, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_list/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instanciation de la classe FirestoreService() se trouvant dans le fichier ;
  
  final FirestoreService firestore = FirestoreService();

  final TextEditingController textController = TextEditingController();

  // Fonction ouvrant une boîte de dialogue affichant le formaulaire pour ajouter/modifier un contact.
  void openContactForm({String? docId}) {
    showDialog(
        // Utilisé avec StatefulWidget.
        context: context,
        builder: (context) => AlertDialog(
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (docId == null) {
                        // Ajout d'un nouveau contact.
                        firestore.addContact(textController.text);
                      } else {
                        firestore.updateContact(docId, textController.text);
                      }
                      
                      // Supprime le texte du controlleur.
                      textController.clear();

                      // Ferme la boîte de dialogue.
                      Navigator.pop(context);
                    },
                    child: docId == null ? Text('Ajouter le contact :') : Text('Modifier le contact'),
                  ),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.getContactsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List contactsList = snapshot.data!.docs;
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: contactsList.length,
                  itemBuilder: (context, index) {
                    // Récupération de chaque document dans la liste à chaque tour.
                    DocumentSnapshot document = contactsList[index];
                    // Récupération de l'id du document parcouru.
                    String docId = document.id;
                    // Récupération du nom du contact.
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String contactName = data['name'];
                    // Conversion du Timestamp en DateTime pour avoir un format + adapté.
                    DateTime date = (data['timestamp'] as Timestamp).toDate();
                    String contactTime =
                        DateFormat('dd/MM/yyyy, HH:mm').format(date).toString();
                    // Si déjà fait dans le firestore :
                    // String contactTime = data['timestamp'].toString();

                    return Card(
                        child: ListTile(
                            title: Text(contactName),
                            subtitle: Text(contactTime),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () =>
                                      openContactForm(docId: docId),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      firestore.deleteContact(docId),
                                ),
                              ],
                            )
                        )
                    );
                  },
                ));
          } else {
            return Text('Aucun contact...');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
