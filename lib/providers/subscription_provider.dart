import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subscription.dart';
import '../services/notification_service.dart';

class SubscriptionProvider with ChangeNotifier {
  List<Subscription> _subscriptions = [];

  List<Subscription> get subscriptions => _subscriptions;

  SubscriptionProvider() {
    _loadData();
  }

  // --- Data Persistence ---
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data = _subscriptions
        .map((sub) => sub.toJson())
        .toList();
    final String encodedData = json.encode(data);
    await prefs.setString('subscriptions', encodedData);
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('subscriptions')) {
      return;
    }
    final String? encodedData = prefs.getString('subscriptions');
    if (encodedData == null) return;
    final List<dynamic> decodedData = json.decode(encodedData);
    _subscriptions = decodedData
        .map((item) => Subscription.fromJson(item as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  // --- Subscription Management ---
  void addSubscription(Subscription subscription) {
    _subscriptions.add(subscription);
    notifyListeners();
    _saveData();
  }

  void updateSubscription(Subscription updatedSubscription) {
    final subIndex = _subscriptions.indexWhere(
      (sub) => sub.id == updatedSubscription.id,
    );
    if (subIndex >= 0) {
      _subscriptions[subIndex] = updatedSubscription;
      notifyListeners();
      _saveData();
    }
  }

  void deleteSubscription(String id) {
    _subscriptions.removeWhere((sub) => sub.id == id);
    NotificationService().cancelNotification(id.hashCode);
    notifyListeners();
    _saveData();
  }
}
