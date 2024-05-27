import 'package:exchange_app_admin/models/TransactionModel.dart';
import 'package:exchange_app_admin/services/db.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final TransactionModel transaction;

  const DetailsPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Db db = Db();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('transaction'),
            Text(
              "From Branch: ${widget.transaction.fromBranch?.branchName}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Category Two: ${widget.transaction.toBranch?.branchName}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Category Two: ${widget.transaction.user?.lastName}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Other transaction fields can go here"),
          ],
        ),
      ),
      bottomNavigationBar: widget.transaction.status == 'completed' ||
              widget.transaction.status == 'rejected'
          ? Container(
              height: 0,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    db
                        .updateTransactionStatus(
                          widget.transaction.copyWith(status: 'completed'),
                        )
                        .then((value) => Navigator.pop(context));
                  },
                ),
                ElevatedButton(
                  child: const Text('Reject'),
                  onPressed: () {
                    db
                        .updateTransactionStatus(
                            widget.transaction.copyWith(status: 'canceled'))
                        .then((value) => Navigator.pop(context));
                  },
                ),
              ],
            ),
    );
  }
}
