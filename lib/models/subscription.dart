import 'package:flutter/material.dart';

enum BillingCycle {
  daily,
  weekly,
  monthly,
  yearly,
}

class Subscription {
  final String id;
  final String name;
  final double amount;
  final DateTime lastPaidDate;
  final DateTime nextPaymentDate;
  final String currency;
  final BillingCycle billingCycle;
  final String? logoUrl;
  final String? note;
  final int colorValue;
  final String? category;
  final bool receiveReminders;

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.lastPaidDate,
    required this.nextPaymentDate,
    required this.currency,
    required this.billingCycle,
    this.logoUrl,
    this.note,
    required this.colorValue,
    this.category,
    required this.receiveReminders,
  });

  Color get color => Color(colorValue);

  // Factory constructor to create a Subscription from a map (JSON)
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      lastPaidDate: DateTime.parse(json['lastPaidDate']),
      nextPaymentDate: DateTime.parse(json['nextPaymentDate']),
      currency: json['currency'],
      billingCycle: BillingCycle.values[json['billingCycle']],
      logoUrl: json['logoUrl'],
      note: json['note'],
      colorValue: json['colorValue'],
      category: json['category'],
      receiveReminders: json['receiveReminders'],
    );
  }

  // Method to convert a Subscription object to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'lastPaidDate': lastPaidDate.toIso8601String(),
      'nextPaymentDate': nextPaymentDate.toIso8601String(),
      'currency': currency,
      'billingCycle': billingCycle.index,
      'logoUrl': logoUrl,
      'note': note,
      'colorValue': colorValue,
      'category': category,
      'receiveReminders': receiveReminders,
    };
  }
}

