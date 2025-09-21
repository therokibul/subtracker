import 'package:flutter/material.dart';

enum BillingCycle { daily, weekly, monthly, yearly }
enum LogoType { network, file } // Two types: network for predefined, file for uploaded

class Subscription {
  final String id;
  final String name;
  final double amount;
  final String currency;
  final DateTime lastPaidDate;
  final DateTime nextPaymentDate;
  final BillingCycle billingCycle;
  final String? note;
  final Color color;
  final String? category;
  final bool receiveReminders;
  final String? logoIdentifier; // Can be a URL or a local file path
  final LogoType logoType;

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.currency,
    required this.lastPaidDate,
    required this.nextPaymentDate,
    required this.billingCycle,
    this.note,
    required int colorValue,
    this.category,
    required this.receiveReminders,
    this.logoIdentifier,
    this.logoType = LogoType.network,
  }) : color = Color(colorValue);

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      currency: json['currency'],
      lastPaidDate: DateTime.parse(json['lastPaidDate']),
      nextPaymentDate: DateTime.parse(json['nextPaymentDate']),
      billingCycle: BillingCycle.values[json['billingCycle']],
      note: json['note'],
      colorValue: json['colorValue'],
      category: json['category'],
      receiveReminders: json['receiveReminders'],
      logoIdentifier: json['logoIdentifier'],
      logoType: LogoType.values[json['logoType'] ?? LogoType.network.index],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'currency': currency,
      'lastPaidDate': lastPaidDate.toIso8601String(),
      'nextPaymentDate': nextPaymentDate.toIso8601String(),
      'billingCycle': billingCycle.index,
      'note': note,
      'colorValue': color.value,
      'category': category,
      'receiveReminders': receiveReminders,
      'logoIdentifier': logoIdentifier,
      'logoType': logoType.index,
    };
  }
}

