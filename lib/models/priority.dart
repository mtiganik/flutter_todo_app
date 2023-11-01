

class Priority{
  final String id;
  final String priorityName;
  final int prioritySort;
  final String? syncDt;

  Priority({required this.id, 
  required this.priorityName, required this.prioritySort, String? syncDt }) : syncDt =syncDt?? DateTime.now().toIso8601String();

  factory Priority.fromJson(Map<String, dynamic> json){
    return Priority(
      id: json['id'],
      priorityName: json['priorityName'],
      prioritySort: json['prioritySort'],
      syncDt: json['syncDt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'priorityName' : priorityName,
    'prioritySort' : prioritySort,
    'syncDt' : syncDt,
   };

   @override
   String toString(){
    return 'priority: {priorityName: $priorityName, id: $id, syncDt: $syncDt}';
   }
}