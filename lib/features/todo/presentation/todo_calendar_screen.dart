import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/features/todo/application/todo_provider.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_card.dart';

class TodoCalendarScreen extends ConsumerStatefulWidget {
  const TodoCalendarScreen({super.key});

  @override
  ConsumerState<TodoCalendarScreen> createState() => _TodoCalendarScreenState();
}

class _TodoCalendarScreenState extends ConsumerState<TodoCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODOカレンダー'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              markersMaxCount: 3,
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/todos/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Todo> _getEventsForDay(DateTime day) {
    final todos = ref.watch(todosProvider).valueOrNull ?? [];
    return todos.where((todo) {
      return todo.dueDate != null && isSameDay(todo.dueDate!, day);
    }).toList();
  }

  Widget _buildTodoList() {
    return ref.watch(todosProvider).when(
          data: (allTodos) {
            final todosForSelectedDay = _getEventsForDay(_selectedDay!);

            if (todosForSelectedDay.isEmpty) {
              return Center(
                child: Text(
                  '${DateFormat.yMMMd().format(_selectedDay!)}のTODOはありません',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: todosForSelectedDay.length,
              itemBuilder: (context, index) {
                final todo = todosForSelectedDay[index];
                return TodoCard(
                  todo: todo,
                  onToggle: (value) {
                    if (value != null) {
                      try {
                        ref
                            .read(todoControllerProvider.notifier)
                            .toggleTodo(todo);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('エラーが発生しました: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  onTap: () {
                    context.push('/todos/edit', extra: todo);
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('エラーが発生しました: $error'),
          ),
        );
  }
}
