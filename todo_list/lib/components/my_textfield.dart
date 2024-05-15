// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  MyTextfield(
      {super.key, required this.hintText, required this.obscureText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          // Affiche le clavier pour rentrer l'email. 
          // keyboardType: TextInputType.emailAddress,
          // Masque les caractères saisis dans le champ.
          obscureText: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade700
                )),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
          ),
        ));
  }
}
