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
  final String name;
  final double amount;
  final DateTime NextPaymentDate;
  final String currency;
  final BillingCycle billingCycle;
  final String? notes;
  final String? logoUrl;
  final String description;
  final Color? cardColor;

  Subscription({
    required this.name,
    required this.amount,
    required this.NextPaymentDate,
    required this.currency,
    required this.billingCycle,
    this.notes,
    this.logoUrl,
    required this.description,
    this.cardColor,
  });
}
