import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/home/categories/add_category_page.dart';
import 'package:flutter_todo_app/home/categories/category_list_item.dart';
import 'package:flutter_todo_app/models/category.dart';

class CategoriesHome extends StatefulWidget {
  const CategoriesHome({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesHomeState();
}

class _CategoriesHomeState extends State<CategoriesHome> {
  Future<List<Category>?>? categoriesFuture;
  List<Category>? categories;
  @override
  void initState(){
    super.initState();
    refreshCategories();
    categoriesFuture =  CategoryApi.getAllCategories();
  }

    Future<void> refreshCategories() async {
    final List<Category>? updatedCategories = await CategoryApi.getAllCategories();
    setState(() {
      categories = updatedCategories;
    });
  }

  Future<void> handleCategoryEdit(Category updatedCategory) async {
    final int updatedIndex = 
    categories!.indexWhere((category) => 
    category.id == updatedCategory.id);

    if (updatedIndex != -1) {
      setState(() {
        categories![updatedIndex] = updatedCategory;
      });
    }
  }


  Future<void> handleAddCategoryPress(BuildContext context) async{
      Navigator.push(
        context,
        MaterialPageRoute(
        builder: ((context) => const AddCategoryPage())
        )).then((value){
      if (value is Category){
        setState(() {
          categories?.insert(0,value);
          //categoriesFuture = CategoryApi.getAllCategories();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text("Categories", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  onPressed: (){ handleAddCategoryPress(context);},
                  child: const Text("Add new")),
            ]),
            FutureBuilder(
                future: categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No categories available"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      // itemCount: snapshot.data!.length,
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        Category category = categories![index];
                        return CategoryListItem(category: category, onCategoryUpdate: handleCategoryEdit);
                      },
                    );
                  }
                }),
          ],
        ));
  }
}
