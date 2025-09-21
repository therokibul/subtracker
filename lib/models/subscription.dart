import 'package:flutter/material.dart';

enum BillingCycle {
  onetime,
  monthly,
  yearly,
  weekly,
  daily,
  quarterly,
  semiAnnually,
}

class Subscription {
  final String id;
  final String name;
  final double amount;
  final DateTime nextPaymentDate;
  final String currency;
  final BillingCycle billingCycle;
  final String? note;
  final String? logoUrl;
  final String description;
  final Color? cardColor;

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.nextPaymentDate,
    required this.currency,
    required this.billingCycle,
    this.note,
    this.logoUrl,
    required this.description,
    this.cardColor,
  });
}
