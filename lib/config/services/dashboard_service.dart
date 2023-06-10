import 'package:cloud_firestore/cloud_firestore.dart';

import '../singleton/user_manager.dart';

class DashboardService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserManager userManager = UserManager();

  getUserDashboardData() async {
    String? userID = await userManager.getUID();
    await _db.collection('userData').doc(userID).collection('dashboard').get();
  }
}
