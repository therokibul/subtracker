import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/subscription.dart';
import '../providers/subscription_provider.dart';
import 'add_subscribtion_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the SubscriptionProvider to get the list of subscriptions.
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);
    final subscriptions = subscriptionProvider.subscriptions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SubTracker'),
        centerTitle: true,
        actions: [
          // Icon button to navigate to the settings screen
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
      // The body of the screen shows the list of subscriptions or an empty state message.
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
          // Navigate to the screen for adding a new subscription.
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
    // Determine the text color based on the brightness of the card's background color.
    final textColor = sub.cardColor!.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      // The color is dynamically set based on the logo.
      color: sub.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Display the logo or a fallback CircleAvatar.
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white.withOpacity(0.9),
                  backgroundImage:
                      sub.logoUrl != null && sub.logoUrl!.isNotEmpty
                      ? NetworkImage(sub.logoUrl!)
                      : null,
                  child: sub.logoUrl == null || sub.logoUrl!.isEmpty
                      ? Text(
                          sub.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: sub.cardColor,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sub.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        // Format the currency and amount.
                        '${sub.currency} ${sub.amount.toStringAsFixed(2)} / ${_getBillingCycleText(sub.billingCycle)}',
                        style: TextStyle(color: textColor.withOpacity(0.85)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              // Format and display the next payment date.
              'Next Payment: ${DateFormat.yMMMd().format(sub.nextPaymentDate)}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: textColor.withOpacity(0.9),
              ),
            ),
            // Conditionally display the description and note if they exist.
            if (sub.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(sub.description, style: TextStyle(color: textColor)),
            ],
            if (sub.note != null && sub.note!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Note: ${sub.note}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper function to get a display-friendly string for the billing cycle.
  String _getBillingCycleText(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.daily:
        return 'Day';
      case BillingCycle.weekly:
        return 'Week';
      case BillingCycle.monthly:
        return 'Month';
      case BillingCycle.quarterly:
        return 'Quarter';
      case BillingCycle.semiAnnually:
        return '6 Months';
      case BillingCycle.yearly:
        return 'Year';
      case BillingCycle.onetime:
        return 'One-Time';
      default:
        return '';
    }
  }
}
