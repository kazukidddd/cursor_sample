import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/date_formatter.dart';
import 'package:todo_app/features/todo/domain/models/todo.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onTap,
  });

  final Todo todo;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      todo.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: onToggle,
                  ),
                ],
              ),
              if (todo.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  todo.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    decoration:
                        todo.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
              if (todo.dueDate != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      DateFormatter.formatDueDate(todo.dueDate!),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: todo.dueDate!.isBefore(DateTime.now())
                            ? Colors.red
                            : null,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '作成: ${DateFormatter.formatDateTime(todo.createdAt)}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
