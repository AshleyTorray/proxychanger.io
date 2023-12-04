
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstore/localstore.dart';
// import 'package:get/get.dart';
// import '../components/torray_textfield.dart';
// import '../components/torray_button.dart';
import 'package:get/route_manager.dart';
import '../helpers/my_dialog.dart';
import 'home_screen.dart';
import '../apis/apis.dart';
import 'dart:io' show Platform;

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

  
class _LoginState extends State<Login> {

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

   late double imgSizeDivider,
      sizedBoxRatio,
      font1,
      font2,
      buttonFont,
      buttonBottomPadding,
      _height,
      topMargin;
  late bool isEmailValid = false,
      isPasswordValid = false,
      isButtonEnabled = false;

  @override
  void initState()
  {
    _focusNode1.addListener(() { 
      if(_focusNode1.hasFocus){
        setState(() {
        });
      }
    });
    _focusNode2.addListener(() { 
      if(_focusNode2.hasFocus){
        setState(() {
        });
      }
    });
    super.initState();
  }

  final userEmailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose(){
    userEmailController.dispose();
    passController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    final db  = Localstore.instance;
    Size mq = MediaQuery.of(context).size;
    String emailRegExp =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";


    //RWD construct
    if (Platform.isAndroid) {
      if (mq.height > 851) {
        imgSizeDivider = 1;
        sizedBoxRatio = 1.2;
        font1 = 30;
        font2 = 20;
        buttonFont = 18;
        buttonBottomPadding = 0;
        topMargin = 10;
      } else if (mq.height > 660) {
        imgSizeDivider = 1.2;
        sizedBoxRatio = 1.5;
        font1 = 25;
        font2 = 20;
        buttonFont = 15;
        buttonBottomPadding = 10;
        topMargin = 10;
      } else {
        imgSizeDivider = 1.3;
        sizedBoxRatio = 1;
        font1 = 20;
        font2 = 18;
        buttonFont = 14;
        buttonBottomPadding = 10;
        topMargin = 10;
      }
    }
    if (Platform.isIOS) {
      if (mq.height > 812) {
        imgSizeDivider = 1;
        sizedBoxRatio = 1;
        font1 = 30;
        font2 = 20;
        buttonFont = 18;
        buttonBottomPadding = 0;
        topMargin = 0;
      } else if (mq.height > 660) {
        imgSizeDivider = 1.2;
        sizedBoxRatio = 1.5;
        font1 = 25;
        font2 = 20;
        buttonFont = 15;
        buttonBottomPadding = 10;
        topMargin = 0;
      } else {
        imgSizeDivider = 1.3;
        sizedBoxRatio = 1;
        font1 = 20;
        font2 = 18;
        buttonFont = 14;
        buttonBottomPadding = 10;
        topMargin = 0;
      }
    }
    // email & pass focus
    if (_focusNode1.hasFocus || _focusNode2.hasFocus) {
      _height = 0;
    } else {
      _height = mq.height / 2.2 / imgSizeDivider;
    }

    //enable flag (edit of email, pass, login button)
    void checkButtonConditions() {
      if (userEmailController.text != "" &&
          passController.text != "" &&
          isEmailValid &&
          isPasswordValid) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
      setState(() {});
    }
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xff17093A),
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
            title: const Text('PROXYCHANGER'),
          ),
           body: TabBarView(
             children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Positioned(
                    //   bottom: mq.height * .10,
                    //   width: mq.width,
                    //   child: TorrayTextField(
                    //     controller: userEmailController, 
                    //     hint: "Email", 
                    //     password: false,
                    //     )),
                    // Positioned(
                    //   bottom: mq.height * .12,
                    //   width: mq.width,
                    //   child: TorrayTextField(
                    //     controller: passController, 
                    //     hint: "password", 
                    //     password: false
                    //     )),
                    // Positioned(
                    //   bottom: mq.height * .14,
                    //   width: mq.width,
                    //   child: TorrayButton(onTap: () async{
                    //     var response;
                    //     try{
                    //       response = await loginUser(passController.text);
                    //       MyDialogs.success(msg: "user login ok");
                    //       // Get.off(() => HomeScreen());
                    //     }
                    //     catch(e)
                    //     {
                    //       MyDialogs.error(msg: "server error");
                    //     }
                    //     // if(response['error'])
                    //     // {
                          
                    //     // }
                    //     // else{
                    //     //   Get.off(() => HomeScreen());
                    //     // }
                    //     Get.off(() => HomeScreen());
                    //   }, name: "Sign Up"))                    
                    // SizedBox(
                    //   height: topMargin,
                    // ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: _height / 3,
                      child: Image.asset(
                        "assets/images/login-log.png",
                        alignment: Alignment.topCenter,
                        width: MediaQuery.of(context).size.width / imgSizeDivider,
                      ),
                    ),
                    Align(
                      
                      alignment: Alignment.topLeft,
                      child: Text(
                        
                        "Hello Welcome back",
                        style: TextStyle(
                          
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: font1,
                            height: 1.2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login to Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            height: 1.8,
                            fontSize: font2,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(height: sizedBoxRatio * 10),
                    Container(
                      margin:EdgeInsets.all(10),
                       decoration: BoxDecoration(
                        color: Color.fromARGB(255, 2, 204, 240),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextField(
                        onChanged: (text) {
                          if (RegExp(emailRegExp).hasMatch(text)) {
                            isEmailValid = true;
                          } else {
                            isEmailValid = false;
                          }
                          checkButtonConditions();
                          setState(() {});
                        },
                        controller: userEmailController,
                        focusNode: _focusNode1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 0,
                                  alignment: Alignment.bottomCenter,
                                  height: 0,
                                  child: Icon(
                                      isEmailValid
                                          ? IconData(0xe802, fontFamily: 'CustomIcons', fontPackage: null)
                                          : IconData(0xe803, fontFamily: 'CustomIcons', fontPackage: null),
                                      size: 25,
                                      color: (userEmailController.text == "")
                                          ? Color(0xff202960)
                                          : isEmailValid
                                              ? Color(0xff53A2FF)
                                              : Color(0xffFF5353)))),
                          border: InputBorder.none,
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Color(0xffFFFFFF).withOpacity(0.5)),
                        ),
                        style: TextStyle(
                          color: isEmailValid ? Color(0xffFFFFFF) : Color(0xffFF5353),
                          fontWeight: FontWeight.w400,
                          fontSize: buttonFont,
                          height: 1.8),
                      ),
                    ),
                    SizedBox(height: sizedBoxRatio * 10),
                    Container(
                      margin:EdgeInsets.all(10),
                       decoration: BoxDecoration(
                        color: Color.fromARGB(255, 2, 204, 240),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        onChanged: (text) {
                           isPasswordValid = true;
                            checkButtonConditions();
                            setState(() {});
                        },
                        controller: passController,
                        focusNode: _focusNode2,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 0,
                                  alignment: Alignment.bottomCenter,
                                  height: 0,
                                  child: Icon(
                                      isPasswordValid
                                          ? IconData(0xe802, fontFamily: 'CustomIcons', fontPackage: null)
                                          : IconData(0xe803, fontFamily: 'CustomIcons', fontPackage: null),
                                      size: 25,
                                      color: (passController.text == "")
                                          ? Color(0xff202960)
                                          : isPasswordValid
                                              ? Color(0xff53A2FF)
                                              : Color(0xffFF5353)))),
                          border: InputBorder.none,
                          labelText: 'password',
                          labelStyle:
                              TextStyle(color: Color(0xffFFFFFF).withOpacity(0.5)),
                        ),
                        style: TextStyle(
                          color: isPasswordValid ? Color(0xffFFFFFF) : Color(0xffFF5353),
                          fontWeight: FontWeight.w400,
                          fontSize: buttonFont,
                          height: 1.8),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 10, right: 10, top:10,bottom: buttonBottomPadding),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26,
                                
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            colors: [
                              isButtonEnabled ? Color(0xff416FF7) : Color(0xff202960),
                              isButtonEnabled ? Color(0xff58B8EA) : Color(0xff202960),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                                  // if (!isButtonEnabled) {
                                  //   return;
                                  // }
                                  // // ignore: prefer_typing_uninitialized_variables
                                  // var response;
                                  // try {
                                  //   // response = await loginUser(
                                  //   //     userEmailController.text, passController.text);
                                  //   response = await loginUser(passController.text);
                                  // } catch (e) {
                                  //   return MyDialogs.error(msg:"Service is unavaliable")
                                  //       .show(context);
                                  // }
                                  // if (response["error"]) {
                                  //   isPasswordValid = false;
                                  //   // ignore: use_build_context_synchronously
                                  //   MyDialogs.error(msg: response["result"]).show(context);
                                  // } else {
                                  //   isPasswordValid = true;
                                  //   var userData = {
                                  //     'token': response["result"]["token"],
                                  //     'email': response["result"]["email"],
                                  //     'isPremium': response["result"]["isPremium"],
                                  //     'subscriptionEndDate': response["result"]
                                  //         ["subscriptionEndDate"]
                                  //   };
                                  //   db.collection('account').doc("0").set(userData);
                                  //   // ignore: use_build_context_synchronously
                                  //   Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     CupertinoPageRoute(
                                  //         builder: (context) => HomeScreen()),
                                  //     (Route<dynamic> route) => false,
                                  //   );
                                  //   //user: userData
                                  // }
                                  MyDialogs.success(msg: "Login success");
                                  Get.off(()=> HomeScreen());
                                  checkButtonConditions();
                                  setState(() {});
                                },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 20.0)),
                          ),
                          child: Text(
                            "LOG IN",
                            style: TextStyle(
                                color: isButtonEnabled
                                    ? Color(0xffFFFFFF)
                                    : Color(0xffFFFFFF).withOpacity(0.5),
                                fontSize: buttonFont,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
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