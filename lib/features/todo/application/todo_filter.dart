import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/features/todo/application/todo_provider.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';

part 'todo_filter.g.dart';

enum TodoFilter {
  all('すべて'),
  active('未完了'),
  completed('完了');

  const TodoFilter(this.label);
  final String label;
}

enum TodoSort {
  createdDesc('作成日時（新しい順）'),
  createdAsc('作成日時（古い順）'),
  dueDate('期限日順');

  const TodoSort(this.label);
  final String label;
}

@riverpod
class TodoFilterNotifier extends _$TodoFilterNotifier {
  @override
  TodoFilter build() => TodoFilter.all;

  void setFilter(TodoFilter filter) {
    state = filter;
  }
}

@riverpod
class TodoSortNotifier extends _$TodoSortNotifier {
  @override
  TodoSort build() => TodoSort.createdDesc;

  void setSort(TodoSort sort) {
    state = sort;
  }
}

@riverpod
List<Todo> filteredTodos(FilteredTodosRef ref) {
  final todos = ref.watch(todosProvider).value ?? [];
  final filter = ref.watch(todoFilterNotifierProvider);
  final sort = ref.watch(todoSortNotifierProvider);

  final filteredTodos = switch (filter) {
    TodoFilter.all => todos,
    TodoFilter.active => todos.where((todo) => !todo.isCompleted).toList(),
    TodoFilter.completed => todos.where((todo) => todo.isCompleted).toList(),
  };

  switch (sort) {
    case TodoSort.createdDesc:
      filteredTodos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    case TodoSort.createdAsc:
      filteredTodos.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    case TodoSort.dueDate:
      filteredTodos.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) return 0;
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
  }

  return filteredTodos;
}
