import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/features/auth/application/auth_provider.dart';
import 'package:todo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:todo_app/features/settings/presentation/settings_screen.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';
import 'package:todo_app/features/todo/presentation/todo_create_screen.dart';
import 'package:todo_app/features/todo/presentation/todo_edit_screen.dart';
import 'package:todo_app/features/todo/presentation/todo_list_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/todos',
    redirect: (context, state) {
      if (authState.value == null && state.matchedLocation != '/signin') {
        return '/signin';
      }
      if (authState.value != null && state.matchedLocation == '/signin') {
        return '/todos';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/todos',
        builder: (context, state) => const TodoListScreen(),
      ),
      GoRoute(
        path: '/todos/create',
        builder: (context, state) => const TodoCreateScreen(),
      ),
      GoRoute(
        path: '/todos/edit',
        builder: (context, state) {
          final todo = state.extra as Todo;
          return TodoEditScreen(todo: todo);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
