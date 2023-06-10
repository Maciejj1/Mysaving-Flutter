import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardSummaryScreen extends StatelessWidget {
  final String userID;

  DashboardSummaryScreen(this.userID);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('userData')
          .doc(userID)
          .collection('dashboard')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return CircularProgressIndicator();
        }
        final dashboardList = snapshot.data!.docs[0].data()['dashboards'];

        if (dashboardList == null ||
            dashboardList.isEmpty ||
            dashboardList is! List) {
          return Text('No dashboard data available');
        }

        final dashboardSummary = dashboardList[0]['dashboardSummary'];

        if (dashboardSummary == null ||
            dashboardSummary.isEmpty ||
            dashboardSummary is! List) {
          return Text('No dashboard summary available');
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Dashboard Summary'),
          ),
          body: SafeArea(
            child: Container(
              height: 500,
              width: 380,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: dashboardSummary.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(dashboardSummary[index].toString()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
