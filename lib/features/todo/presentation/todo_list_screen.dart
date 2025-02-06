import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/application/auth_provider.dart';
import 'package:todo_app/features/todo/application/todo_filter.dart';
import 'package:todo_app/features/todo/application/todo_provider.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_card.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_filter_menu.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODOリスト'),
        actions: [
          const TodoFilterMenu(),
          IconButton(
            onPressed: () {
              context.push('/settings');
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ref.watch(todosProvider).when(
            data: (allTodos) {
              final todos = ref.watch(filteredTodosProvider);
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoCard(
                    todo: todo,
                    onToggle: (value) {
                      if (value != null) {
                        ref
                            .read(todoControllerProvider.notifier)
                            .toggleTodo(todo);
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
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/todos/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
