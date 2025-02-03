import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/core/theme/app_theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('テーマ'),
            trailing: DropdownButton<ThemeMode>(
              value: currentThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('システム設定に従う'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('ライトモード'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('ダークモード'),
                ),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appThemeModeProvider.notifier).setThemeMode(mode);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
