import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/screens/home/home_binding.dart';
import 'presentation/screens/home/home_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ContactApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
