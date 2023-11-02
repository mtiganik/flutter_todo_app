

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/login/login_page.dart';
import 'package:provider/provider.dart';

import '../state_mgmt/auth_model.dart';

class DebugAuthPage extends StatelessWidget{
  const DebugAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: const DebugAuthPageBox(),
      ),
    );

  }

}

class DebugAuthPageBox extends StatefulWidget{
  const DebugAuthPageBox({super.key});

  @override
  State<StatefulWidget> createState() => _DebugAuthPageBox();

}

class _DebugAuthPageBox extends State<DebugAuthPageBox>{


  void handleAuthModel(AuthModel model ){
    model.setIsUserLoggedIn(true);
    Navigator.pop(context); // close debug/register page to go back loginscreen
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Auth debug"),
        Consumer<AuthModel>(builder: (context, authModel, child){
        return ElevatedButton(onPressed: () => handleAuthModel(authModel), child: Text("Test Auth"));
        }
          )
      ],
    );
  }

}