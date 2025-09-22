import 'dart:convert';
import 'package:flutter/material.dart';

enum BillingCycle { daily, weekly, monthly, yearly }
enum LogoType { network, file }

class Subscription {
  final String id;
  final String name;
  final double amount;
  final DateTime lastPaidDate;
  final DateTime nextPaymentDate;
  final String currency;
  final BillingCycle billingCycle;
  final Color color;
  final String? note;
  final String? category;
  final bool receiveReminders;
  final String? logoIdentifier;
  final LogoType logoType;
  final int reminderDaysBefore; // New field to store reminder preference

  Subscription({
    required this.id,
    required this.name,
    required this.amount,
    required this.lastPaidDate,
    required this.nextPaymentDate,
    required this.currency,
    required this.billingCycle,
    required int colorValue,
    this.note,
    this.category,
    this.receiveReminders = true,
    this.logoIdentifier,
    this.logoType = LogoType.network,
    this.reminderDaysBefore = 3, // Default reminder is 3 days before
  }) : color = Color(colorValue);

  // Helper to get the color value for JSON serialization
  int get colorValue => color.value;

  // Converts a Subscription object into a Map for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'lastPaidDate': lastPaidDate.toIso8601String(),
      'currency': currency,
      'billingCycle': billingCycle.index,
      'colorValue': color.value,
      'note': note,
      'category': category,
      'receiveReminders': receiveReminders,
      'logoIdentifier': logoIdentifier,
      'logoType': logoType.index,
      'reminderDaysBefore': reminderDaysBefore, // Save to JSON
    };
  }

  // Creates a Subscription object from a Map (JSON).
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: json['amount'] as double,
      lastPaidDate: DateTime.parse(json['lastPaidDate'] as String),
      nextPaymentDate: DateTime.now(), // This will be recalculated anyway
      currency: json['currency'] as String,
      billingCycle: BillingCycle.values[json['billingCycle'] as int],
      colorValue: json['colorValue'] as int,
      note: json['note'] as String?,
      category: json['category'] as String?,
      receiveReminders: json['receiveReminders'] as bool? ?? true,
      logoIdentifier: json['logoIdentifier'] as String?,
      logoType: json['logoType'] != null ? LogoType.values[json['logoType'] as int] : LogoType.network,
      reminderDaysBefore: json['reminderDaysBefore'] as int? ?? 3, // Load from JSON with a default
    );
  }
}

