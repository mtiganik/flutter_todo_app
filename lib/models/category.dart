
class Category{
  final String id;
  final String categoryName;
  final int categorySort;
  final DateTime? syncDt;

  Category({required this.id, required this.categoryName, required this.categorySort, this.syncDt});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      categorySort: json['categorySort'],
      syncDt: json['syncDt'],
    );
  }

  Map<String,dynamic> toJson() => {
    'id': id,
    'categoryName':categoryName,
    'categorySort':categorySort,
    'syncDt':syncDt
  };

}