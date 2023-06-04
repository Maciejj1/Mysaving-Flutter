import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysavingapp/config/models/settings_model.dart';

import '../models/dashboard_model.dart';

class SettingsRepository {
  final String? uid;

  SettingsRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<SettingsModel> settings) async {
    List<Map<String, dynamic>> settingsData = settings.map((setting) {
      List<Map<String, dynamic>> settingsGeneral =
          setting.general.map((general) {
        return {
          'language': general.language,
          'currency': general.currency,
          'country': general.country,
        };
      }).toList();

      List<Map<String, dynamic>> settingsNotifications =
          setting.notifications.map((notification) {
        return {'notifications': notification.notifications};
      }).toList();

      return {
        'id': setting.id,
        'general': settingsGeneral,
        'notifications': settingsNotifications,
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "expenses" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol =
        userExpenseDoc.collection('settings');

    await userDashboardCol.add({
      'dashboards': settingsData,
    });
  }
}
