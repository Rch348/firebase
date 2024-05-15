// ignore_for_file: prefer_const_constructors

/*
  Création de l'instance Firebase dans l'application.
*/

import 'package:contact_list/firebase_options.dart';
import 'package:contact_list/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Pour s'assurer que le moteur de widgets de Flutter soit correctement initialisé et donc, garantir
  // que le framework est prêt à être utilisé.
  WidgetsFlutterBinding.ensureInitialized();
  // Initialise l'instance Firebase de l'application avec des options de configuration spécifiques à la plateforme 
  //(par rapport aux fichiers de configuration firebase_options.dart).
  // await : "Attends que Firebase ait fini de s'initialiser avant de continuer l'exécution."
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
