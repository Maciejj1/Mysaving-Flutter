import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysavingapp/data/models/premium_user_model.dart';

class PremiumUserRepository {
  final String? uid;

  PremiumUserRepository({this.uid});

  final CollectionReference expenseCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> updateUserData(List<PremiumUser> userPremium) async {
    List<Map<String, dynamic>> premiumData = userPremium.map((premium) {
      return {
        'id': premium.id,
        'silver': premium.silverUser,
        'gold': premium.goldUser,
        'diamond': premium.diamondUser,
      };
    }).toList();

    // Tworzymy nowy dokument w kolekcji "expenses" z UID użytkownika jako ID dokumentu
    DocumentReference userExpenseDoc = expenseCollection.doc(uid);
    CollectionReference userDashboardCol = userExpenseDoc.collection('premium');

    await userDashboardCol.add({
      'premium': premiumData,
    });
  }
}
