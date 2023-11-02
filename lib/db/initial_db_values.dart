
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/api/api_methods/priority_api.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/services/priority_service.dart';
import 'package:flutter_todo_app/services/task_service.dart';
import 'package:uuid/uuid.dart';


class InitialDbValues{

static const Uuid _uuid =  Uuid();

static final _category_1uuid = _uuid.v4();
static final _category_2uuid = _uuid.v4();
static final _category_3uuid = _uuid.v4();
static final _category_4uuid = _uuid.v4();

  static final List<Category> _categories = [
    Category(id: _category_1uuid, categoryName: "Home", categorySort: 1),
    Category(id: _category_2uuid, categoryName: "Work", categorySort: 2),
    Category(id: _category_3uuid, categoryName: "School", categorySort: 3),
    Category(id: _category_4uuid, categoryName: "Other", categorySort: 4)
  ];

  static final _priority_1uuid = _uuid.v4();
  static final _priority_2uuid = _uuid.v4();
  static final _priority_3uuid = _uuid.v4();

  static final List<Priority> _priorities =[
    Priority(id: _priority_1uuid, priorityName: "High priority", prioritySort: 10),
    Priority(id: _priority_2uuid, priorityName: "Medium priority", prioritySort: 6),
    Priority(id: _priority_3uuid, priorityName: "Low priority", prioritySort: 3),
  ];

  static final List<Task> _tasks =[
    Task(id: _uuid.v4(), taskName: "Make food", isCompleted: false, todoCategoryId: _category_1uuid, todoPriorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Go to shop", isCompleted: false, todoCategoryId: _category_1uuid, todoPriorityId: _priority_1uuid),
    Task(id: _uuid.v4(), taskName: "Pet the cat", isCompleted: true, todoCategoryId: _category_1uuid, todoPriorityId: _priority_3uuid),
    Task(id: _uuid.v4(), taskName: "Learn programming", isCompleted: false, todoCategoryId: _category_2uuid, todoPriorityId: _priority_1uuid),
    Task(id: _uuid.v4(), taskName: "Write an essay", isCompleted: false, todoCategoryId: _category_2uuid, todoPriorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Ask questions from teacher", isCompleted: true, todoCategoryId: _category_2uuid, todoPriorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Help other", isCompleted: false, todoCategoryId: _category_2uuid, todoPriorityId: _priority_3uuid),
    Task(id: _uuid.v4(), taskName: "Go to gym", isCompleted: false, todoCategoryId: _category_4uuid, todoPriorityId: _priority_2uuid),
  ];

  static Future<int> addCategories()async{
    for(Category cat in _categories){
      await CategoryService.addCategory(cat);
    }
    return 1;
  }

  static Future<int> addPriorities() async{
    for(Priority pri in _priorities){
      await PriorityService.addPriority(pri);
    }
    return 1;
  }

  static Future<int> addTask() async{
    for(Task task in _tasks){
      await TaskService.addTask(task);
    }
    return 1;
  }


  static Future<int> addDataToSQL() async{
    await addCategories();
    await addPriorities();
    await addTask();
    return 1;
  }

  static Future<int> addCategoriesApi()async{
    for(Category cat in _categories){
      int responseCode = await CategoryApi.addCategory(cat);
      if(responseCode == 201){
        print("Added: $cat");
      }
    }
    return 1;
  }

  static Future<int> addPrioritiesApi() async{
    for(Priority priority in _priorities){
      int responseCode = await PriorityApi.addPriority(priority);
      if(responseCode == 201){
        print("Added: $priority");
      }
    }
    return 1;
  }

  static Future<int> addTaskApi() async{
    for(Task task in _tasks){
      int responseCode = await TaskApi.addTask(task);
      if(responseCode == 201){
        print("Added: $task");
      }

    }
    return 1;
  }

  static Future<int> addDataToAPI() async{
    await addCategoriesApi();
    await addPrioritiesApi();
    await addTaskApi();
    return 1;
  }
}