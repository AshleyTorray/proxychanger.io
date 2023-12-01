import 'package:flutter/material.dart';
import '../components/torray_textfield.dart';
import '../components/torray_button.dart';
import 'package:get/route_manager.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final serverUrlController = TextEditingController();
  final passController = TextEditingController();

  SignUp()
  {
    Get.off(() => HomeScreen());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:  AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "ProxyServer",
                ),
                Tab(
                  text: "ProxyPin",
                ),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
           body: TabBarView(
             children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TorrayTextField(controller: serverUrlController, hint: "server_url", password: false),
                    TorrayTextField(controller: passController, hint: "password", password: true),                    
                    TorrayButton(onTap: SignUp, name: "Sign Up")
                  ],
                ),
              ),
              Text("asdsd")
             ],
          ),
        ),
      ),
    );
  }
}