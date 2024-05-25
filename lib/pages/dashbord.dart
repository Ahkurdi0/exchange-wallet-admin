import 'package:exchange_app_admin/pages/branchScreen.dart';
import 'package:exchange_app_admin/pages/history_exchanges.dart';
import 'package:exchange_app_admin/pages/home_exchange.dart';
import 'package:exchange_app_admin/pages/login.dart';
import 'package:exchange_app_admin/pages/setting.dart';
import 'package:exchange_app_admin/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  var PageViewList = [
    HomePageExchange(),
    HistoryTranaction(),
    BranchScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: PageViewList[currentIndex],
    );
  }
}
