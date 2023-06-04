import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysavingapp/config/models/profile_model.dart';

import '../models/dashboard_model.dart';

class ProfileRepository {
  final String? uid;

  ProfileRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<UserProfile> userProfiles) async {
    List<Map<String, dynamic>> profileData = userProfiles.map((profile) {
      return {
        'id': profile.id,
        'image': profile.pictureImage,
        'name': profile.name,
        'password': profile.password,
        'email': profile.email,
        'dateOfBirth': profile.dateOfBirth
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "expenses" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol = userExpenseDoc.collection('profile');

    await userDashboardCol.add({
      'profile': profileData,
    });
  }
}
