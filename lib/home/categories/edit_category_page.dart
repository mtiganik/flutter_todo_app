

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/category.dart';

class EditCategoryPage extends StatefulWidget{
  final Category category;
  const EditCategoryPage({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _EditCategoryState();

}

class _EditCategoryState extends State<EditCategoryPage>{
  @override
  Widget build(BuildContext context) {
  return Text("Edit page of category: daily commit 2nd time ${widget.category.categoryName}");
  }

}