import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/in tl.dart';

class FirestoreService {
  // Get la collection des contacts.
  final CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  // CRUD = Create Read Update Delete

  // Create : ajouter un contact.
  Future<void> addContact(String name) {
    // Ajout d'un nouveau document dans la collection 'contacts' (BDD).
    return contacts.add({
      'name': name,
      // Timestamp : renvoie la date et l'heure d'enregistrement du contact (+ précis que Datetime mais moins personnalisable).
      'timestamp': Timestamp.now(),
      // 'timestamp': DateFormat('dd/MM/yyyy, HH:mm').format(DateTime.now()),
    });
  }

  // Read : récupérer les contacts (= GET).
  Stream<QuerySnapshot> getContactsStream() {
    // snapshots() : fait les appels pour mettre à jour le stream.
    final contactsStream =
        contacts.orderBy('timestamp', descending: true).snapshots();

    return contactsStream;
  }

  // UPDATE : mettre à jour un document existant (ici, un contact).
  Future<void> updateContact(String docId, String newName) {
    return contacts.doc(docId).update({
      'name': newName,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE : supprimer le document (contact).
  Future<void> deleteContact(String docId) {
    return contacts.doc(docId).delete();
  }
}
