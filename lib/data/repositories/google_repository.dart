import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    try {
      // Logowanie za pomocą Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Tworzenie poświadczenia dla Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Logowanie do Firebase z poświadczeniem
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Przykład: Wyświetlanie nazwy użytkownika
      print(userCredential.user?.displayName);
    } catch (e) {
      // Obsługa błędów logowania
      print('Sign-in with Google error: $e');
    }
  }
}
