import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/api_methods/category_api.dart';
import 'package:flutter_todo_app/models/category.dart';
import 'package:uuid/uuid.dart';

class AddCategoryPage extends StatefulWidget{

  const AddCategoryPage({super.key});
  @override
  State<StatefulWidget> createState() => _AddCategoryPageState();

}
class _AddCategoryPageState extends State<AddCategoryPage>{

  final _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  final categorySortController = TextEditingController();

  Future<bool> handleDataAdd() async{

    Category cat = Category(
      id: const Uuid().v4(),
      categoryName: categoryNameController.text,
      categorySort: int.parse(categorySortController.text)
      );

    var result = await CategoryApi.addCategory(cat);
    if(result == 201){return true;}
    else {return false;}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text("Add Category", style: TextStyle(color:Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Category Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            TextFormField(
              controller:categoryNameController,
              validator: (value){
                if (value == null || value.isEmpty){
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter category name",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Category Sort", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
            TextFormField(
              controller: categorySortController,
              keyboardType:TextInputType.number,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Invalid input";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Enter category sort"
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async{
                if(_formKey.currentState!.validate()){

                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  var postResult = await handleDataAdd();
                  if (context.mounted) {
                    if (postResult) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('New category added ')));
                      Navigator.pop(context,true); // if return with true, then refresh prev page
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Error adding new category ')));
                    }
                  }

                }
              }, 
              child: const Text("Add category"))
          ],
        )
      )
    ));
  }
  
  @override
  void dispose(){
    categoryNameController.dispose();
    categorySortController.dispose();
    super.dispose();
  }
}