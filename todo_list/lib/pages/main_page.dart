// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:todo_list/auth/auth_service.dart';
// import 'package:todo_list/auth/login_or_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:todo_list/pages/login_page.dart';
// import 'package:todo_list/pages/register_page.dart';
import 'package:todo_list/services/firestore.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainPage extends StatefulWidget 
{
   
   const MainPage({super.key});

   @override
   State<MainPage> createState() => _MainPageState();

}


class _MainPageState extends State<MainPage> 
{
   
   final FirestoreService firestore = FirestoreService();
   
   final String userId = FirebaseAuth.instance.currentUser!.uid;

   final TextEditingController textController = TextEditingController();



   void openTaskForm({String? id}) 
   {
      showDialog
      (
         context: context,
         builder: (context) => AlertDialog
         (
               content: TextField
               (
                  controller: textController,
               ),
               actions: 
               [
                  ElevatedButton
                  (
                     onPressed: () 
                     {
                        if (id == null) 
                        {
                           firestore.addTask(textController.text, userId);
                        } 
                        else 
                        {
                           firestore.updateTask(id, textController.text);
                        }
                        textController.clear();
                        Navigator.pop(context);
                     },
                     child: id == null
                           ? Text('Ajouter une tâche')
                           : Text('Modifier une tâche')
                  )
               ],
         )
      );
   }



   void logout() 
   {
      final AuthService authService = AuthService();
      authService.signOut();
   }



   @override
   Widget build(BuildContext context) 
   {
      return Scaffold
      (
         appBar: AppBar
         (
            title: Text('To Do List'),
         ),
         body: StreamBuilder<QuerySnapshot>
         (
            stream: firestore.getTodolistByUserStream(userId),
            builder: 
            (
               (context, snapshot) 
               {
                  if (snapshot.hasData) 
                  {
                     List taskList = snapshot.data!.docs;
                     return Container
                     (
                        padding: EdgeInsets.all(10),
                        child: ListView.builder
                        (
                           itemCount: taskList.length,
                           itemBuilder: (context, index) 
                           {
                              DocumentSnapshot document = taskList[index];
                              String id = document.id;
                              Map<String, dynamic> data =
                                 document.data() as Map<String, dynamic>;
                              String taskName = data['task'];

                              return Card
                              (
                                 shape: Border.all
                                 (
                                    color: Colors.black45,
                                    style: BorderStyle.solid,
                                 ),
                                 surfaceTintColor: Colors.transparent,
                                 child: Slidable
                                 (
                                    key: UniqueKey(),

                                    // The start action pane is the one at the left or the top side.
                                    startActionPane: ActionPane
                                    (
                                       // A motion is a widget used to control how the pane animates.
                                       motion: const ScrollMotion(),

                                       // A pane can dismiss the Slidable.
                                       dismissible: DismissiblePane
                                       (
                                          onDismissed: () 
                                          {
                                             firestore.deleteTask(userId);
                                          }
                                       ),

                                       // All actions are defined in the children parameter.
                                       children: 
                                       [
                                          // A SlidableAction can have an icon and/or a label.
                                          SlidableAction
                                          (
                                             onPressed: (context) =>
                                                firestore.deleteTask(id),
                                             backgroundColor: Color(0xFFFE4A49),
                                             foregroundColor: Colors.white,
                                             icon: Icons.delete,
                                             label: 'Delete',
                                          ),
                                       ],
                                    ),
                                    child: ListTile
                                    (
                                       title: Text(taskName),
                                       trailing: Row
                                       (
                                             mainAxisSize: MainAxisSize.min,
                                             children: 
                                             [
                                             IconButton
                                             (
                                                icon: Icon
                                                (
                                                   Icons.edit
                                                ),
                                                onPressed: () => openTaskForm(id: id),
                                             ),
                                             IconButton
                                             (
                                                onPressed: () =>
                                                   firestore.deleteTask(id),
                                                icon: Icon
                                                (
                                                   Icons.delete
                                                )
                                             ),
                                          ]
                                       )
                                    ),
                                 )
                              );
                           }
                        )
                     );
                  } 
                  else 
                  {
                     return Text('Vous êtes à jour !');
                  }
               }
            )
         ),
         floatingActionButton: FloatingActionButton
         (
            onPressed: openTaskForm,
            child: Icon
            (
               Icons.add,
            )
         ),
      );

         // body: LoginOrRegister()
         // appBar: AppBar(
         //     title: Text('Home'),
         //     actions: [IconButton(onPressed: logout, icon: Icon(Icons.abc))]));
   }
}
