
class Task{
  final String id;
  final String taskName;
  final int? taskSort;
  final int? createdDt;
  final int? dueDt;
  final bool isCompleted;
  final bool? isArchieved;
  final String categoryId;
  final String priorityId;
  final int? syncDt;

  Task({
    required this.id,
    required this.taskName,
    required this.isCompleted,
    required this.categoryId,
    required this.priorityId,
    this.createdDt,
    this.dueDt,
    this.isArchieved,
    this.syncDt,
    this.taskSort
  });

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json['id'],
      taskName: json['taskName'],
      taskSort: json['taskSort'],
      createdDt: json['createdDt'],
      dueDt: json['dueDt'],
      isCompleted: json['isCompleted'],
      isArchieved: json['isArchieved'],
      categoryId: json['categoryId'],
      priorityId: json['priorityId'],
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
      'isArchieved': isArchieved,
      'categoryId':categoryId,
      'priorityId':priorityId,
      'syncDt':syncDt
    };
  }

  @override
  String toString() {
    return '{id: $id, taskname: $taskName, categoryId: $categoryId, priorityId: $priorityId}';
  }
}