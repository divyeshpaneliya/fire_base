import 'package:fire_base/Screens/Home/view/home.dart';
import 'package:fire_base/Screens/LR_Screen/LR_Controller/lr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/space.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  var key = GlobalKey<FormState>();
  lr_con con=Get.put(lr_con());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Login"),),
        body: Form(
          key: key,
          child: Padding(
            padding:EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: txt_email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("E-mail"),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter E-mail.";
                    }
                    return null;
                  },
                ),
                H(30),
                TextFormField(
                  controller: txt_password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Password.";
                    }
                    return null;
                  },
                ),
                H(30),
                ElevatedButton(
                  onPressed: () async{
                    if (key.currentState!.validate()) {
                    //(for creat new user)  con.creat_user(txt_email.text, txt_password.text);
                      var res=await con.login_user(txt_email.text, txt_password.text);
                      //Get.snackbar("Login Status","${res}");
                    if(res=="Success"){
                      Get.offAll('/home');
                    }
                    }
                  },
                  child: Container(width: 150,child: Center(child: Text("Login"))),
                ),
                H(35),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed('/reg');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an Account? "),
                          Text(
                            "Sign up",
                            style: TextStyle(color: pink,),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//if(key.currentState!.validate())
