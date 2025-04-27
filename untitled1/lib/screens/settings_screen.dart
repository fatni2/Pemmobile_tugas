// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  final VoidCallback onToggleTheme;

  const SettingsScreen({super.key, required this.onToggleTheme});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isScientific = false;
  String _language = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode Gelap/Terang'),
            secondary: const Icon(Icons.brightness_6),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) => widget.onToggleTheme(),
          ),
          SwitchListTile(
            title: const Text('Mode Ilmiah'),
            secondary: const Icon(Icons.science),
            value: _isScientific,
            onChanged: (v) => setState(() => _isScientific = v),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Bahasa'),
            trailing: DropdownButton<String>(
              value: _language,
              items: ['Indonesia', 'English']
                  .map((lang) =>
                  DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
              onChanged: (v) => setState(() => _language = v!),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Kalkulator Pintar',
                applicationVersion: '1.0.0',
                children: const [Text('Dibuat oleh Kamu.')],
              );
            },
          ),
        ],
      ),
    );
  }
}
