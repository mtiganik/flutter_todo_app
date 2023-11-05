

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';

import '../../models/category.dart';

class CategoriesList extends StatefulWidget{
  const CategoriesList({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesListState();

}

class _CategoriesListState extends State<CategoriesList>{

  Future<List<Category>?>? categoriesFuture;
  @override
  void initState(){
    super.initState();
    categoriesFuture = CategoryApi.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: categoriesFuture,
     builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }else if(snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'),);
      }else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return const Center(child: Text("No categories available"));
      }else{
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index){
            Category category = snapshot.data![index];
            return ListTile(
              title: Text(category.categoryName)
            );
          },
        );
      }
     }
     );
  }

}