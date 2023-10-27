
import 'package:flutter_todo_app/models/priority.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/task.dart';
import 'package:flutter_todo_app/services/category_service.dart';
import 'package:flutter_todo_app/services/priority_service.dart';
import 'package:flutter_todo_app/services/task_service.dart';
import 'package:uuid/uuid.dart';


class InitialDbValues{

static const Uuid _uuid =  Uuid();

static final _category_1uuid =  _uuid.v4();
static final _category_2uuid =  _uuid.v4();
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
    Task(id: _uuid.v4(), taskName: "Make food", isCompleted: false, categoryId: _category_1uuid, priorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Go to shop", isCompleted: false, categoryId: _category_1uuid, priorityId: _priority_1uuid),
    Task(id: _uuid.v4(), taskName: "Pet the cat", isCompleted: true, categoryId: _category_1uuid, priorityId: _priority_3uuid),
    Task(id: _uuid.v4(), taskName: "Learn programming", isCompleted: false, categoryId: _category_2uuid, priorityId: _priority_1uuid),
    Task(id: _uuid.v4(), taskName: "Write an essay", isCompleted: false, categoryId: _category_2uuid, priorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Ask questions from teacher", isCompleted: true, categoryId: _category_2uuid, priorityId: _priority_2uuid),
    Task(id: _uuid.v4(), taskName: "Help other", isCompleted: false, categoryId: _category_2uuid, priorityId: _priority_3uuid),
    Task(id: _uuid.v4(), taskName: "Go to gym", isCompleted: false, categoryId: _category_4uuid, priorityId: _priority_2uuid),
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
}