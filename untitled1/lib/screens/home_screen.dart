// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'settings_screen.dart';
import 'converter_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  final VoidCallback onToggleTheme;
  const HomeScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Kalkulator Pintar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(theme.brightness == Brightness.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Welcome Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo.png',
                        width: 60, height: 60),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Selamat datang!\nPilih fitur di bawah:',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Mulai Kalkulasi
            _HomeButton(
              icon: Icons.calculate_outlined,
              label: 'Kalkulator',
              onTap: () => Navigator.pushNamed(
                  context, CalculatorScreen.routeName),
            ),
            const SizedBox(height: 16),
            // Settings
            _HomeButton(
              icon: Icons.settings,
              label: 'Pengaturan',
              onTap: () => Navigator.pushNamed(
                  context, SettingsScreen.routeName,
                  arguments: onToggleTheme),
            ),
            const SizedBox(height: 16),
            // Converter
            _HomeButton(
              icon: Icons.swap_horiz,
              label: 'Konverter',
              onTap: () => Navigator.pushNamed(
                  context, ConverterScreen.routeName),
            ),
            const Spacer(),
            Text('v1.0.0', style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// Button custom di HomeScreen
class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(label, style: const TextStyle(fontSize: 18)),
        ),
        style: ElevatedButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
      ),
    );
  }
}
