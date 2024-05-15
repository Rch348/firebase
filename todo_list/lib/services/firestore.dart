// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FirestoreService 
{
   final CollectionReference todoList = FirebaseFirestore.instance.collection('todolist');
   
   get users => null;

   Future<void> addTask(String uid, String task) 
   {
      // return todolist.add
      // (
      //    {
      //       'task': task,
      //       'state': false,
      //       'timestamp': DateFormat('dd/MM/yyy').format(DateTime.now())       
      //    }
      // );
      final userStore = users.doc(uid).collection('todolist.path');

      return userStore.add
      (
         {
            'task': task,
            'state': false,
            'timestamp': DateFormat('dd/MM/yyy').format(DateTime.now())
         }
      );
   }

   Stream<QuerySnapshot> getTodolistByUserStream(uid) 
   {
      // final userStore = users.doc(uid).collection(todoList.path);
      final TodolistStream = todoList.orderBy('timestamp', descending: true).snapshots();
      return TodolistStream;
   }

   Future<void> updateTask(String id, String newTask) 
   {
      return todoList.doc(id).update
      (
         {
            'task': newTask,    
         }
      );
   }

   Future<void> deleteTask(String id) 
   {
      return todoList.doc(id).delete();
   }
}
