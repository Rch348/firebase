import 'package:cloud_firestore/cloud_firestore.dart';

class UserstoreService 
{
   final CollectionReference users =
         FirebaseFirestore.instance.collection('users');

   Future<void> addUser
   (
      String uid, 
      String lastname, 
      String firstname, 
      String birthdate
   ) 
   {
   //    return users.add
   //    (
   //       {
   //          'userId': uid,
   //          'lastname': lastname,
   //          'firstname': firstname,
   //          'birthdate': birthdate
   //       }
   //    );
   //

   return users.doc(uid).set
   (
      {
         'lastname': lastname, 
         'firstname': firstname, 
         'birthdate': birthdate
         }
      );
   }
}
