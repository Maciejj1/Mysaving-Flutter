import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mysavingapp/config/models/profile_model.dart';
import 'package:mysavingapp/config/repository/interfaces/IProfileRepository.dart';

import '../models/dashboard_model.dart';
import '../singleton/user_manager.dart';

class ProfileRepository extends IProfileRepository {
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

  @override
  Future<List<UserProfile>> getProfile() async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    final result =
        await profileCollection.doc(userID).collection('profile').get();

    List<UserProfile> profiles = [];

    for (var profileDoc in result.docs) {
      final profileData = profileDoc.data();
      final profilesData = profileData['profile'];

      for (var profile in profilesData) {
        UserProfile userProfile = UserProfile(
          id: profile['id'],
          pictureImage: profile['image'],
          name: profile['name'],
          password: profile['password'],
          email: profile['email'],
          dateOfBirth: profile['dateOfBirth'],
        );

        profiles.add(userProfile);
      }
    }

    return profiles;
  }

  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('userData');
  @override
  Future<void> updateEmail(String newEmail) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      int profileId = profiles[0].id;

      await profileCollection
          .doc(userID)
          .collection('profile')
          .doc('$profileId')
          .update({'email': newEmail});
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      int profileId = profiles[0].id;

      await profileCollection
          .doc(userID)
          .collection('profile')
          .doc('$profileId')
          .update({'password': newPassword});
    }
  }

  @override
  Future<void> updateName(String newName) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      int profileId = profiles[0].id;

      await profileCollection
          .doc(userID)
          .collection('profile')
          .doc('$profileId')
          .update({'name': newName});
    }
  }

  @override
  Future<void> updateProfilePicture(String imagePath) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      Reference storageRef = FirebaseStorage.instance.ref().child(userID!);
      UploadTask uploadTask = storageRef.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      int profileId = profiles[0].id;

      final result = await profileCollection.doc(userID).collection('profile');
      for (var profileDoc in result.docs) {}
    }
  }
}
