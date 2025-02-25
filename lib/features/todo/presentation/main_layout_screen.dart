import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/todo/presentation/todo_calendar_screen.dart';
import 'package:todo_app/features/todo/presentation/todo_list_screen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class MainLayoutScreen extends ConsumerWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    // 表示する画面のリスト
    final screens = [
      const TodoListScreen(),
      const TodoCalendarScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'リスト',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'カレンダー',
          ),
        ],
      ),
    );
  }
}
