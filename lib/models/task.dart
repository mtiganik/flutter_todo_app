
import 'dart:math';

class Task{
  final String id;
  final String taskName;
  final int? taskSort;
  final String? createdDt;
  final String? dueDt;
  final bool isCompleted;
  final bool? isArchived;
  final String todoCategoryId;
  final String todoPriorityId;
  final String? syncDt;


  Task({
    required this.id,
    required this.taskName,
    required this.isCompleted,
    required this.todoCategoryId,
    required this.todoPriorityId,
    String? createdDt,
    String? dueDt,
    String? syncDt,
    this.isArchived = false,
    this.taskSort = 0,
  }) : createdDt = createdDt ?? DateTime.now().toIso8601String(),
  syncDt = syncDt ?? DateTime.now().toIso8601String(),
  dueDt = dueDt ?? _generateRandomDueDate();

  static String _generateRandomDueDate(){
    final Random random = Random();
    final int randomDays = random.nextInt(21) +1;
    final DateTime randomDate = DateTime.now().add(Duration(days: randomDays));
    return randomDate.toIso8601String();
  }

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['id'],
      taskName: json['taskName'],
      taskSort: json['taskSort'],
      createdDt: json['createdDt'],
      dueDt: json['dueDt'],
      isCompleted: json['isCompleted'] == true || json['isCompleted'] == 1,
      isArchived: json['isArchived'] == true || json['isArchived'] == 1,
      todoCategoryId: json['todoCategoryId'],
      todoPriorityId: json['todoPriorityId'],
      syncDt: json['syncDt']
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id': id,
      'taskName': taskName,
      'taskSort': taskSort,
      'createdDt': createdDt,
      'dueDt': dueDt,
      'isCompleted': isCompleted,
      'isArchived': isArchived,
      'todoCategoryId':todoCategoryId,
      'todoPriorityId':todoPriorityId,
      'syncDt':syncDt,
    };
  }

  Task copyWith({
    String? id,
    String? taskName,
    int? taskSort,
    String? createdDt,
    String? dueDt,
    bool? isCompleted,
    bool? isArchived,
    String? todoCategoryId,
    String? todoPriorityId,
    String? syncDt,
  }){
    return Task(
      id: id?? this.id,
      taskName: taskName ?? this.taskName,
      taskSort: taskSort ?? this.taskSort,
      createdDt: createdDt ?? this.createdDt,
      dueDt: dueDt ?? this.dueDt,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
      todoCategoryId: todoCategoryId ?? this.todoCategoryId,
      todoPriorityId: todoPriorityId ?? this.todoPriorityId,
      syncDt: syncDt ?? this.syncDt
    );
  }


  @override
  String toString() {
    return 'Task: { task: $taskName, isCompleted: $isCompleted, dueDt: $dueDt}';
  }
}