

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_app/api/api_methods/task_api.dart';
import 'package:flutter_todo_app/home/categories/edit_category_page.dart';
import 'package:flutter_todo_app/home/utils/deleteConfirmationDialog.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:flutter_todo_app/models/task.dart';

class CategoryListItem extends StatefulWidget{
  final Category category;
  const CategoryListItem({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _CategoryListItemState();
}


class _CategoryListItemState extends State<CategoryListItem>{

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.category.categoryName),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return EditCategoryPage(category: widget.category);
        }));
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: ()async {
           showDeleteConfirmationDialog(context);
          

        },
      ),
    );
  }


  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return const DeleteConfirmationDialog(
          title: "Delete Category",
          content: "Are you sure you want to delete this category?",
        );
      },
    );

    if (result != null && result) {
      print("Pressed delete");
    }
  }
}
