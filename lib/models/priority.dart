

class Priority{
  final String id;
  final String priorityName;
  final int prioritySort;
  final DateTime? syncDt;

  Priority({required this.id, 
  required this.priorityName, required this.prioritySort, DateTime? syncDt }) : syncDt =syncDt?? DateTime.now();

  factory Priority.fromJson(Map<String, dynamic> json){
    return Priority(
      id: json['id'],
      priorityName: json['priorityName'],
      prioritySort: json['prioritySort'],
      syncDt: DateTime.fromMillisecondsSinceEpoch(json['syncDt'])
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'priorityName' : priorityName,
    'prioritySort' : prioritySort,
    'syncDt' : syncDt?.millisecondsSinceEpoch,
   };

   @override
   String toString(){
    return 'priority: {priorityName: $priorityName, id: $id, syncDt: $syncDt}';
   }
}