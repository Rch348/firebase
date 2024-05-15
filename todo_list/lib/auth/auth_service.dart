import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, password) async {
    try {
      // Récupère les informations de l'utilisateur (ici, email et mdp).
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      // Ou, renvoie une exception.
      throw Exception(e.code);
    }
  }

  // signup / register
  Future<UserCredential> signUp(String email, password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

  // signout / logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
