
class Task{
  final String id;
  final String taskName;
  final int? taskSort;
  final DateTime? createdDt;
  final DateTime? dueDt;
  final bool isCompleted;
  final bool? isArchieved;
  final String categoryId;
  final String priorityId;
  final DateTime? syncDt;

  Task({
    required this.id,
    required this.taskName,
    required this.isCompleted,
    required this.categoryId,
    required this.priorityId,
    DateTime? createdDt,
    DateTime? dueDt,
    DateTime? syncDt,
    this.isArchieved,
    this.taskSort
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
      isCompleted: json['isCompleted'],
      isArchieved: json['isArchieved'],
      categoryId: json['categoryId'],
      priorityId: json['priorityId'],
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
      'isArchieved': isArchieved,
      'categoryId':categoryId,
      'priorityId':priorityId,
      'syncDt':syncDt?.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'Task: {id: $id, taskname: $taskName, categoryId: $categoryId, priorityId: $priorityId}, dueDt: $dueDt}';
  }
}