

class Priority{
  final String id;
  final String priorityName;
  final int prioritySort;
  final DateTime? syncDt;

  Priority({required this.id, 
  required this.priorityName, required this.prioritySort,
  this.syncDt});

  factory Priority.fromJson(Map<String, dynamic> json){
    return Priority(
      id: json['id'],
      priorityName: json['priorityName'],
      prioritySort: json['prioritySort'],
      syncDt: json['syncDt']
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'priorityName' : priorityName,
    'prioritySort' : prioritySort,
    'syncDt' : syncDt
   };
}