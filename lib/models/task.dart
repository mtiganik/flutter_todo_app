
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
  dueDt = dueDt ?? DateTime.now().add(Duration(days: 14 + DateTime.now().second % 7)).toIso8601String();

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

  @override
  String toString() {
    return 'Task: { task: $taskName, isCompleted: $isCompleted, dueDt: $dueDt}';
  }
}