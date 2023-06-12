import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile_model.dart';

abstract class IProfileRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<UserProfile>> getProfile();
  Future<void> updateEmail(String newEmail);
  Future<void> updatePassword(String newPassword);
  Future<void> updateName(String newName);
  Future<void> updateProfilePicture(String imagePath);
}
