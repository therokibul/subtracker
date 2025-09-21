import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtracker/screens/add_subscribtion_screen.dart';

import '../models/subscription.dart';
import '../providers/subscription_provider.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final subscriptions = subscriptionProvider.subscriptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: subscriptions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withOpacity(0.6),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No subscriptions yet.',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the "+" button to add your first one!',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: subscriptions.length,
              itemBuilder: (ctx, i) =>
                  _buildSubscriptionCard(context, subscriptions[i]),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddSubscriptionScreen(),
            ),
          );
        },
      ),
    );
  }

  // Helper function to build the display card for a single subscription.
  Widget _buildSubscriptionCard(BuildContext context, Subscription sub) {
    return Dismissible(
      key: ValueKey(sub.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<SubscriptionProvider>(
          context,
          listen: false,
        ).deleteSubscription(sub.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${sub.name} subscription deleted'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: sub.color,
            backgroundImage: sub.logoUrl != null && sub.logoUrl!.isNotEmpty
                ? NetworkImage(sub.logoUrl!)
                : null,
            child: sub.logoUrl == null || sub.logoUrl!.isEmpty
                ? Text(
                    sub.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          title: Text(
            sub.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (sub.category != null && sub.category!.isNotEmpty)
                Text(sub.category!),
              Text('Next: ${DateFormat.yMMMd().format(sub.nextPaymentDate)}'),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${sub.currency} ${sub.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                '/ ${_getBillingCycleText(sub.billingCycle)}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          onTap: () {
            // Navigate to the edit screen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddSubscriptionScreen(subscription: sub),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getBillingCycleText(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.daily:
        return 'Day';
      case BillingCycle.weekly:
        return 'Week';
      case BillingCycle.monthly:
        return 'Month';
      case BillingCycle.yearly:
        return 'Year';
      default:
        return '';
    }
  }
}
