
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import '../models/subscription.dart';
import '../providers/subscription_provider.dart';
import '../services/notification_service.dart';
import '../utils/currency_helper.dart';
import '../utils/logo_helper.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final Subscription? subscription;

  const AddSubscriptionScreen({super.key, this.subscription});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _categoryController = TextEditingController();

  DateTime? _lastPaidDate;
  BillingCycle _selectedBillingCycle = BillingCycle.monthly;
  String _selectedCurrency = 'USD';
  Color _selectedColor = Colors.deepPurple;
  bool _receiveReminders = true;

  // State variables for the logo
  String? _logoIdentifier;
  LogoType _logoType = LogoType.network;

  final List<String> _categories = [
    'Streaming', 'Gaming', 'Software', 'Utilities', 'Music', 'Password Managers', 'Other'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.subscription != null) {
      final sub = widget.subscription!;
      _nameController.text = sub.name;
      _amountController.text = sub.amount.toString();
      _noteController.text = sub.note ?? '';
      _categoryController.text = sub.category ?? '';
      _lastPaidDate = sub.lastPaidDate;
      _selectedBillingCycle = sub.billingCycle;
      _selectedCurrency = sub.currency;
      _selectedColor = sub.color;
      _receiveReminders = sub.receiveReminders;
      _logoIdentifier = sub.logoIdentifier;
      _logoType = sub.logoType;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _lastPaidDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _lastPaidDate = pickedDate;
      });
    });
  }

  DateTime _calculateNextPaymentDate(DateTime lastPaid, BillingCycle cycle) {
    DateTime nextDate = lastPaid;
    while (nextDate.isBefore(DateTime.now())) {
      switch (cycle) {
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

  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _lastPaidDate == null) {
      if (_lastPaidDate == null && isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please select the last payment date.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return;
    }
    _formKey.currentState?.save();

    final nextPaymentDate = _calculateNextPaymentDate(_lastPaidDate!, _selectedBillingCycle);

    final newSubscription = Subscription(
      id: widget.subscription?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      amount: double.parse(_amountController.text),
      lastPaidDate: _lastPaidDate!,
      nextPaymentDate: nextPaymentDate,
      currency: _selectedCurrency,
      billingCycle: _selectedBillingCycle,
      note: _noteController.text,
      colorValue: _selectedColor.value,
      category: _categoryController.text,
      receiveReminders: _receiveReminders,
      logoIdentifier: _logoIdentifier,
      logoType: _logoType,
    );

    final provider = Provider.of<SubscriptionProvider>(context, listen: false);
    final notificationService = NotificationService();
    final notificationId = newSubscription.id.hashCode;

    if (widget.subscription != null) {
      notificationService.cancelNotification(notificationId);
      provider.updateSubscription(newSubscription);
    } else {
      provider.addSubscription(newSubscription);
    }

    if (_receiveReminders) {
      notificationService.scheduleNotification(
        id: notificationId,
        title: 'Upcoming Payment: ${newSubscription.name}',
        body: 'Your payment of ${getCurrencySymbol(newSubscription.currency)} ${newSubscription.amount.toStringAsFixed(2)} is due in 3 days.',
        scheduledDate: nextPaymentDate.subtract(const Duration(days: 3)),
      );
    }
    Navigator.of(context).pop();
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Close the bottom sheet first
      if(mounted) Navigator.of(context).pop();

      final appDir = await getApplicationDocumentsDirectory();
      final fileName = p.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        _logoIdentifier = savedImage.path;
        _logoType = LogoType.file;
      });
    }
  }

  void _showLogoPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select a Logo', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: predefinedLogos.length,
                  itemBuilder: (context, index) {
                    final logoName = predefinedLogos.keys.elementAt(index);
                    final logoUrl = predefinedLogos.values.elementAt(index);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(logoUrl),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Text(logoName),
                      onTap: () {
                        setState(() {
                          _logoIdentifier = logoUrl;
                          _logoType = LogoType.network;
                          _nameController.text = logoName; // Auto-fill the title
                        });
                        Navigator.of(ctx).pop();
                      },
                    );
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('Upload from Gallery'),
                onTap: _pickImageFromGallery,
              )
            ],
          ),
        );
      },
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() => _selectedColor = color);
            },
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subscription == null ? 'Add Subscription' : 'Edit Subscription'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTextFormField(controller: _nameController, label: 'Title'),
              const SizedBox(height: 16),
              _buildColorField(),
              const SizedBox(height: 16),
              _buildTextFormField(controller: _noteController, label: 'Notes (Optional)'),
              const SizedBox(height: 16),
              _buildDateField(),
              const SizedBox(height: 16),
              _buildBillingCycleField(),
              const SizedBox(height: 16),
              _buildCategoryField(),
              _buildReminderField(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    Widget logoWidget;
    ImageProvider? backgroundImage;
    if (_logoIdentifier != null) {
      switch (_logoType) {
        case LogoType.network:
           backgroundImage = NetworkImage(_logoIdentifier!);
          break;
        case LogoType.file:
          backgroundImage = FileImage(File(_logoIdentifier!));
          break;
      }
       logoWidget = Container(); // Empty container as background image will be used
    } else {
      logoWidget = const Icon(Icons.subscriptions, size: 40, color: Colors.white);
    }

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _showLogoPicker,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: _selectedColor,
              backgroundImage: backgroundImage,
              child: logoWidget,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _amountController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: '0.00',
              border: InputBorder.none,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) => (value == null || double.tryParse(value) == null) ? 'Enter a valid amount' : null,
          ),
          DropdownButton<String>(
            value: _selectedCurrency,
            underline: Container(),
            items: currencyNames.entries.map((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text('${entry.key} (${getCurrencySymbol(entry.key)})', overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCurrency = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({required TextEditingController controller, required String label}) {
     return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: label == 'Title' ? (value) => (value == null || value.isEmpty) ? 'Please enter a title' : null : null,
    );
  }
  
  Widget _buildColorField() {
    return _buildContainerForField(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: const Text('Color'),
        trailing: CircleAvatar(backgroundColor: _selectedColor, radius: 15),
        onTap: _showColorPicker,
      ),
    );
  }
  
  Widget _buildDateField() {
     return _buildContainerForField(
       child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        title: const Text('Last Paid Date'),
        trailing: Text(_lastPaidDate == null ? 'Not Set' : DateFormat.yMMMd().format(_lastPaidDate!)),
        onTap: _presentDatePicker,
           ),
     );
  }

  Widget _buildBillingCycleField() {
    return _buildContainerForField(
      child: DropdownButtonFormField<BillingCycle>(
        value: _selectedBillingCycle,
        decoration: InputDecoration(
          labelText: 'Billing Cycle',
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: BillingCycle.values.map((cycle) {
          return DropdownMenuItem(
            value: cycle,
            child: Text(cycle.name[0].toUpperCase() + cycle.name.substring(1)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) setState(() => _selectedBillingCycle = value);
        },
      ),
    );
  }

  Widget _buildCategoryField() {
    return _buildContainerForField(
      child: DropdownButtonFormField<String>(
        value: _categoryController.text.isEmpty ? null : _categoryController.text,
        hint: const Text('Category'),
         decoration: InputDecoration(
          labelText: 'Category',
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
        onChanged: (value) {
          if (value != null) setState(() => _categoryController.text = value);
        },
      ),
    );
  }

  Widget _buildReminderField() {
    return _buildContainerForField(
      child: SwitchListTile(
        title: const Text('Receive Reminders'),
        value: _receiveReminders,
        onChanged: (value) {
          setState(() => _receiveReminders = value);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildContainerForField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

