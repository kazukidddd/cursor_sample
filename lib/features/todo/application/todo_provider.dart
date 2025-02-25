import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';

part 'todo_provider.g.dart';

@riverpod
Stream<List<Todo>> todos(TodosRef ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('todos')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      if (id.isEmpty) {
        throw Exception('TODOのIDが無効です');
      }

      return Todo.fromJson({
        'id': id,
        'userId': data['userId'] as String,
        'title': data['title'] as String,
        'description': data['description'] as String,
        'createdAt':
            (data['createdAt'] as Timestamp?)?.toDate().toIso8601String() ??
                DateTime.now().toIso8601String(),
        'updatedAt':
            (data['updatedAt'] as Timestamp?)?.toDate().toIso8601String() ??
                DateTime.now().toIso8601String(),
        'dueDate': data['dueDate'] != null
            ? (data['dueDate'] as Timestamp?)?.toDate().toIso8601String()
            : null,
        'isCompleted': data['isCompleted'] as bool? ?? false,
      });
    }).toList();
  });
}

@riverpod
class TodoController extends _$TodoController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> addTodo(
    String title,
    String description,
    DateTime? dueDate,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('ユーザーが見つかりません');

      final todo = Todo(
        id: '',
        userId: userId,
        title: title,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        dueDate: dueDate,
        isCompleted: false,
      );

      await FirebaseFirestore.instance.collection('todos').add({
        'userId': todo.userId,
        'title': todo.title,
        'description': todo.description,
        'createdAt': Timestamp.fromDate(todo.createdAt),
        'updatedAt': Timestamp.fromDate(todo.updatedAt),
        'dueDate':
            todo.dueDate != null ? Timestamp.fromDate(todo.dueDate!) : null,
        'isCompleted': todo.isCompleted,
      });
    });
  }

  Future<void> toggleTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      if (todo.id.isEmpty) {
        throw Exception('TODOのIDが無効です');
      }
      await FirebaseFirestore.instance.collection('todos').doc(todo.id).update({
        'isCompleted': !todo.isCompleted,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> updateTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await FirebaseFirestore.instance.collection('todos').doc(todo.id).update({
        'userId': todo.userId,
        'title': todo.title,
        'description': todo.description,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
        'dueDate':
            todo.dueDate != null ? Timestamp.fromDate(todo.dueDate!) : null,
        'isCompleted': todo.isCompleted,
      });
    });
  }

  Future<void> deleteTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
    });
  }
}
