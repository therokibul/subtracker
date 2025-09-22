import 'package:flutter/material.dart';

enum BillingCycle { daily, weekly, monthly, yearly }

enum LogoType { network, file }

class Subscription {
  final String id;
  final String name;
  final double amount;
  final DateTime lastPaidDate;
  final String currency;
  final BillingCycle billingCycle;
  final Color color;
  final String? note;
  final String? category;
  final bool receiveReminders;
  final String? logoIdentifier;
  final LogoType logoType;
  final int reminderDaysBefore;

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.lastPaidDate,
    required this.currency,
    required this.billingCycle,
    required int colorValue,
    this.note,
    this.category,
    this.receiveReminders = true,
    this.logoIdentifier,
    this.logoType = LogoType.network,
    this.reminderDaysBefore = 3,
  }) : color = Color(colorValue);

  // The nextPaymentDate is now a getter that calculates the date on the fly.
  DateTime get nextPaymentDate {
    DateTime nextDate = lastPaidDate;
    // Keep adding the billing cycle duration until the date is in the future.
    while (nextDate.isBefore(DateTime.now())) {
      switch (billingCycle) {
        case BillingCycle.daily:
          nextDate = nextDate.add(const Duration(days: 1));
          break;
        case BillingCycle.weekly:
          nextDate = nextDate.add(const Duration(days: 7));
          break;
        case BillingCycle.monthly:
          nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
          break;
        case BillingCycle.yearly:
          nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
          break;
      }
    }
    return nextDate;
  }

  // ignore: deprecated_member_use
  int get colorValue => color.value;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'lastPaidDate': lastPaidDate.toIso8601String(),
      'currency': currency,
      'billingCycle': billingCycle.index,
      // ignore: deprecated_member_use
      'colorValue': color.value,
      'note': note,
      'category': category,
      'receiveReminders': receiveReminders,
      'logoIdentifier': logoIdentifier,
      'logoType': logoType.index,
      'reminderDaysBefore': reminderDaysBefore,
    };
  }

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'] as double,
      lastPaidDate: DateTime.parse(json['lastPaidDate'] as String),
      currency: json['currency'] as String,
      billingCycle: BillingCycle.values[json['billingCycle'] as int],
      colorValue: json['colorValue'] as int,
      note: json['note'] as String?,
      category: json['category'] as String?,
      receiveReminders: json['receiveReminders'] as bool? ?? true,
      logoIdentifier: json['logoIdentifier'] as String?,
      logoType: json['logoType'] != null
          ? LogoType.values[json['logoType'] as int]
          : LogoType.network,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3,
    );
  }
}
