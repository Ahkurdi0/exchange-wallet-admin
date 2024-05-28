import 'package:exchange_app_admin/models/NotificationModel.dart';
import 'package:exchange_app_admin/services/db.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final db = Db();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: db.getAdminNotifications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<NotificationModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index].title ?? ''),
                        Text(snapshot.data![index].body ?? ''),
                      ],
                    ),
                    subtitle: Text(snapshot.data![index].timestamp.toString()),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
