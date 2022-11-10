import 'package:fire_base/Screens/LR_Screen/Register/register_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/LR_Screen/Login/view/login.dart';
import 'Screens/author/view/author_screen.dart';
import 'Screens/home/view.dart';
import 'Screens/note_keeper/view/note_keeper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    getPages: [
      GetPage(
        name: '/',
        page: () => login(),
      ),
      GetPage(
        name: '/home',
        page: () => home(),
      ),
      GetPage(
        name: '/note',
        page: () => note_keeper(),
      ),
      GetPage(
        name: '/reg',
        page: () => register(),
      ),
      GetPage(
        name: '/author',
        page: () => Author(),
      ),
    ],
  ));
}
