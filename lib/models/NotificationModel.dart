import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class NotificationModel extends Equatable {
  final String? body;
  final DateTime? timestamp;
  final String? title;

  const NotificationModel({
    this.body,
    this.timestamp,
    this.title,
  });

  NotificationModel copyWith({
    String? body,
    DateTime? timestamp,
    String? title,
  }) {
    return NotificationModel(
      body: body ?? this.body,
      timestamp: timestamp ?? this.timestamp,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'timestamp': timestamp,
      'title': title,
    };
  }

  factory NotificationModel.fromSnap(DocumentSnapshot snapshot) {
    return NotificationModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      body: map['body'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [body, timestamp, title];

  @override
  bool get stringify => true;
}
