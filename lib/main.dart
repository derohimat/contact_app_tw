// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/services/secure_storage_service.dart';
import 'presentation/screens/home/home_binding.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/login/login_binding.dart';
import 'presentation/screens/login/login_screen.dart';
import 'presentation/screens/profile/profile_binding.dart';
import 'presentation/screens/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? loggedInUserId = await SecureStorageService.getLoggedInUserId();
  runApp(MyApp(loggedInUserId: loggedInUserId));
}

class MyApp extends StatelessWidget {
  final String? loggedInUserId;

  const MyApp({super.key, this.loggedInUserId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: loggedInUserId != null ? '/home' : '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginScreen(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          binding: ProfileBinding(),
        ),
      ],
    );
  }
}
