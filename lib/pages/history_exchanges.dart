import 'package:exchange_app_admin/models/BranchModel.dart';
import 'package:exchange_app_admin/models/NotificationModel.dart';
import 'package:exchange_app_admin/pages/notification_page.dart';
import 'package:exchange_app_admin/services/db.dart';
import 'package:exchange_app_admin/widgets/category_list.dart';
import 'package:exchange_app_admin/widgets/tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTranaction extends StatefulWidget {
  const HistoryTranaction({Key? key}) : super(key: key);

  @override
  _HistoryTransactionState createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTranaction> {
  BranchModel category = const BranchModel(branchName: 'All');

  Db db = Db();
  String monthYear = '';

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    monthYear = DateFormat('MMM y').format(now); // Format current date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exchanges'),
        actions: <Widget>[
          StreamBuilder<List<NotificationModel>>(
            stream: db.getAdminNotifications(), // Replace with your function
            builder: (BuildContext context,
                AsyncSnapshot<List<NotificationModel>> snapshot) {
              return Badge(
                offset: Offset.zero,
                label: Text(
                  snapshot.hasData ? '${snapshot.data!.length}' : '',
                  style: const TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // TimeLineMonth(
          //   onChanged: (String? value) {
          //     if (value != null) {
          //       setState(() {
          //         monthYear = value; // Update monthYear based on user selection
          //       });
          //     }
          //   },
          // ),
          CategoryList(
            onChanged: (BranchModel? value) {
              if (value != null) {
                setState(() {
                  category = value; // Update category based on user selection
                });
              }
            },
          ),
          TypeTabBar(category: category, monthYear: monthYear)
        ],
      ),
    );
  }
}
