import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtracker/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a Consumer to access and modify the theme state
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildThemeModeSection(context, themeProvider),
                const SizedBox(height: 24),
                _buildColorPickerSection(context, themeProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  // Section for choosing the theme mode
  Widget _buildThemeModeSection(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Theme Mode'),
          trailing: DropdownButton<ThemeMode>(
            value: themeProvider.themeMode,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System Default'),
              ),
              DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
              DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
            ],
            onChanged: (mode) {
              if (mode != null) {
                themeProvider.setThemeMode(mode);
              }
            },
          ),
        ),
      ],
    );
  }

  // Section for picking the primary color
  Widget _buildColorPickerSection(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Primary Color', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: materialColors.entries.map((entry) {
            final color = entry.value;
            final isSelected = themeProvider.primaryColor == color;
            return GestureDetector(
              onTap: () => themeProvider.setPrimaryColor(color),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                          color: Theme.of(context).indicatorColor,
                          width: 3,
                        )
                      : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
