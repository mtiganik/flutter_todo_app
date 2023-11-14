

  import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/task.dart';

List<Task>? sortTasksByPriority(List<Task>? allTasks, List<Priority>? priorities, bool ascending) {
    if (allTasks == null || priorities == null) {
      return null;
    }

    // Sort priorities by prioritySort in descending order
    priorities.sort((a, b) => ascending ?
      a.prioritySort.compareTo(b.prioritySort)
     :b.prioritySort.compareTo(a.prioritySort));

    // Sort tasks based on prioritySort level
    allTasks.sort((a, b) {
      final int prioritySortA = priorities
          .firstWhere((priority) => priority.id == a.todoPriorityId)
          .prioritySort;
      final int prioritySortB = priorities
          .firstWhere((priority) => priority.id == b.todoPriorityId)
          .prioritySort;
          
      return ascending
        ? prioritySortA.compareTo(prioritySortB)
        : prioritySortB.compareTo(prioritySortA);


    });

    return allTasks;
  }
