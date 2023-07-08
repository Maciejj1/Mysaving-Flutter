import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysavingapp/data/models/settings_model.dart';

class SettingsRepository {
  final String? uid;

  SettingsRepository({this.uid});
  String mainCollection = dotenv.env['MAIN_COLLECTION']!;
  String sCollection = dotenv.env['S_COLLECTION']!;
  String sSubCollection = dotenv.env['S_SUBCOLLECTION']!;
  String sNt = dotenv.env['S_NT']!;
  String sGe = dotenv.env['S_GE']!;
  Future<void> updateUserData(List<SettingsModel> settings) async {
    final CollectionReference expenseCollection =
        FirebaseFirestore.instance.collection(mainCollection);
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
        return {sNt: notification.notifications};
      }).toList();

      return {
        'id': setting.id,
        sGe: settingsGeneral,
        sNt: settingsNotifications,
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "expenses" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol =
        userExpenseDoc.collection(sCollection);

    await userDashboardCol.add({
      sSubCollection: settingsData,
    });
  }
}
