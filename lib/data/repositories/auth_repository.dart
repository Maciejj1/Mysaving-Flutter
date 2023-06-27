import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysavingapp/data/models/dashboard_model.dart';
import 'package:mysavingapp/data/models/premium_user_model.dart';
import 'package:mysavingapp/data/models/profile_model.dart';
import 'package:mysavingapp/data/models/settings_model.dart';
import 'package:mysavingapp/data/repositories/dashboard_repository.dart';
import 'package:mysavingapp/data/repositories/expenses_repository.dart';
import 'package:mysavingapp/data/repositories/premium_user_repository.dart';
import 'package:mysavingapp/data/repositories/profile_repository.dart';
import 'package:mysavingapp/data/repositories/settings_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/expenses_model.dart';
import '../models/user_model.dart';
import '../../config/services/user_manager.dart';

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
          url: 'assets/images/categories/home.png',
          expenses: [
            Expense(
                name: 'Rent',
                cost: 1000,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 1))),
            Expense(
                name: 'Utilities',
                cost: 200,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 15))),
          ],
          costs: 0,
        ),
        Category(
          id: 2,
          name: 'Food',
          url: 'assets/images/categories/coffe.png',
          expenses: [
            Expense(
                name: 'Rent',
                cost: 100,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 21))),
            Expense(
                name: 'Utilities',
                cost: 200,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 20))),
          ],
          costs: 0,
        ),
        Category(
          id: 3,
          name: 'Addictions',
          url: 'assets/images/categories/smoke.png',
          expenses: [
            Expense(
                name: 'Rent',
                cost: 300,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 10))),
            Expense(
                name: 'Utilities',
                cost: 100,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 25))),
          ],
          costs: 0,
        ),
        Category(
          id: 4,
          name: 'Events',
          url: 'assets/images/categories/headphones.png',
          expenses: [
            Expense(
                name: 'Rent',
                cost: 10,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 3))),
            Expense(
                name: 'Utilities',
                cost: 680,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 22))),
          ],
          costs: 0,
        ),
        Category(
          id: 5,
          name: 'Charges',
          url: 'assets/images/categories/device.png',
          expenses: [
            Expense(
                name: 'Rent',
                cost: 311,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 19))),
            Expense(
                name: 'Utilities',
                cost: 420,
                expensesTime: Timestamp.fromDate(DateTime(2023, 6, 23))),
          ],
          costs: 0,
        ),
      ];
      List<DashboardModel> dashboard = [
        DashboardModel(
            dashboardSummary: [
              DashboardSummary(
                  id: 1, saldo: 1000, saving: 1000, expenses: 1000),
            ],
            id: "1",
            dashboardAnalytics: [
              DashboardAnalytics(
                summary: calculateAnalyticsForWeek(categories),
              ),
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
        int totalCosts = category.expenses!.fold(
            0, (int previousValue, expense) => previousValue + expense.cost!);
        return totalCosts;
      }

      categories = categories.map((category) {
        category.costs = calculateTotalCosts(category.id!);
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

  List<DashboardAnalitycsDay> calculateAnalyticsForWeek(
      List<Category> categories) {
    List<DashboardAnalitycsDay> weekAnalytics = [];

    DateTime now = DateTime.now();
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));

    List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    for (int i = 0; i < 7; i++) {
      DateTime day = monday.add(Duration(days: i));

      int expenses = 0;
      int saldo = 0;
      int saving = 0;

      for (Category category in categories) {
        for (Expense expense in category.expenses!) {
          DateTime expenseDate = expense.expensesTime!.toDate();
          if (expenseDate.year == day.year &&
              expenseDate.month == day.month &&
              expenseDate.day == day.day) {
            expenses += expense.cost!;
          }
        }
      }

      weekAnalytics.add(
        DashboardAnalitycsDay(
          date: weekDays[i],
          expenses: expenses,
          id: i + 1,
          saldo: saldo,
          saving: saving,
        ),
      );
    }

    return weekAnalytics;
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
