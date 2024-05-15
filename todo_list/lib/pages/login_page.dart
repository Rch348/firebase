// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/auth/auth_service.dart';
import '../components/my_textfield.dart';
import '../components/my_button.dart';

class LoginPage extends StatelessWidget {
  final void Function() onTap;

  LoginPage({super.key, required this.onTap});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  void login(BuildContext context) async {
    // Instanciation de l'AuthService.
    final AuthService authService = AuthService();

    // Essai de connexion.
    try {
      await authService.signIn(emailController.text, pwdController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.login, size: 60),
          SizedBox(
            height: 48,
          ),
          Text(
            'Welcome back, we missed you !',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 24,
          ),
          MyTextfield(
            hintText: 'Email',
            obscureText: false,
            controller: emailController,
          ),
          SizedBox(
            height: 16,
          ),
          MyTextfield(
              hintText: 'Password',
              obscureText: true,
              controller: pwdController),
          SizedBox(
            height: 16,
          ),
          MyButton(
            text: 'Login',
            onPressed: () => login(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Not a member ?'),
              TextButton(
                onPressed: onTap,
                child: Text(
                  'Register now',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
