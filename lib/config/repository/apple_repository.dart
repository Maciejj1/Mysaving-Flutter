import 'package:firebase_auth/firebase_auth.dart';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleRepository {
  final FirebaseAuth _firebaseAuth;

  AppleRepository(this._firebaseAuth);

  Future<void> signInWithAppleAndRedirectToDashboard() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // Scopes and options...
    );

    // Handle the credential...
    print(credential);

    // Firebase sign-in with credential
    final firebaseCredential = OAuthProvider("apple.com").credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    try {
      // Sign in with Firebase
      await _firebaseAuth.signInWithCredential(firebaseCredential);

      // Redirect to dashboard (replace with your own code)
      // Navigator.pushNamed(context, '/dashboard');
    } catch (e) {
      // Handle sign-in error
      print("Sign-in with Apple error: $e");
    }
  }
}
