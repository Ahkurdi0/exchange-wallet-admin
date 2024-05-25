import 'package:exchange_app_admin/models/BranchModel.dart';
import 'package:exchange_app_admin/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TypeTabBar extends StatelessWidget {
  const TypeTabBar(
      {super.key, required this.category, required this.monthYear});
  final BranchModel category;
  final String monthYear;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(tabs: [
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Completed',
            ),
          ]),
          Expanded(
            child: TabBarView(children: [
              TransactionList(
                  category: category, type: "pending", monthYear: monthYear),
              TransactionList(
                  category: category, type: "completed", monthYear: monthYear),
            ]),
          )
        ],
      ),
    ));
  }
}
