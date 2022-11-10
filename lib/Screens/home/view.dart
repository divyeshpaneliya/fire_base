
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../author/view/author_screen.dart';
import '../note_keeper/controller/HController.dart';
import '../note_keeper/view/note_keeper.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  // String? email = Get.arguments;
  // var DateFormat;
  // var formattedDate;
  //int index=0;

  List Screen = [note_keeper(), Author()];
  HController con = Get.put(HController());

  @override
  // void initState() {
  //   super.initState();
  //   var now = DateTime.now();
  //   var formatter = DateFormat('yyyy-MM-dd');
  //   formattedDate = formatter.format(now);
  // }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: [
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.home),
              //   label: "Home",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit),
                label: "Note Keeper",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: "Auther-Reg",
              ),
            ],
            currentIndex: con.index.value,
            //selectedItemColor: Colors.amber[500],
            onTap: (value) {
              con.index.value = value.toInt();
            },
          ),
        ),
        body: Obx(
          () => Screen[con.index.value],
        ),
      ),
    );
  }
}
