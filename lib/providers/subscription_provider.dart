import 'package:flutter/material.dart';
import 'package:subtracker/models/subscription.dart';

class SubscriptionProvider with ChangeNotifier {
  final List<Subscription> _subscriptions = [];
  List<Subscription> get subscriptions => _subscriptions;
  void addSubscription(Subscription subscription) {
    _subscriptions.add(subscription);
    notifyListeners();
  }
}