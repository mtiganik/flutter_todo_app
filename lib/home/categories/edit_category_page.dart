

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/models/category.dart';

class EditCategoryPage extends StatefulWidget{
  final Category category;
  const EditCategoryPage({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _EditCategoryState();

}

class _EditCategoryState extends State<EditCategoryPage>{

  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final categorySortController = TextEditingController();

Future<Category?> updateCategory() async{
  Category newCategory = Category(
    id: widget.category.id,
    categoryName: categoryNameController.text,
    categorySort: int.parse(categorySortController.text),
  );
  var response = await CategoryApi.updateCategory(newCategory);
  if (response >= 200 && response < 300) {return newCategory;}
  else {return null;}
}

  Future<void> handleEditButtonPress() async{
    if(_formKey.currentState!.validate()){
      var updatedCategory = await updateCategory();
      if(context.mounted){
        if(updatedCategory == null){
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error editing category')));

        }else{
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated category')));
        Navigator.pop(context, updatedCategory);

        }
      }
    }
  }

  @override
  void initState(){
    super.initState();
    categoryNameController.text = widget.category.categoryName;
    categorySortController.text = widget.category.categorySort.toString();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit ${widget.category.categoryName} category'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: categoryNameController,
              decoration: const InputDecoration(labelText: 'Category Name'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter a category name';
                }return null;
              }
            ),
            const SizedBox( height: 16),
            TextFormField(
              controller: categorySortController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Category sort'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter a category sort';
                }return null;
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: handleEditButtonPress,
                child: const Text('Save Changes'),
              )
            
          ]),
      )
    )
  );
  }

    @override
  void dispose(){
    categoryNameController.dispose();
    categorySortController.dispose();
    super.dispose();
  }


}