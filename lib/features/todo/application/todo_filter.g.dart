// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, unnecessary_import, unnecessary_this, unused_import, unused_shown_name

part of 'todo_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredTodosHash() => r'8a8398d2998df7f1875199ac40f62e00319645a3';

/// See also [filteredTodos].
@ProviderFor(filteredTodos)
final filteredTodosProvider = AutoDisposeProvider<List<Todo>>.internal(
  filteredTodos,
  name: r'filteredTodosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTodosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredTodosRef = AutoDisposeProviderRef<List<Todo>>;
String _$todoFilterNotifierHash() =>
    r'35063fd0eb43b1c6990ca8e9f62a8c7ee655dedc';

/// See also [TodoFilterNotifier].
@ProviderFor(TodoFilterNotifier)
final todoFilterNotifierProvider =
    AutoDisposeNotifierProvider<TodoFilterNotifier, TodoFilter>.internal(
  TodoFilterNotifier.new,
  name: r'todoFilterNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoFilterNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoFilterNotifier = AutoDisposeNotifier<TodoFilter>;
String _$todoSortNotifierHash() => r'9c610c17c6e8a9968b4421e19e15eb5c86f44d09';

/// See also [TodoSortNotifier].
@ProviderFor(TodoSortNotifier)
final todoSortNotifierProvider =
    AutoDisposeNotifierProvider<TodoSortNotifier, TodoSort>.internal(
  TodoSortNotifier.new,
  name: r'todoSortNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoSortNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoSortNotifier = AutoDisposeNotifier<TodoSort>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
