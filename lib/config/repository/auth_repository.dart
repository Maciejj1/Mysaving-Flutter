import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysavingapp/config/models/dashboard_model.dart';
import 'package:mysavingapp/config/models/premium_user_model.dart';
import 'package:mysavingapp/config/models/profile_model.dart';
import 'package:mysavingapp/config/models/settings_model.dart';
import 'package:mysavingapp/config/repository/dashboard_repository.dart';
import 'package:mysavingapp/config/repository/expenses_repository.dart';
import 'package:mysavingapp/config/repository/premium_user_repository.dart';
import 'package:mysavingapp/config/repository/profile_repository.dart';
import 'package:mysavingapp/config/repository/settings_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/expenses_model.dart';
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

      List<DashboardModel> dashboard = [
        DashboardModel(
            dashboardLastExpenses: [
              DashboardLastExpenses(categories: categories)
            ],
            dashboardSummary: [
              DashboardSummary(
                  id: 1, saldo: 1000, saving: 1000, expenses: 1000),
            ],
            id: "1",
            dashboardAnalytics: [
              DashboardAnalytics(summary: [
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 200,
                  id: 1,
                  saldo: 1500,
                  saving: 1300,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 200,
                  id: 2,
                  saldo: 1300,
                  saving: 1100,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 0,
                  id: 3,
                  saldo: 3000,
                  saving: 2900,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 500,
                  id: 4,
                  saldo: 3500,
                  saving: 2400,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 300,
                  id: 5,
                  saldo: 3200,
                  saving: 2100,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 1000,
                  id: 6,
                  saldo: 2200,
                  saving: 1100,
                ),
                DashboardAnalitycsDay(
                  date: DateTime.now(),
                  expenses: 100,
                  id: 7,
                  saldo: 2100,
                  saving: 1000,
                )
              ])
            ])
      ];
      List<UserProfile> profile = [
        UserProfile(
            pictureImage: '',
            name: 'Wacław',
            password: password,
            email: email,
            dateOfBirth: '20/11/2001',
            id: 1)
      ];
      List<PremiumUser> premium = [
        PremiumUser(silverUser: 0, goldUser: 0, diamondUser: 0, id: 1)
      ];
      List<SettingsModel> settings = [
        SettingsModel(general: [
          GeneralSettings(
              country: 'Poland', currency: 'PLN', language: 'Polish')
        ], notifications: [
          NotificationsSettings(notifications: 0)
        ], id: 1)
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

      await ExpensesRepository(uid: uid).updateUserData(categories);
      await DashboardRepository(uid: uid).updateUserData(dashboard);
      await ProfileRepository(uid: uid).updateUserData(profile);
      await PremiumUserRepository(uid: uid).updateUserData(premium);
      await SettingsRepository(uid: uid).updateUserData(settings);
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
