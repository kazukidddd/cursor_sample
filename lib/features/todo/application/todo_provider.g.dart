// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, unnecessary_import, unnecessary_this, unused_import, unused_shown_name

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosHash() => r'5931f71b9338f2297ecd2b90e62ebdf79bfebe10';

/// See also [todos].
@ProviderFor(todos)
final todosProvider = AutoDisposeStreamProvider<List<Todo>>.internal(
  todos,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodosRef = AutoDisposeStreamProviderRef<List<Todo>>;
String _$todoControllerHash() => r'ae5522cf6d115dfb657f9c80ee40372bd5c866c0';

/// See also [TodoController].
@ProviderFor(TodoController)
final todoControllerProvider =
    AutoDisposeNotifierProvider<TodoController, AsyncValue<void>>.internal(
  TodoController.new,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
