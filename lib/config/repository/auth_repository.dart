import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysavingapp/config/repository/database.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/category_model.dart';
import '../models/expense_model.dart';
import '../models/user_model.dart';
import '../singleton/user_manager.dart';

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
      final firebase_auth.UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      List<Category> categories = [
        Category(
          id: 1,
          name: 'Home',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 1000),
            Expense(name: 'Utilities', cost: 200),
          ],
          costs: 0, // Call the method to calculate costs
        ),
        Category(
          id: 2,
          name: 'Food',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 100),
            Expense(name: 'Utilities', cost: 200),
          ],
          costs: 0, // Call the method to calculate costs
        ),
        Category(
          id: 3,
          name: 'Addictions',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 300),
            Expense(name: 'Utilities', cost: 100),
          ],
          costs: 0, // Call the method to calculate costs
        ),
        Category(
          id: 4,
          name: 'Events',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 10),
            Expense(name: 'Utilities', cost: 680),
          ],
          costs: 0, // Call the method to calculate costs
        ),
        Category(
          id: 5,
          name: 'Charges',
          url: 'https://example.com/home',
          expenses: [
            Expense(name: 'Rent', cost: 311),
            Expense(name: 'Utilities', cost: 420),
          ],
          costs: 0, // Call the method to calculate costs
        ),

        // Add the remaining categories and expenses here
      ];

      int calculateTotalCosts(int categoryId) {
        Category category =
            categories.firstWhere((cat) => cat.id == categoryId);
        int totalCosts = category.expenses.fold(
            0, (int previousValue, expense) => previousValue + expense.cost);
        return totalCosts;
      }

      categories = categories.map((category) {
        category.costs = calculateTotalCosts(category.id);
        return category;
      }).toList();
      String uid = userCredential.user!.uid;
      UserManager().setUID(uid);

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
    final firebase_auth.User currentUser = _firebaseAuth.currentUser!;
    assert(user.uid == currentUser.uid);
    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<bool> get appleSingInAvailable => SignInWithApple.isAvailable();
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName);
  }
}
