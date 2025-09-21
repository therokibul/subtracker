import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/subscription.dart';
import '../providers/subscription_provider.dart';
import '../services/notification_service.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _logoUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _selectedDate;
  BillingCycle _selectedBillingCycle = BillingCycle.monthly;
  String _selectedCurrency = 'USD';
  Color _extractedColor = Colors.deepPurple; // Default color
  Timer? _debounce;
  bool _isExtractingColor = false;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD'];

  // Clean up the controllers when the widget is disposed.
  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _logoUrlController.dispose();
    _descriptionController.dispose();
    _noteController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Extracts the dominant color from an image URL.
  // Uses a debounce to avoid making too many network requests while typing.
  void _onLogoUrlChanged(String url) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (url.isNotEmpty && (url.startsWith('http') || url.startsWith('https'))) {
        _extractColorFromUrl(url);
      }
    });
  }

  Future<void> _extractColorFromUrl(String url) async {
    setState(() {
      _isExtractingColor = true;
    });
    try {
      // Using ImagePixels to get color information from the image.
      // We wrap it in a widget that is never displayed to use its functionality.
      await ImagePixels.container(
        imageProvider: NetworkImage(url),
        // colorCallback: (color) {
        //   setState(() {
        //     _extractedColor = color;
        //     _isExtractingColor = false;
        //   });
        // },
      );
    } catch (e) {
      // If color extraction fails, fall back to the default color.
      setState(() {
        _extractedColor = Theme.of(context).primaryColor;
        _isExtractingColor = false;
      });
      print("Error extracting color: $e");
    }
  }


  // Shows the date picker dialog to select the next payment date.
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  // Validates the form and saves the new subscription.
  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _selectedDate == null) {
      if (_selectedDate == null && isValid) {
        // Show a snackbar if the date is missing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select a payment date.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }
    _formKey.currentState?.save();

    final newSubscription = Subscription(
      id: DateTime.now().toString(), // Using timestamp as a simple unique ID
      name: _nameController.text,
      amount: double.parse(_amountController.text),
      nextPaymentDate: _selectedDate!,
      currency: _selectedCurrency,
      billingCycle: _selectedBillingCycle,
      logoUrl: _logoUrlController.text,
      description: _descriptionController.text,
      note: _noteController.text,
      cardColor: _extractedColor, 
     
    );

    // Add the subscription to the provider
    Provider.of<SubscriptionProvider>(context, listen: false)
        .addSubscription(newSubscription);

    // Schedule a notification
    NotificationService().scheduleNotification(
      id: newSubscription.id.hashCode,
      title: 'Upcoming Payment Reminder',
      body:
          'Your payment for ${newSubscription.name} of ${newSubscription.currency} ${newSubscription.amount.toStringAsFixed(2)} is due in 3 days.',
      scheduledDate: _selectedDate!.subtract(const Duration(days: 3)),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subscription'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Subscription Name'),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: const InputDecoration(labelText: 'Currency'),
                items: _currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<BillingCycle>(
                value: _selectedBillingCycle,
                decoration: const InputDecoration(labelText: 'Billing Cycle'),
                items: BillingCycle.values.map((BillingCycle cycle) {
                  return DropdownMenuItem<BillingCycle>(
                    value: cycle,
                    child: Text(cycle.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBillingCycle = newValue!;
                  });
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Next Payment: ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
               TextFormField(
                controller: _logoUrlController,
                decoration: InputDecoration(
                  labelText: 'Logo URL (Optional)',
                  suffixIcon: _isExtractingColor
                      ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                      : Container(
                          margin: const EdgeInsets.all(12),
                          width: 20,
                          height: 20,
                          color: _extractedColor,
                        ),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                onChanged: _onLogoUrlChanged,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description (Optional)'),
                textInputAction: TextInputAction.next,
                maxLines: 2,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Note (Optional)'),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _saveForm(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save Subscription'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

