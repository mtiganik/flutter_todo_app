import 'package:flutter/material.dart';
import 'package:flutter_todo_app/db/db_debug.dart';
import 'package:flutter_todo_app/home/home_screen.dart';
import 'package:flutter_todo_app/login/login_page.dart';
import 'package:flutter_todo_app/login/register_page.dart';
import 'package:flutter_todo_app/state_mgmt/auth_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [ChangeNotifierProvider(create: (context) => AuthModel())],
        child: MaterialApp(
            title: 'Flutter App',
            initialRoute: '/',
            routes:{
              '/': (context) => Consumer<AuthModel>(
                builder: (context, authModel, child){
                  if(!authModel.isInitilized()){
                    return const CircularProgressIndicator();
                  } else {
                    return authModel.isUserLoggedIn()
                        ? const HomeScreen()
                        : const LoginPage();
                  }
                }
              ),
              '/main' : (context) => const HomeScreen()
            },
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: true),
            )
            );
  }
}

