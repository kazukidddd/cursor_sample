import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/todo/application/todo_filter.dart';

class TodoFilterMenu extends ConsumerWidget {
  const TodoFilterMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterNotifierProvider);
    final currentSort = ref.watch(todoSortNotifierProvider);

    return PopupMenuButton<Map<String, Object>>(
      icon: const Icon(Icons.filter_list),
      itemBuilder: (context) => [
        const PopupMenuItem(
          enabled: false,
          child: Text('フィルター'),
        ),
        ...TodoFilter.values.map(
          (filter) => PopupMenuItem(
            value: {'type': 'filter', 'value': filter},
            child: Row(
              children: [
                if (currentFilter == filter)
                  const Icon(Icons.check, size: 16)
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Text(filter.label),
              ],
            ),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          enabled: false,
          child: Text('ソート'),
        ),
        ...TodoSort.values.map(
          (sort) => PopupMenuItem(
            value: {'type': 'sort', 'value': sort},
            child: Row(
              children: [
                if (currentSort == sort)
                  const Icon(Icons.check, size: 16)
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Text(sort.label),
              ],
            ),
          ),
        ),
      ],
      onSelected: (value) {
        if (value['type'] == 'filter') {
          ref
              .read(todoFilterNotifierProvider.notifier)
              .setFilter(value['value'] as TodoFilter);
        } else if (value['type'] == 'sort') {
          ref
              .read(todoSortNotifierProvider.notifier)
              .setSort(value['value'] as TodoSort);
        }
      },
    );
  }
}
