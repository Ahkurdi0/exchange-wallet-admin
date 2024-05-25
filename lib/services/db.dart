import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchange_app_admin/models/BranchModel.dart';
import 'package:exchange_app_admin/models/ExchangeRateModel.dart';
import 'package:exchange_app_admin/models/TransactionModel.dart';
import 'package:exchange_app_admin/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Db {
  final firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  var currentUser = FirebaseAuth.instance.currentUser;

  Future<void> addUser(UserModel userModel, BuildContext context) async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No user logged in');
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Error'),
            content: Text('No authenticated user found.'),
          );
        },
      );
      return;
    }

    try {
      await users.doc(currentUser?.uid).set(
          userModel.copyWith(uId: currentUser?.uid, isAdmin: true).toMap());
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sign Up Failed'),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  Future<List<BranchModel>> getBranches() async {
    final CollectionReference branches = firestore.collection('branches');
    final QuerySnapshot snapshot = await branches.get();
    return snapshot.docs.map((doc) => BranchModel.fromSnap(doc)).toList();
  }

  Future<void> addBranch(BranchModel branch) async {
    final CollectionReference branches = firestore.collection('branches');
    await branches.doc(branch.uId).set(branch.toMap());
  }

// add new exchange rate
  void addExchangeRate(ExchangeRate exchangeRate) async {
    await firestore
        .collection('exchangeRates')
        .doc(exchangeRate.uId)
        .set(exchangeRate.toMap());
  }

  Future<List<ExchangeRate>> getExchangeRates() async {
    final CollectionReference exchangeRates =
        firestore.collection('exchangeRates');
    final QuerySnapshot snapshot = await exchangeRates.get();
    return snapshot.docs.map((doc) => ExchangeRate.fromSnap(doc)).toList();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    final CollectionReference users = firestore.collection('users');
    await users
        .doc(currentUser?.uid)
        .collection('transactions')
        .doc(transaction.uId)
        .set({
      ...transaction.toMap(),
      'fromBranchId': transaction.fromBranch?.uId,
      'toBranchId': transaction.toBranch?.uId,
    });
  }

  Future<List<TransactionModel>> getUserTransactionsForMonth(
      DateTime month, String status,
      [BranchModel? category]) async {
    final CollectionReference users = firestore.collection('users');
    Query query = users
        .doc(currentUser!.uid)
        .collection('transactions')
        .where('status', isEqualTo: status)
        .orderBy('createdAt', descending: true);

    if (category != null && category.branchName != 'All') {
      // get the transactions by from branch
      query = query.where('fromBranchId', isEqualTo: category.uId);
    }

    final QuerySnapshot snapshot = await query.get();
    return snapshot.docs.map((doc) => TransactionModel.fromSnap(doc)).toList();
  }

  Future<UserModel?> getCurrentUserData() async {
    final DocumentReference userRef =
        firestore.collection('users').doc(currentUser?.uid);
    final DocumentSnapshot snapshot = await userRef.get();

    if (snapshot.exists) {
      return UserModel.fromSnap(snapshot);
    } else {
      print('User document does not exist');
      return null;
    }
  }
}
