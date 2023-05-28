import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysavingapp/config/repository/database.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/category_model.dart';
import '../models/expense_model.dart';
import '../models/user_model.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      List<Category> categories = [
        Category(
          id: 1,
          name: 'Home',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 1000),
            Expense(name: 'Utilities', cost: 200),
          ],
          costs: 0,
        ),
        // Add the remaining categories and expenses here
      ];

      // Assuming the user has just registered and you have their UID
      String uid = 'user-uid';

      await DatabaseService(uid: uid).updateUserData(categories);

      print('Expenses data has been updated for the user with UID: $uid');
    } catch (_) {}
  }

  Future<void> singIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final firebase_auth.AuthCredential credential =
        firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final firebase_auth.UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final firebase_auth.User user = authResult.user!;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final firebase_auth.User currentUser = _firebaseAuth.currentUser!;
    assert(user.uid == currentUser.uid);
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<bool> get appleSingInAvailable => SignInWithApple.isAvailable();

  Future<firebase_auth.UserCredential> appleSingIn() async {
    final AuthorizationCredentialAppleID appleID =
        await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);
    final firebase_auth.OAuthProvider oAuthProvider =
        firebase_auth.OAuthProvider('apple.com');
    final firebase_auth.OAuthCredential credential = oAuthProvider.credential(
      idToken: appleID.identityToken,
      accessToken: appleID.authorizationCode,
    );

    return await firebase_auth.FirebaseAuth.instance
        .signInWithCredential(credential);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName);
  }
}
