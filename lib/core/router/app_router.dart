import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/features/auth/application/auth_provider.dart';
import 'package:todo_app/features/auth/presentation/sign_in_page.dart';
import 'package:todo_app/features/settings/presentation/settings_page.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';
import 'package:todo_app/features/todo/presentation/todo_create_page.dart';
import 'package:todo_app/features/todo/presentation/todo_edit_page.dart';
import 'package:todo_app/features/todo/presentation/todo_list_page.dart';

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
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/todos',
        builder: (context, state) => const TodoListPage(),
      ),
      GoRoute(
        path: '/todos/create',
        builder: (context, state) => const TodoCreatePage(),
      ),
      GoRoute(
        path: '/todos/edit',
        builder: (context, state) {
          final todo = state.extra as Todo;
          return TodoEditPage(todo: todo);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
