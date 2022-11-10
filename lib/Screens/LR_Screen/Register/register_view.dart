import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart';
import '../../../utils/space.dart';
import '../LR_Controller/lr_controller.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  var key = GlobalKey<FormState>();
  lr_con con = Get.put(lr_con());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Regiter"),
        ),
        body: Form(
          key: key,
          child: Padding(
            padding: EdgeInsets.all(10.0),
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
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      var res = await con.creat_user(
                          txt_email.text, txt_password.text);
                      // var data = Get.snackbar(
                      //     snackPosition: SnackPosition.BOTTOM,
                      //     showProgressIndicator: false,
                      //     isDismissible: true,
                      //     "Status",
                      //     "${res}");
                      if (res == "Success") {
                       //data.close(withAnimations: true);
                        Get.back();
                      }
                    }
                  },
                  child: Container(
                      width: 150, child: Center(child: Text("Register"))),
                ),
                H(35),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already exitsting? "),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: pink,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
