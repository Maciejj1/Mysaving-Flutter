import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mysavingapp/data/models/profile_model.dart';
import 'package:mysavingapp/data/repositories/interfaces/IProfileRepository.dart';
import '../../config/services/user_manager.dart';

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
      final collectionRef = profileCollection.doc(userID).collection('profile');
      final querySnapshot = await collectionRef.get();

      for (var profileDoc in querySnapshot.docs) {
        final documentRef = profileDoc.reference;
        final profilesData = profileDoc.data()['profile'];

        final updatedProfilesData = profilesData.map((profile) {
          if (profile['id'] == 1) {
            // Replace '1' with the appropriate condition to identify the element to update
            return {
              ...profile,
              'email':
                  newEmail, // Replace 'downloadURL' with the updated image URL
            };
          } else {
            return profile;
          }
        }).toList();

        await documentRef.update({
          'profile': updatedProfilesData,
        });
      }
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      final collectionRef = profileCollection.doc(userID).collection('profile');
      final querySnapshot = await collectionRef.get();

      for (var profileDoc in querySnapshot.docs) {
        final documentRef = profileDoc.reference;
        final profilesData = profileDoc.data()['profile'];

        final updatedProfilesData = profilesData.map((profile) {
          if (profile['id'] == 1) {
            // Replace '1' with the appropriate condition to identify the element to update
            return {
              ...profile,
              'password':
                  newPassword, // Replace 'downloadURL' with the updated image URL
            };
          } else {
            return profile;
          }
        }).toList();

        await documentRef.update({
          'profile': updatedProfilesData,
        });
      }
    }
  }

  @override
  Future<void> updateName(String newName) async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();

    List<UserProfile> profiles = await getProfile();

    if (profiles.isNotEmpty) {
      final collectionRef = profileCollection.doc(userID).collection('profile');
      final querySnapshot = await collectionRef.get();

      for (var profileDoc in querySnapshot.docs) {
        final documentRef = profileDoc.reference;
        final profilesData = profileDoc.data()['profile'];

        final updatedProfilesData = profilesData.map((profile) {
          if (profile['id'] == 1) {
            // Replace '1' with the appropriate condition to identify the element to update
            return {
              ...profile,
              'name':
                  newName, // Replace 'downloadURL' with the updated image URL
            };
          } else {
            return profile;
          }
        }).toList();

        await documentRef.update({
          'profile': updatedProfilesData,
        });
      }
    }
  }

  Future<void> updateProfilePicture(String imagePath) async {
    UserManager userManager = UserManager();
    String? userID;
    userID = await userManager.getUID();

    if (userID != null) {
      // Sprawdź, czy użytkownik jest zalogowany

      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('users')
          .child(userID)
          .child('avatars')
          .child(fileName);

      UploadTask uploadTask = reference.putFile(File(imagePath));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      // Pobierz URL pobrania po zakończeniu przesyłania pliku
      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      List<UserProfile> profiles = await getProfile();

      if (profiles.isNotEmpty) {
        final collectionRef =
            profileCollection.doc(userID).collection('profile');
        final querySnapshot = await collectionRef.get();

        for (var profileDoc in querySnapshot.docs) {
          final documentRef = profileDoc.reference;
          final profilesData = profileDoc.data()['profile'];

          final updatedProfilesData = profilesData.map((profile) {
            if (profile['id'] == 1) {
              // Replace '1' with the appropriate condition to identify the element to update
              return {
                ...profile,
                'image':
                    downloadURL, // Replace 'downloadURL' with the updated image URL
              };
            } else {
              return profile;
            }
          }).toList();

          await documentRef.update({
            'profile': updatedProfilesData,
          });
        }
      }
    }
  }
}
