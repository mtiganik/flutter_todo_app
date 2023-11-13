

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/shared_preferences_config.dart';
import 'package:flutter_todo_app/home/categories/categories_home.dart';
import 'package:flutter_todo_app/home/priorities/priorities_home.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:provider/provider.dart';

enum MenuItems {categories, priorities, logout}

class PopupMenu extends StatelessWidget{
  const PopupMenu({super.key});

  Future<void> handleLogout(AuthModel authModel, BuildContext context) async{
    await SharedPreferencesConfig().removeSharedPrefs();
    authModel.setIsUserLoggedIn(false);
  }


  @override
  Widget build(BuildContext context) {
      return Consumer<AuthModel>(builder: (context, authModel, child) {
        return PopupMenuButton<MenuItems>(

              icon: const Icon(Icons.settings,size: 32.0,color: Colors.white),
              onSelected: (MenuItems result){
                if(result == MenuItems.categories){
                  Navigator.push(context,MaterialPageRoute(builder: ((context) => const CategoriesHome())));
                }else if(result == MenuItems.priorities){
                  Navigator.push(context,MaterialPageRoute(builder: ((context) => const PrioritiesHome())));
                }
                else if(result == MenuItems.logout){
                  handleLogout(authModel, context);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItems>>[
                const PopupMenuItem<MenuItems>(
                  value: MenuItems.categories,
                  child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.category),
                              ),
                              Text(
                                'Categories',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                  ),
                const PopupMenuItem(
                  value: MenuItems.priorities,
                  child: Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.assistant_photo),
                              ),
                              Text(
                                'Priorities',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                  ),
                const PopupMenuItem(
                  value: MenuItems.logout,
                  child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.logout),
                              ),
                              Text(
                                'Logout',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                  ),
              ]
              );
              });

  }

}

