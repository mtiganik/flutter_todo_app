
class Task{
  final String id;
  final String taskName;
  final int? taskSort;
  final DateTime? createdDt;
  final DateTime? dueDt;
  final bool isCompleted;
  final bool? isArchived;
  final String todoCategoryId;
  final String todoPriorityId;
  final DateTime? syncDt;

  Task({
    required this.id,
    required this.taskName,
    required this.isCompleted,
    required this.todoCategoryId,
    required this.todoPriorityId,
    DateTime? createdDt,
    DateTime? dueDt,
    DateTime? syncDt,
    this.isArchived = false,
    this.taskSort = 0,
  }) : createdDt = createdDt ?? DateTime.now(),
  syncDt = syncDt ?? DateTime.now(),
  dueDt = dueDt ?? DateTime.now().add(Duration(days: 14 + DateTime.now().second % 7));

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['id'],
      taskName: json['taskName'],
      taskSort: json['taskSort'],
      createdDt: DateTime.fromMillisecondsSinceEpoch(json['createdDt']),
      dueDt: DateTime.fromMillisecondsSinceEpoch(json['dueDt']),
      isCompleted: json['isCompleted'] == 0 ? false: true,
      isArchived: json['isArchived'] == 0 ? false: true,
      todoCategoryId: json['todoCategoryId'],
      todoPriorityId: json['todoPriorityId'],
      syncDt: DateTime.fromMillisecondsSinceEpoch(json['syncDt'])
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'id': id,
      'taskName': taskName,
      'taskSort': taskSort,
      'createdDt': createdDt?.millisecondsSinceEpoch,
      'dueDt': dueDt?.millisecondsSinceEpoch,
      'isCompleted': isCompleted,
      'isArchived': isArchived,
      'todoCategoryId':todoCategoryId,
      'todoPriorityId':todoPriorityId,
      'syncDt':syncDt?.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'Task: {id: $id, taskname: $taskName, categoryId: $todoCategoryId, priorityId: $todoPriorityId}, dueDt: $dueDt}';
  }
}