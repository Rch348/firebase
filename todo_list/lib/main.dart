// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list/auth/auth_gate.dart';
import 'package:todo_list/theme/light_mode.dart';
// import 'package:todo_list/pages/main_page.dart';
import 'firebase_options.dart';

void main() async 
{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp
   (
      options: DefaultFirebaseOptions.currentPlatform,
   );
   runApp(const TodoList());
}

class TodoList extends StatelessWidget 
{
   const TodoList({super.key});

   @override
   Widget build(BuildContext context) 
   {
      return MaterialApp
      (
         debugShowCheckedModeBanner: false,
         theme: lightMode,
         home: AuthGate(),
      );
   }
}
